#Initialize
. ".\TestUtils.ps1"
. "..\HDICloner\utils\StringUtils.ps1"
. "..\HDICloner\utils\ConsoleUtils.ps1"
. "..\HDICloner\utils\TimeDateUtils.ps1"
. "..\HDICloner\utils\FileUtils.ps1"
. "..\HDICloner\utils\AmbariUtils.ps1"

SetupTest
$fileName = "AmbariUtils.ps1"


#Test HDICloner
$functionaName = "Get-AmbariUtilsConfig"
$unitTestName = "Get Core Site HDP config"

#-----


$sourceCluster = "mas915-nonesp-wasb-707"


$Expected = @("mas915-nonesp-wasb-707.json","maswasbsa.json")

IntiUnitTest $fileName $functionaName $unitTestName $Expected

$Actual = Get-AmbariUtilsConfig -ClustDnsName $sourceCluster -Username "hduser" -Password "Corp12345678!"


Show-Result $Actual