<#
.Synopsis
    Utility function to manubilate HdiCluster
.DESCRIPTION
   This function takes.
   
.EXAMPLE
    ## To be added.
    
.LINK
    https://github.com/mabushaireh/HDICloner
#>


function Get-HdiUtilsClusterDependencies {
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory = $true)] [string] $clusterDnsName
    )

    $cluster = Get-AzHDInsightCluster -ClusterName $clusterDnsName

    if (!$cluster){
        Show-Error "Cluster $clusterDnsName doesnt exist!"
    }

    return @{
        Storage = $cluster.DefaultStorageAccount ;
        Network =  $cluster.VirtualNetworkId;
        Submet = $cluster.SubnetName
    }
}