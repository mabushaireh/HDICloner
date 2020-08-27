<#
.Synopsis
    Utility function to fetch cluster's hadoop configs based on the cluster type
.DESCRIPTION
   This function takes the cluster DNS name and type and fetches the relevant Hadoop configs,
   For now the configs to fetch are the ones that can be modified directly in the ARM template, as below
   clusterIdentity.xml, core-site.xml, gateway.xml, hbase-env.xml, hbase-site.xml, hdfs-site.xml
   hive-env.xml, hive-site.xml, mapred-site, oozie-site.xml, oozie-env.xml, storm-site.xml, tez-site.xml
   webhcat-site.xml, yarn-site.xml, spark2-defaults, etc...
   
.EXAMPLE
    ## To be added.
    
.LINK
    https://github.com/mabushaireh/HDICloner
#>


function Create-FolderIfNotExist($folderName, $path)
{

    Show-Debug "Passed value for folderName is $folderName"
    Show-Debug "Passed value for path is $path"

    Show-Info "Creating Folder $path\$folderName"
    if (-Not (Test-Path $path)) {
        Show-Error "Folder $path not found!"
        throw "Folder $path not found!"
    }


    if (Test-Path "$path\$folderName") {
        Show-Warning "Folder $path\$folderName already exits!"
        return
    }
    
    $null = New-Item -Path "$path\$folderName" -ItemType Directory
    Show-Info "Folder $path\$folderName is created"
}