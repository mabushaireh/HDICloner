<#
.Synopsis
    Utility function to fetch cluster's hadoop configs based on the cluster type
.DESCRIPTION
   This function takes.
   
.EXAMPLE
    ## To be added.
    
.LINK
    https://github.com/mabushaireh/HDICloner
#>


function Get-StringUtile($obj){
    $temp = $hashtable
    if (($obj.GetType()).Name -eq "Hashtable"){
        $temp = ConvertTo-Json $obj -Depth 100
    }
    if (($obj.GetType()).Name -eq "Object[]"){
        $temp = ConvertTo-Json $obj -Depth 100
    }
     
    return $temp
}