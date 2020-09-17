#Initialize
. ".\TestUtils.ps1"
. "..\HDICloner\utils\StringUtils.ps1"
. "..\HDICloner\utils\ConsoleUtils.ps1"
. "..\HDICloner\utils\TimeDateUtils.ps1"
. "..\HDICloner\utils\FileUtils.ps1"
. "..\HDICloner\utils\AzureUtils.ps1"
. "..\HDICloner\utils\AmbariUtils.ps1"


. "..\HDICloner\Get-HDIClonerClusterConfig.ps1"



SetupTest
$fileName = "HDICloner.psm1"


#Test HDICloner
$functionaName = "Run-HDICloner"
$unitTestName = "Test Get Cluster Configurations"

$sourceCluster = "mas915-nonesp-wasb-707"
$username = "hduser"
$password = "Corp12345678!"

$Expected = @("mas915-nonesp-wasb-707.json","maswasbsa.json")

IntiUnitTest $fileName $functionaName $unitTestName $Expected

Run-HDICloner -Operation Get -SourceCluster $sourceCluster -Username $username -Password $password

$subId = (Get-AzContext).Subscription.Id
$ArmPath = Get-PathFor -SubscriptionId $subId -ClusterDnsName $SourceCluster -ConfigArea ARM 

$Actual =  (Get-ChildItem $ArmPath | ForEach-Object {$_.Name})



Show-Result $Actual

#======================


