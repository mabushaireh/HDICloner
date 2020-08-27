#Initialize
. ".\TestUtils.ps1"
. "..\HDICloner\utils\ConsoleUtils.ps1"
. "..\HDICloner\utils\TimeDateUtils.ps1"

SetupTest

#Test File Utils

#Test File Utils - Get-LastConfigurationFolder
$path = "C:\Users\maabusha\OneDrive - Microsoft\Documents\HDICloner\e29e0537-1c5f-4c7e-9e96-c63a5ddfcc9d\123"

. "..\HDICloner\utils\FileUtils.ps1"
$Expected = "$path\20200827_025545"

IntiUnitTest "FileUtils.ps1" "Get-LastConfigurationFolder" "Test for getting valid last configuration folder" $Expected

$Actual = Get-LastConfigurationFolder $path
Show-Result $Actual


#Test File Utils - Create-FolderIfNotExist
$path = "C:\Users\maabusha\OneDrive - Microsoft\Documents\HDICloner"
$folder = "e29e0537-1c5f-4c7e-9e96-c63a5ddfcc9d"
$Expected = (Get-ChildItem -Path $path -Directory | Where-Object {$_.Name -eq $folder}).CreationTime

IntiUnitTest "FileUtils.ps1" "Create-FolderIfNotExist" "Test Requested Folder already exists" $Expected

Create-FolderIfNotExist $Folder $path

$Actual = (Get-ChildItem -Path $path -Directory | Where-Object {$_.Name -eq $folder}).CreationTime

Show-Result $Actual


#Test File Utils - Create-FolderIfNotExist
$path = "C:\Users\maabusha\OneDrive - Microsoft\Documents\HDICloner"
$folder =  Get-TimeStampUtcNWS

$Expected = $true

IntiUnitTest "FileUtils.ps1" "Create-FolderIfNotExist" "Test Requested Folder doesnt exists" $Expected

Create-FolderIfNotExist $Folder $path

$Actual = Test-Path -Path "$path\$folder"

Show-Result $Actual