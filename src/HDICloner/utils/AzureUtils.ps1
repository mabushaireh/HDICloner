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

function Deploy-ArmResource {
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory = $false)] [string] $SubscriptionId,
        [Parameter(Mandatory = $true)] [string] $ResourceGroupName,
        [Parameter(Mandatory = $true)] [string] $Arm,
        [Parameter(Mandatory = $true)] [string] $Name
    )

    Show-Debug "Passed value for SubscriptionId is set to $SubscriptionId"
    Show-Debug "Passed value for ResourceGroupName is set to $ResourceGroupName"
    Show-Debug "Passed value for Arm is set to $Arm"

    Show-Debug "Checking if Resource Group already exists.."

    $rs = Get-AzResourceGroup -Name $ResourceGroupName


    if (!$rs){
        Show-Warn "Resource Group $ResourceGroupName doesnt exists. Creating it."

        New-AzResourceGroup -Name $ResourceGroupName

        Show-Info "Resource Group $ResourceGroupName created!"
    }

    Show-Info "Deployment $Name started!"
    $TemplateObject = ConvertFrom-Json $TemplateFileText -AsHashtable
    New-AzResourceGroupDeployment -Name $Name -ResourceGroupName $ResourceGroupName -Mode Incremental -TemplateParameterObject $TemplateObject


}