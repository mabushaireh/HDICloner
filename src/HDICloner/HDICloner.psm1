<#
.Synopsis
    Main Entry to HDICloner tool.
.DESCRIPTION
    You can use this script to run several commands such as get, build, make, compare and sync
       
.EXAMPLE
    Run-HDICloner -Operation Get -SourceCluster SourceClusterdnsName -SourceSubId SourceClusterSubscriptionID
    #Note: SourceSubId is optional if not provided will use the default subscription
    #Note: Account used is the Azure Account in the AccountContext.
    
.LINK
    https://github.com/mabushaireh/HDICloner
#>


#TODO: this is a contract only, and subject to change

function Run-HDICloner {
    
    [CmdletBinding()]
    param 
    (
    
        [Parameter(Mandatory = $true, ParameterSetName = "Main", HelpMessage = "Select one of the operations: Get, Make, Build, Compare, Sync." )]
        [ValidateSet("Get", "Make", "Build", "Compare", "Sync")]
        [string] $Operation,

        [Parameter(Mandatory = $true, ParameterSetName = "Main", HelpMessage = "Source Cluster Dns Name")]
        [string] $SourceCluster,

        [Parameter(Mandatory = $false, ParameterSetName = "Main", HelpMessage = "Source Cluster Subscription Id, if not provided will locate the cluster in the cueect azure account context")]
        [string] $SourceSubId
    )

    Show-Info "=== Script Preperation Started ==="

    $ScriptVersion = '0.0.0.8'
    Show-Debug "ScriptVersion : $ScriptVersion"

    $ConfirmPreference = "High"


    $timestamp = Get-TimeStampUtcNWS
    $transcriptPath = "$env:TEMP\$timestamp\"
    


    Create-FolderIfNotExist $timestamp "$env:TEMP"

    $documentsPath = [Environment]::GetFolderPath("MyDocuments")
    $outputFolder = "HDICloner"

    Show-Debug "documentsPath is $documentsPath"
    Create-FolderIfNotExist $outputFolder $documentsPath

    $outputPath = "$documentsPath\$outputFolder"
    Show-Info ("Output Path is set to $outputPath")




    Show-Info "=== Script is Ready ==="

    $null = Start-Transcript -Path "$transcriptPath\Transcript.txt"
    Show-Debug ("Transacript Started and transcript file is $transcriptPath\Transcript.txt")


    Show-Debug "Passed value for Operation is $Operation"
    Show-Debug "Passed value for SourceCluster is $SourceCluster"
    Show-Debug "Passed value for SourceSubId is $SourceSubId"

    Create-FolderIfNotExist $SourceSubId $outputPath
    Create-FolderIfNotExist $SourceCluster "$outputPath\$SourceSubId"
    Create-FolderIfNotExist $timestamp "$outputPath\$SourceSubId\$SourceCluster"



    Show-Info "=== Run $Operation HDICloner Operation Started ==="


    #TODO: Imoprt Script:
    

    #TODO: Create Folder structure
    #   Default Path: <User profile Documents>\HDICloner\
    #                                                       + <Sub ID ...1234>
    #                                                       - <Sub ID ...5678>
    #                                                                         +<Cluster DNS Name 1>
    #                                                                         +<Cluster DNS Name 2>
    #                                                                         -<Cluster DNS Name 3>
    #                                                                                               -20082020_125322
    #                                                                                                               -ARM
    #                                                                                                                   HDI_CLUSTER-<CLUSTER DNS NAME>.json
    #                                                                                                                   HDI_STORAGE_<CLUSTER DNS NAME>_<Storage Name>.json
    #                                                                                                                   HDI_VNET_<CLUSTER DNS NAME>_<vnet name.json
    #                                                                                                                   HDI_DB_AMBARI_<CLUSTER DNS NAME>_<DB NAME>.json
    #                                                                                                                   HDI_DB_HIVE_<CLUSTER DNS NAME>_<DB NAME>.json
    #                                                                                                                   HDI_ACTION_SCRIPTS_<CLUSTER DNS NAME>_<DB NAME>.json
    #                                                                                                               -HDP                                                                                                
    #                                                                                                                   +CONFIG
    #                                                                                                                   +ENV
    #                                                                                                               -Nodes
    #                                                                                                                   +HN
    #                                                                                                                   +WN
    #                                                                                                                   +ZK
    #                                                                                               +20082020_143254
    #                                                                                               +22102020_212237
    #                                                                         +<Cluster DNS Name 4>
    #                                                       + <Sub ID ...9012>
    

    
    switch -Exact ($Operation) {
        'Get' {
            Get-HDIClonerClusterConfig -SourceCluster $SourceCluster
        }
        'Make' {
            Show-Info 'Coming Soon'
        }   
        'Build' {
            Show-Info 'Coming Soon'
        }   
        'Compare' {
            Show-Info 'Coming Soon'
        }   
        'Sync' {
            Show-Info 'Coming Soon'
        }   
    }

    Show-Info "=== Run $Operation HDICloner Operation Completed ==="

    $null = Stop-Transcript

}

Export-ModuleMember -Function Run-HDICloner
