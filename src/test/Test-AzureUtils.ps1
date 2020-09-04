#Initialize
. ".\TestUtils.ps1"
. "..\HDICloner\utils\ConsoleUtils.ps1"
. "..\HDICloner\utils\TimeDateUtils.ps1"
. "..\HDICloner\utils\FileUtils.ps1"
. "..\HDICloner\utils\AzureUtils.ps1"

SetupTest

#Test Azure Utils

$reasourceName = "mas915-nonesp-wasb-707"

$path = "C:\Users\maabusha\OneDrive - Microsoft\Documents\HDICloner\e29e0537-1c5f-4c7e-9e96-c63a5ddfcc9d\123\20200827_122957\ARM\$reasourceName.json"

$Expected = $true


IntiUnitTest "AzureUtils.ps1" "Export-AzureUtilsResource" "Test for getting " $Expected

Export-AzureUtilsResource -ResourceName $reasourceName -Path $path

$Actual = Test-Path -Path $path

Show-Result $Actual