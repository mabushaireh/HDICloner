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
    $ScriptVersion = '0.0.0.7'

    $ConfirmPreference = "High"


    $timestamp = Get-Date -Format "yyyymmd_hms"
    $transcriptPath = "$env:TEMP\$timestamp\"

    if (-Not (Test-Path $transcriptPath)) {
        New-Item -Path $transcriptPath -ItemType Directory
    }


    $null = Start-Transcript -Path "$transcriptPath\Transcript.txt"
    Write-Output "=== Script Started ==="


    #Imoprt Script:
    #Write-Debug "Debug" -Debug:($PSBoundParameters['Debug'] -eq $true)
    #Write-Information ("Information ") -InformationAction SilentlyContinue
    #Write-Warning "Warning"
    #Write-Error "Error"

    switch -Exact ($Operation) {
        'Get' {
            Get-HDIClonerClusterConfig -SourceCluster $SourceCluster
        }
        'Make' {
            Write-Output 'Coming Soon'
        }   
        'Build' {
            Write-Output 'Coming Soon'
        }   
        'Compare' {
            Write-Output 'Coming Soon'
        }   
        'Sync' {
            'Coming Soon'
        }   
    }

    Write-Output "=== Script Ended ==="
    $null = Stop-Transcript

}

Export-ModuleMember -Function Run-HDICloner
