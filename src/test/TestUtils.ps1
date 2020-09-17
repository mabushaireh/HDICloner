#Initialize
. "..\HDICloner\utils\StringUtils.ps1"





function SetupTest(){
    
  
}

$global:IsDebug = $true



function IntiUnitTest ($Module, $Func, $UnitTestName, $Expected){
    $Global:Module = $Module
    $Global:Function = $Func
    $Global:Expected = $Expected
    $global:UnitTestName = $UnitTestName
    $Global:Actual = ""
    $exppectdString = Get-StringUtile($Expected)
    "******************Unit Test Start***************************"
    "Initializing Unit Test for"
    "Module:    [$Module]"
    "Function:  [$Func]"
    "Name:      [$UnitTestName]"
    "Expected:  [$exppectdString]"
}

function Show-Result($Actual){
    $Global:Actual = $Actual
    $fc = $host.UI.RawUI.ForegroundColor
    $result = $false
    if (($Actual.GetType()).Name -eq "Hashtable"){
        foreach ($key in $Actual.Keys){
            "Comparing $key on Expected value is [" + $Global:Expected[$key] + "] and on Actual its [" + $Actual[$key] + "]"
            if ($Global:Expected[$key] -ne $Actual[$key]){
                $result = $true
                break
            }
        }
    } elseif (($Actual.GetType()).Name -eq "Object[]"){
        foreach ($item in $Actual){
            "See if $item in Actual exits in Expected"
            if (!($Global:Expected -contains $item)){
                $result = $true
                break
            }
        }
    }
    else {
        $result = $Global:Expected -ne $Actual
    }

    $exppectdString = Get-StringUtile($Global:Expected)

    $actualString = Get-StringUtile($Actual)


    If ( $result ) {
        $host.UI.RawUI.ForegroundColor = "Red"
        "FAILD:   [$Global:Module- $Global:Function] '$exppectdString' were expected while '$actualString' what was the actual"    
    }
    else {
        $host.UI.RawUI.ForegroundColor = "Green"
        "SUCCESS: [$Global:Module- $Global:Function] '$exppectdString' were expected and '$actualString' what was the actual"    
    }

    $host.UI.RawUI.ForegroundColor = $fc
    "******************Unit Test End**************************"
}