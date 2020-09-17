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



#TODO: Get the last version by the user and the last version after Cluster creation, Compare two versions and show the changes only.
function Get-AmbariUtilsConfig {
            # Read cluster DNS name and required HDP configs from Main
            # Fetch the relevant configs
    [CmdletBinding()]
    param 
    (  
        [Parameter(Mandatory = $true, ParameterSetName = "Main", HelpMessage = "Cluster Dns Name")]
        [string]
        $ClustDnsName,  
        [Parameter(Mandatory = $true, ParameterSetName = "Main", HelpMessage = "Ambari Username")]
        [string]
        $Username,

        [Parameter(Mandatory = $true, ParameterSetName = "Main", HelpMessage = "Ambari Password")]
        [string]
        $Password
    )
    Show-Debug "Value set for ClustDnsName is $ClustDnsName"
    Show-Debug "Value set for Username is $Username"
    Show-Debug "Value set for Password is $Password"

    Show-Info "Attempting to fetch relevant configs for cluster name $ClustDnsName"

    #Use the below to avoid manual prompt for password when calling Ambari API.
    $SecPasswd = ConvertTo-SecureString $Password -AsPlainText -Force
    $Credentials = New-Object System.Management.Automation.PSCredential($Username, $SecPasswd)

    ## Subject to change, first fetch the common configs, then get the ones relevant to cluster type
    #TODO: Try to get the differences in the files.
    # Find a Way to use $credential param containing user/password to avoid extra prompt for password.

    $HTTPSUri = "https://$ClustDnsName.azurehdinsight.net/api/v1/clusters/$ClustDnsName/configurations"

    $HDPConfigVersions = (Invoke-WebRequest -Uri $HTTPSUri  -Credential $Credentials -UseBasicParsing).Content
    Show-Debug $HDPConfigVersions
    $versions = ConvertFrom-Json $HDPConfigVersions -AsHashtable

    $lastVersion = ($versions["items"][$versions["items"].Count-1]).tag

    $configs = @{}
    foreach ($version in $versions["items"]){
        
        if ($version.tag -eq $lastVersion){
            Show-Debug ("Get Configuration type [" + $version.type + "] for latest version [" + $version.tag + "]")
            $HTTPSUri = "https://$ClustDnsName.azurehdinsight.net/api/v1/clusters/$ClustDnsName/configurations?tag=$lastVersion&type=" + $version.type
            $result = (Invoke-WebRequest -Uri $HTTPSUri  -Credential $Credentials -UseBasicParsing).Content
            $configs.Add($version.type, $result)
        }
    }
    return $configs

}


#TODO: OPTION 1: Function to return the Service Requested for restart. 
#      OPTION 2: param RestartIfRequired: boolean, If true function should restart the required service automatically and return scuess if completed.
function Set-AmbariConfigs {
    Write-Output "To be continued..."
}

##TODO: Compile all the config variables into proper JSON suitable to be added to ARM template as below
            # Might want to do this in Main.
    #"configurations": {
        #"hive-site": $HiveSiteConfig
        #"spark2-defaults": $Spark2Defaults
    #}/