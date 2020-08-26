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

function Get-AmbariConfigs {
    ##TODO: Find a way to automatically get cluster credentials.
            # Read cluster DNS name and required HDP configs from Main
            # Fetch the relevant configs
           
    
    [CmdletBinding()]
    param 
    (    
        [Parameter(ValueFromPipelineByPropertyName = $true, HelpMessage = "Cluster DNS Name")]
        [string]
        $SourceCluster,

        [Parameter(ValueFromPipelineByPropertyName = $true, HelpMessage = "Subscription ID for cluster")]
        [string]
        $SourceSubId,

        [Parameter(ValueFromPipelineByPropertyName = $true, HelpMessage = "Cluster credentials")]
        [string]
        $SourceSubId,
 
        [Parameter(ValueFromPipelineByPropertyName = $true, HelpMessage = "HDP Config file name; hive-env.xml, etc...")]
        [ValidateSet("core-site", "hive-site", "hive-env", "hdfs-site", "hbase-site", "hbase-env",
                    "mapred-site", "oozie-site", "oozie-env", "storm-site", "tez-site"
                    "webhcat-site", "yarn-site", "spark2-defaults")]
        [string]
        $HDPConfig
    )

    Write-Output "Attempting to fetch relevant configs for cluster name $SourceCluster"

    ## Subject to change, first fetch the common configs, then get the ones relevant to cluster type
    #TODO: Try to get the differences in the files.
    # Find a Way to use $credential param containing user/password to avoid extra prompt for password.

    $HTTPSUri = "https://$SourceCluster.azurehdinsight.net/api/v1/clusters/testspark/configurations?tag=INITIAL&type="

    switch -Exact ($HDPConfig) {
        'core-site' {
            $CoreSiteConfig =  (Invoke-WebRequest -Uri $HTTPSUri+$HDPConfig -Credential admin -UseBasicParsing).Content
        }
        'hive-site' {
            $HiveSiteConfig =  (Invoke-WebRequest -Uri $HTTPSUri+$HDPConfig -Credential admin -UseBasicParsing).Content
        }   
        'hive-env' {
            $HiveEnvConfig =  (Invoke-WebRequest -Uri $HTTPSUri+$HDPConfig -Credential admin -UseBasicParsing).Content
        }   
        'hdfs-site' {
            $HDFSSiteConfig =  (Invoke-WebRequest -Uri $HTTPSUri+$HDPConfig -Credential admin -UseBasicParsing).Content
        }   
        'hbase-site' {
            $HbaseSiteConfig =  (Invoke-WebRequest -Uri $HTTPSUri+$HDPConfig -Credential admin -UseBasicParsing).Content
        }
        'hbase-env' {
            $HbaseEnvConfig =  (Invoke-WebRequest -Uri $HTTPSUri+$HDPConfig -Credential admin -UseBasicParsing).Content
        }
        'mapred-site' {
            $MapredSiteConfig =  (Invoke-WebRequest -Uri $HTTPSUri+$HDPConfig -Credential admin -UseBasicParsing).Content
        }
        'oozie-site' {
            $OozieSiteConfig =  (Invoke-WebRequest -Uri $HTTPSUri+$HDPConfig -Credential admin -UseBasicParsing).Content
        }
        'oozie-env' {
            $OozieEnvConfig =  (Invoke-WebRequest -Uri $HTTPSUri+$HDPConfig -Credential admin -UseBasicParsing).Content
        }
        'storm-site' {
            $StormSiteConfig =  (Invoke-WebRequest -Uri $HTTPSUri+$HDPConfig -Credential admin -UseBasicParsing).Content
        }
        'tez-site' {
            $TezSiteConfig =  (Invoke-WebRequest -Uri $HTTPSUri+$HDPConfig -Credential admin -UseBasicParsing).Content
        }
        'webhcat-site' {
            $CoreSiteConfig =  (Invoke-WebRequest -Uri $HTTPSUri+$HDPConfig -Credential admin -UseBasicParsing).Content
        }
        'yarn-site' {
            $YarnSiteConfig =  (Invoke-WebRequest -Uri $HTTPSUri+$HDPConfig -Credential admin -UseBasicParsing).Content
        }
        'spark2-defaults' {
            $Spark2DefaultsConfig =  (Invoke-WebRequest -Uri $HTTPSUri+$HDPConfig -Credential admin -UseBasicParsing).Content
        }
    }
    Write-Output "store the configs and pass to Set-AmbariConfigs"
}



