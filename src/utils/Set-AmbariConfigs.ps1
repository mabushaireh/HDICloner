<#
.Synopsis
    #  Compile all the configs and their values in a JSON that can be appended to the ARM template.
.DESCRIPTION
    Output:
        a JSON structure that can be appended directly into the ARM template under
        resources.properties.clusterDefinition.configurations
       
.EXAMPLE
    
.LINK
    https://github.com/mabushaireh/HDICloner
#>

function Set-AmbariConfigs {
    Write-Output "To be continued..."
}

##TODO: Compile all the config variables into proper JSON suitable to be added to ARM template as below
            # Might want to do this in Main.
    #"configurations": {
        #"hive-site": $HiveSiteConfig
        #"spark2-defaults": $Spark2Defaults
    #}