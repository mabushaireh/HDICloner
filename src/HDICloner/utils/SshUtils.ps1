#Intilliaze

function Setup()
{
    if (Get-Module -ListAvailable -Name "Posh-SSH") {
        Show-Info "Posh-Ssh module is installed"
    } 
    else {
        Show-Info "Posh-Ssh module doesnt exist, Installing it"
        
        Install-Module -Name "Posh-SSH"
    }

    Import-Module -Name "Posh-SSH"
}