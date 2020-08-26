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
        [string] $SourceSubId
    )


    Write-Output "Getting Azure Resources for Cluster $SourceCluster"

}
