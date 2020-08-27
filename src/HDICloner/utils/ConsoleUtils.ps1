<#
.Synopsis
    Utility function to Show differnt Type of Information to the console
.DESCRIPTION
   This function takes the cluster DNS name and type and fetches the relevant Hadoop configs
   
.EXAMPLE
    ## To be added.
    
.LINK
    https://github.com/mabushaireh/HDICloner
#>


Function Get-Stack {
    $stack = ""
    $Global:Var = (Get-PSCallStack).Command

    For ($Index = 2; $Index -lt $Var.Length-1; $Index++) {
        $stack = $stack + "$($Var[$Index])" + ":"
    }

    return $stack
}
 
function Show-Prompt ($msg)
{
    $timeStamp = Get-TimeStampUtc
    $stack = Get-Stack
    $errorMsg = "$timeStamp : INFO - $stack -  $Msg"    
    # save the current color
    $fc = $host.UI.RawUI.ForegroundColor

     # set the new color
     $host.UI.RawUI.ForegroundColor = "Green"

     Write-Host $errorMsg
     
     # restore the original color
     $host.UI.RawUI.ForegroundColor = $fc
}
function Show-Error($Msg)
{
    $timeStamp = Get-TimeStampUtc
    $stack = Get-Stack
    $errorMsg = "$timeStamp : ERROR - $stack -  $Msg"    
    # save the current color
    $fc = $host.UI.RawUI.ForegroundColor

    # set the new color
    $host.UI.RawUI.ForegroundColor = "Red"

    Write-Host $errorMsg
    
    # restore the original color
    $host.UI.RawUI.ForegroundColor = $fc
}

function Show-Warning($Msg)
{
    $timeStamp = Get-TimeStampUtc
    $stack = Get-Stack
    $errorMsg = "$timeStamp : WARN  - $stack -  $Msg"    # save the current color
    $fc = $host.UI.RawUI.ForegroundColor

    # set the new color
    $host.UI.RawUI.ForegroundColor = "Yellow"

    Write-Host $errorMsg
    
    # restore the original color
    $host.UI.RawUI.ForegroundColor = $fc
}

function Show-Info($Msg)
{
    $timeStamp = Get-TimeStampUtc
    $stack = Get-Stack
    $errorMsg = "$timeStamp : INFO  - $stack -  $Msg"
    # save the current color
    $fc = $host.UI.RawUI.ForegroundColor

    # set the new color
    $host.UI.RawUI.ForegroundColor = "White"

    Write-Host $errorMsg
    
    # restore the original color
    $host.UI.RawUI.ForegroundColor = $fc
}



function Show-Debug($Msg)
{
    $timeStamp = Get-TimeStampUtc
    $stack = Get-Stack
    $errorMsg = "$timeStamp : DEBUG - $stack -  $Msg"
    # save the current color
    $fc = $host.UI.RawUI.ForegroundColor

    # set the new color
    $host.UI.RawUI.ForegroundColor = "Cyan"

    Write-Host $errorMsg
    
    # restore the original color
    $host.UI.RawUI.ForegroundColor = $fc
}
