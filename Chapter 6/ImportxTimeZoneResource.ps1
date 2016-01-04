# Authenticate to Azure Account

Login-AzureRmAccount

# Authenticate with Azure AD credentials

$cred = Get-Credential

Login-AzureRmAccount `
    -Credential $cred


# Select an Azure subscription

$subscriptionId = 
    (Get-AzureRmSubscription |
     Out-GridView `
        -Title "Select a Subscription ..." `
        -PassThru).SubscriptionId

Select-AzureRmSubscription `
    -SubscriptionId $subscriptionId

# Variables
$ResourceGroupName = 'OMS'
$AutomationAccountName = 'OMSBook'
$xTimeZoneModuleURL = 'https://devopsgallerystorage.blob.core.windows.net/azureautomationpackages/xTimeZone%5C1.3.0%5CxTimeZone.zip'

# Import xTimeZone module
# Wait until it is imported
New-AzureRmAutomationModule `
    -Name 'xTimeZone' `
    -ContentLink $xTimeZoneModuleURL `
    -ResourceGroupName $ResourceGroupName `
    -AutomationAccountName $AutomationAccountName