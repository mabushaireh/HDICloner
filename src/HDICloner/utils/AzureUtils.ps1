<#
.Synopsis
    Utility function to for Azure
.DESCRIPTION
   This function takes the cluster DNS name and type and fetches the relevant Hadoop configs
   
.EXAMPLE
    ## To be added.
    
.LINK
    https://github.com/mabushaireh/HDICloner
#>

function Get-AzureUtilsAccount($SubscriptionId) {

    Show-Debug "Passed value for SubscriptionId is set to $SubscriptionId"

    if (!$SubscriptionId) {
        Show-Warning "Default Subscription is going to be used!"
    }

    Show-Debug "Check if user already signed in to Azure Account!"

    $context = Get-AzContext

    if (!$context) {
        Show-Debug "Current Session is not logged to any Azure Account"
        Show-Prompt "Please login to your Azure Account"
        if ($SubscriptionId) {
            Show-Debug "Logging and selecting Subscription '$SubscriptionId'"
            $context = Connect-AzAccount -Subscription $SubscriptionId
            Show-Info "Subscription '$SubscriptionId' selected"
        }
        else {
            $context = Connect-AzAccount
            Show-Info "Subscription '$context.SubscriptionId' selected"
        }
    } 
    else {
        Show-Debug "Current Session has already logged to an Azure Account"
        if ($SubscriptionId) {
            if ($context.Subscription.Id -eq $SubscriptionId) {
                Show-Info "Subscription '" + $context.Subscription.Id + "' already selected."
            }
            else {
                Show-Debug "Subscription $SubscriptionId is not selected"
                $context = Select-AzSubscription $SubscriptionId
                Show-Info "Subscription $SubscriptionId is selected"
            }
        }
        else {
            Show-Info ("Subscription '" + $context.Subscription.Id + "' is selected.")
        }
    }

    return $context
}

function Deploy-AzureUtilsResource {
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory = $true)] [string] $ResourceGroupName,
        [Parameter(Mandatory = $true)] [string] $ClusterDnsName,
        [Parameter(Mandatory = $true)] [string] $Arm,
        [Parameter(Mandatory = $true)] [string] $DeploymentName,
        [Parameter(Mandatory = $true)] [Hashtable] $Params
    )

    $temp = ConvertTo-Json $Params -Depth 100

    Show-Debug "Passed value for ResourceGroupName is set to $ResourceGroupName"
    Show-Debug "Passed value for Arm is set to $Arm"
    Show-Debug "Passed value for Name is set to $Name"
    Show-Debug "Passed value for params is set to $temp"
    
    

    Show-Debug "Checking if Resource Group already exists.."

    $rs = Get-AzResourceGroup -Name $ResourceGroupName


    if (!$rs){
        Show-Warning "Resource Group $ResourceGroupName doesnt exists. Creating it."
        
        #TODO: get Cluster Location
        New-AzResourceGroup -Name $ResourceGroupName -Location "West Europe"

        Show-Info "Resource Group $ResourceGroupName created!"
    }

    $TemplateObject = ConvertFrom-Json $Arm -AsHashtable

    #Prepare-ArmTemplate ($TemplateObject["resources"])[0] $TemplateObject 

    Show-Info "Prepare Arm template for new deployment"
    
    switch -Exact ((($TemplateObject["resources"])[0])["type"]) {
        'Microsoft.HDInsight/clusters' {
            # Chekc if params are correct
            # Cluster Dns Name
            # Storage Name
            # ambari username and password
            # ssh password
            # Network Profile (Optional)


            ($TemplateObject["resources"])[0]["name"] = $ClusterDnsName
            Show-Debug "Delete blueprint"
            (((($TemplateObject["resources"])[0])["properties"])["clusterDefinition"]).Remove("blueprint")

            Show-Debug "blueprint properties removed"

            #add hduserPassword
            $hduserPassword = @{
                "gateway" = @{
                    "restAuthCredential.isEnabled" = "true"
                    "restAuthCredential.username" = $Params["hduser"]
                    "restAuthCredential.password" = $Params["hdpassword"]
                }
            }
            
            (((($TemplateObject["resources"])[0])["properties"])["clusterDefinition"]).Add("configurations", $hduserPassword)

            #add SshPassword
            (((((($TemplateObject["resources"])[0])["properties"])["computeProfile"])["roles"][0])["osProfile"])["linuxOperatingSystemProfile"].Add("password", $Params["sshpassword"])            
            (((((($TemplateObject["resources"])[0])["properties"])["computeProfile"])["roles"][1])["osProfile"])["linuxOperatingSystemProfile"].Add("password", $Params["sshpassword"])            
            (((((($TemplateObject["resources"])[0])["properties"])["computeProfile"])["roles"][2])["osProfile"])["linuxOperatingSystemProfile"].Add("password", $Params["sshpassword"]) 


            #Add storage Profile Key
            $TemplateObject["resources"][0]["properties"]["storageProfile"]["storageaccounts"][0].Add("key", "[listKeys('" + $Params["storageResourceId"] + "', '2015-05-01-preview').key1]") 

            if ($params.Contains("container")){
                $TemplateObject["resources"][0]["properties"]["storageProfile"]["storageaccounts"][0]["container"] = $Params["container"]
            }
        }
    }
    
    $temp = ConvertTo-Json $TemplateObject -Depth 100
    Show-Debug "Template after preparation $temp"

    Show-Info "Deployment $Name started!"
    New-AzResourceGroupDeployment -Name $DeploymentName -ResourceGroupName $ResourceGroupName -Mode Incremental -TemplateObject $TemplateObject
}


function Export-AzureUtilsResource {
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory = $true)] [string] $ResourceName,
        [Parameter(Mandatory = $true)] [string] $Path
    )

    Show-Debug "ResourceName set to  $ResourceName"

    Show-Info "Get Reosurce Resource Gruop"

    $rs = Get-AzResource -Name $ResourceName

    if (!$rs)
    {
        Show-Error "Resource $ResourceName not found!"
        return
    }

    Show-Info "Exporting " + $rs.Name +" of type [" + $rs.ResourceType + "]"
    Export-AzResourceGroup -ResourceGroupName $rs.ResourceGroupName -Resource $rs.ResourceId -SkipAllParameterization -IncludeComments -Path $Path -Force
}
