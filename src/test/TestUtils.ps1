#Initialize





function SetupTest(){
    
  
}

$global:IsDebug = $false
$global:Module = ""
$global:Function = ""
$global:UnitTestName = ""
$global:Expected = ""

function IntiUnitTest ($Module, $Func, $UnitTestName, $Expected){
    $Global:Module = $Module
    $Global:Function = $Func
    $Global:Expected = $Expected
    $global:UnitTestName = $UnitTestName
    $Global:Actual = ""

    "******************Unit Test Start***************************"
    "Initializing Unit Test for"
    "Module:    [$Module]"
    "Function:  [$Func]"
    "Name:      [$UnitTestName]"
    "Expected:  [$Expected]"
}

function Show-Result($Actual){
    $Global:Actual = $Actual
    $fc = $host.UI.RawUI.ForegroundColor
    If ($Global:Expected -ne $Actual ) {
        $host.UI.RawUI.ForegroundColor = "Red"
        "FAILD:   [$Global:Module- $Global:Function] '$Global:Expected' were expected while $Actual what was the actual"    
    }
    else {
        $host.UI.RawUI.ForegroundColor = "Green"
        "SUCCESS: [$Global:Module- $Global:Function] '$Global:Expected' were expected and $Actual what was the actual"    
    }

    $host.UI.RawUI.ForegroundColor = $fc
    "******************Unit Test End**************************"
}