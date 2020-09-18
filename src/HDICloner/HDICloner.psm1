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
        [string] $SourceSubId,

        [Parameter(Mandatory = $true, ParameterSetName = "Main", HelpMessage = "Ambari Username")]
        [string]
        $Username,

        [Parameter(Mandatory = $true, ParameterSetName = "Main", HelpMessage = "Ambari Password")]
        [string]
        $Password
    )

  

    Show-Info "=== Script Preperation Started ==="

    $ScriptVersion = '0.0.0.11'
    Show-Debug "ScriptVersion : $ScriptVersion"

    $ConfirmPreference = "High"


    $timestamp = Get-TimeStampUtcNWS
    Show-Debug "timestamp is set to $timestamp"

    $transcriptPath = "$env:TEMP\$timestamp"
    


    Create-FolderIfNotExist $timestamp "$env:TEMP"

    $documentsPath = [Environment]::GetFolderPath("MyDocuments")
    $outputFolder = "HDICloner"

    Show-Debug "documentsPath is set to $documentsPath"
    Create-FolderIfNotExist $outputFolder $documentsPath

    $outputPath = "$documentsPath\$outputFolder"
    Show-Info ("Output Path is set to $outputPath")




    Show-Info "=== Script is Ready ==="

    $null = Start-Transcript -Path "$transcriptPath\Transcript.txt"
    Show-Debug "Transacript Started and transcript file is $transcriptPath\Transcript.txt"


    Show-Debug "Passed value for Operation is $Operation"
    Show-Debug "Passed value for SourceCluster is $SourceCluster"
    Show-Debug "Passed value for SourceSubId is $SourceSubId"
    Show-Info "Set Azure Context to the Source Cluster Subscription"
    $context = Get-AzureUtilsAccount $SourceSubId
    $SourceSubId = $context.Subscription.Id

    #TODO: Move this to the Get-HDIClonerClusterConfig.ps1
    Create-FolderIfNotExist $SourceSubId $outputPath
    Create-FolderIfNotExist $SourceCluster "$outputPath\$SourceSubId"
    Create-FolderIfNotExist $timestamp "$outputPath\$SourceSubId\$SourceCluster"
    Create-FolderIfNotExist $timestamp "$outputPath\$SourceSubId\$SourceCluster"
    Create-FolderIfNotExist "ARM" "$outputPath\$SourceSubId\$SourceCluster\$timestamp"
    Create-FolderIfNotExist "HDP" "$outputPath\$SourceSubId\$SourceCluster\$timestamp"
    Create-FolderIfNotExist "CONFIG" "$outputPath\$SourceSubId\$SourceCluster\$timestamp\HDP"
    Create-FolderIfNotExist "ENV" "$outputPath\$SourceSubId\$SourceCluster\$timestamp\HDP"
    Create-FolderIfNotExist "Log4j" "$outputPath\$SourceSubId\$SourceCluster\$timestamp\HDP"
    Create-FolderIfNotExist "Nodes" "$outputPath\$SourceSubId\$SourceCluster\$timestamp"
    Create-FolderIfNotExist "HN" "$outputPath\$SourceSubId\$SourceCluster\$timestamp\Nodes"
    Create-FolderIfNotExist "WN" "$outputPath\$SourceSubId\$SourceCluster\$timestamp\Nodes"
    Create-FolderIfNotExist "ZK" "$outputPath\$SourceSubId\$SourceCluster\$timestamp\Nodes"



    Show-Info "=== Run $Operation HDICloner Operation Started ==="

    
    

    
    switch -Exact ($Operation) {
        'Get' {
            Get-HDIClonerClusterConfig -SourceCluster $SourceCluster -Username $Username -Password $Password
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
    Show-Debug "Transacript Stopped and transcript file is $transcriptPath\Transcript.txt"

}

Export-ModuleMember -Function Run-HDICloner
