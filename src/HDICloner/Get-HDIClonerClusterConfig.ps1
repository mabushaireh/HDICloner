<#
.Synopsis
    .
.DESCRIPTION
   
       
.EXAMPLE
    
    
.EXAMPLE
    
.LINK
    https://github.com/mabushaireh/HDICloner
#>

function Get-HDIClonerClusterConfig {
    
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory = $true, ParameterSetName = "Main", HelpMessage = "Source Cluster Dns Name")]
        [string] $SourceCluster,

        [Parameter(Mandatory = $false, ParameterSetName = "Main", HelpMessage = "Source Cluster Subscription Id, if not provided will locate the cluster in the cueect azure account context")]
        [string] $SourceSubId,

        [Parameter(Mandatory = $true, ParameterSetName = "Main", HelpMessage = "Ambari Username")]
        [string]
        $Username,

        [Parameter(Mandatory = $true, ParameterSetName = "Main", HelpMessage = "Ambari Password")]
        [string]
        $Password
    )


    Show-Info "Getting Azure Resources for Cluster $SourceCluster"

    $dependencies = Ger-AzureUtilsHdiDependencies $SourceCluster

    $subId = (Get-AzContext).Subscription.Id
    $ArmPath = Get-PathFor -SubscriptionId $subId -ClusterDnsName $SourceCluster -ConfigArea ARM

    Export-AzureUtilsResource -ResourceName $SourceCluster -Path $ArmPath

    #Export Storage

    $storageName =  $dependencies.Storage.substring(0, $dependencies.Storage.IndexOf("."))
    Export-AzureUtilsResource -ResourceName $storageName -Path $ArmPath


    #get ambari configs

    $configs = Get-AmbariUtilsConfig -ClustDnsName $sourceCluster -Username $Username -Password $Password

    $path = Get-PathFor -SubscriptionId $subId -ClusterDnsName $SourceCluster -ConfigArea HDP

    foreach ($config in $configs.Keys) {
        $folder = ""
        if ($config -like "*log4j*"){
            $folder = "Log4j"
        } elseif ($config -like "*env"){
            $folder = "ENV"
        } else {
            $folder = "CONFIG"
        }

        Show-Debug ("Writing to path: [$path\$folder\$config.json]")
        $configs[$config] | Set-Content "$path\$folder\$config.json"
    }

}
