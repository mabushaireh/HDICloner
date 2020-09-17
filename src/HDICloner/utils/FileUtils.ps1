<#
.Synopsis
    Utility function to fetch cluster's hadoop configs based on the cluster type
.DESCRIPTION
   This function takes.
   
.EXAMPLE
    ## To be added.
    
.LINK
    https://github.com/mabushaireh/HDICloner
#>


function Create-FolderIfNotExist($folderName, $path) {

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

function Get-LastConfigurationFolder($path)
{
    Show-Debug "Get Last Configuration Folder on this path '$path'"
    $MaxDate = Get-Date("1/1/1900")
    Show-Debug "MaxDate is set to: $MaxDate"

    Get-ChildItem -Path $path -Directory `
    | ForEach-Object {
        Show-Debug ("Try to parse Folder name: " + $_.Name + " to DateTime")
        [datetime]::parseexact($_.Name, "yyyyMMdd_hhmmmss", $null )
    } `
    | ForEach-Object { 
        Show-Debug "Evaluating if $_ is greated that $MaxDate"
        if ($_ -gt $MaxDate) { 
            $MaxDate = $_
            Show-Debug "$MaxDate is set to: $_"
        }
    }    

    $lastConfigFolderName = $MaxDate | Get-Date -Format "yyyyMMdd_hhmmmss"

    Show-Info "Last Configuration Folder on this path $path\$lastConfigFolderName"
    return "$path\$lastConfigFolderName"
}


function Get-PathFor {
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory = $true)] [string] $SubscriptionId,
        [Parameter(Mandatory = $true)] [string] $ClusterDnsName,
        [Parameter(Mandatory = $true)] [string] 
        [ValidateSet("Base", "ARM", "HDP", "HDP-CONFIG", "HDP-ENV", "HDP-Log4j", "Nodes-HN", "Nodes-WN", "Nodes-ZK")]
        $ConfigArea
    )

    $documentsPath = [Environment]::GetFolderPath("MyDocuments")
    $productBaseFolderName = "HDICloner";

    $clsuterPath = "$documentsPath\$productBaseFolderName\$SubscriptionId\$ClusterDnsName"

    switch -Exact ($ConfigArea) {
        'Base' {
            return "$documentsPath\$productBaseFolderName"
        }
        'ARM' {
            $lastConfigFolder = Get-LastConfigurationFolder $clsuterPath

            return "$lastConfigFolder\ARM"
        }
        'HDP' {
            $lastConfigFolder = Get-LastConfigurationFolder $clsuterPath

            return "$lastConfigFolder\HDP"
        }
        'HDP-CONFIG' {
            $lastConfigFolder = Get-LastConfigurationFolder $clsuterPath

            return "$lastConfigFolder\HDP\CONFIG"
        }
        'HDP-ENV' {
            $lastConfigFolder = Get-LastConfigurationFolder $clsuterPath

            return "$lastConfigFolder\HDP\ENV"
        }
        'HDP-Log4j' {
            $lastConfigFolder = Get-LastConfigurationFolder $clsuterPath

            return "$lastConfigFolder\HDP\Log4j"
        }
        'Nodes-HN' {
            $lastConfigFolder = Get-LastConfigurationFolder $clsuterPath

            return "$lastConfigFolder\Nodes\HN"
        }
        'Nodes-WN' {
            $lastConfigFolder = Get-LastConfigurationFolder $clsuterPath

            return "$lastConfigFolder\Nodes\WN"
        }
        'Nodes-ZK' {
            $lastConfigFolder = Get-LastConfigurationFolder $clsuterPath

            return "$lastConfigFolder\Nodes\ZK"
        }
    }

}