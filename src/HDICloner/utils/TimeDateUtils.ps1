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


function Get-TimeStampUtcNWS()
{
    $timestamp = Get-Date -Format "yyyyMMdd_hhmmmss"

    return $timestamp;
}

function Get-TimeStampUtc()
{
    $timestamp = Get-Date -Format "yyyyMMdd hh:mmm:ss"

    return $timestamp;
}