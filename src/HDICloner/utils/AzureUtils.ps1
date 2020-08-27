<#
.Synopsis
    Utility function to for Azure
.DESCRIPTION
   This function takes the cluster DNS name and type and fetches the relevant Hadoop configs
   
.EXAMPLE
    ## To be added.
    
.LINK
    https://github.com/mabushaireh/HDICloner
#>

function Get-AzureUtilsAccount($SubscriptionId) {

    Show-Debug "Passed value for SubscriptionId is set to $SubscriptionId"

    if (!$SubscriptionId) {
        Show-Warning "Default Subscription is going to be used!"
    }

    Show-Debug "Check if user already signed in to Azure Account!"

    $context = Get-AzContext

    if (!$context) {
        Show-Debug "Current Session is not logged to any Azure Account"
        Show-Prompt "Please login to your Azure Account"
        if ($SubscriptionId) {
            Show-Debug "Logging and selecting Subscription '$SubscriptionId'"
            $context = Connect-AzAccount -Subscription $SubscriptionId
            Show-Info "Subscription '$SubscriptionId' selected"
        }
        else {
            $context = Connect-AzAccount
            Show-Info "Subscription '$context.SubscriptionId' selected"
        }
    } 
    else {
        Show-Debug "Current Session has already logged to an Azure Account"
        if ($SubscriptionId) {
            if ($context.Subscription.Id -eq $SubscriptionId)
            {
                Show-Info "Subscription '" + $context.Subscription.Id + "' already selected."
            }
            else {
                Show-Debug "Subscription $SubscriptionId is not selected"
                $context = Select-AzSubscription $SubscriptionId
                Show-Info "Subscription $SubscriptionId is selected"
            }
        }
        else {
            Show-Info ("Subscription '" + $context.Subscription.Id + "' is selected.")
        }
    }

    return $context
}