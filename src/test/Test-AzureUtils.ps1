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


IntiUnitTest "AzureUtils.ps1" "Export-AzureUtilsResource" "Test for getting $reasourceName" $Expected

Export-AzureUtilsResource -ResourceName $reasourceName -Path $path

$Actual = Test-Path -Path $path

Show-Result $Actual

#======================


$reasourceName = "maswasbsa"

$path = "C:\Users\maabusha\OneDrive - Microsoft\Documents\HDICloner\e29e0537-1c5f-4c7e-9e96-c63a5ddfcc9d\123\20200827_122957\ARM\$reasourceName.json"

$Expected = $true


IntiUnitTest "AzureUtils.ps1" "Export-AzureUtilsResource" "Test for getting $reasourceName" $Expected

Export-AzureUtilsResource -ResourceName $reasourceName -Path $path

$Actual = Test-Path -Path $path

Show-Result $Actual


#======================



$path = "C:\Users\maabusha\OneDrive - Microsoft\Documents\HDICloner\e29e0537-1c5f-4c7e-9e96-c63a5ddfcc9d\123\20200827_122957\ARM\mas915-nonesp-wasb-707.json"
$Arm = Get-Content $path -Raw
$params = @{
    hduser = "hduser"
    hdpassword = "P@ssw0rd1234567"
    sshpassword = "P@ssw0rd1234567"
    container = "testcontainer"
    storageResourceId = "/subscriptions/e29e0537-1c5f-4c7e-9e96-c63a5ddfcc9d/resourceGroups/rg-hdinsight/providers/Microsoft.Storage/storageAccounts/maswasbsa"
}
$clusterDnsName = "mas-wasb-1234"


$Expected = $true


IntiUnitTest "AzureUtils.ps1" "Deploy-AzureUtilsResource" "Test Deploying HDI $clusterDnsName " $Expected

Deploy-AzureUtilsResource -ResourceGroupName "MyResourceGroup" -Arm $Arm -ClusterDnsName $clusterDnsName -Params $params -DeploymentName "TestDeploymentHDI"

$Actual = !(Get-AzHDInsightCluster -ClusterName $clusterDnsName)

Show-Result $Actual