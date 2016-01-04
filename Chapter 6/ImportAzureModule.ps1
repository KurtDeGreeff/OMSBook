
# Authenticate to Azure Account

Add-AzureAccount

# Authenticate with Azure AD credentials

$cred = Get-Credential

Add-AzureAccount `
    -Credential $cred

# Switch to Azure Resource Manager mode

Switch-AzureMode `
    -Name AzureResourceManager

# Select an Azure subscription

$subscriptionId = 
    (Get-AzureSubscription |
     Out-GridView `
        -Title "Select a Subscription ..." `
        -PassThru).SubscriptionId
Select-AzureSubscription `
    -SubscriptionId $subscriptionId

# Automation Account Name

$AutomationAccountName = "OMSBook"
$ResouceGroupName = "OMS"

# Import Azure Module

$AzureModuleLocation = "https://oms9613.blob.core.windows.net/modules/Azure.zip"
New-AzureAutomationModule `
    -Name Azure -ContentLink $AzureModuleLocation `
    -ResourceGroupName $ResouceGroupName `
    -AutomationAccountName $AutomationAccountName