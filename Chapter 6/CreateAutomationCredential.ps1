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

# Automation Account Name

$AutomationAccountName = "OMSBook"
$ResouceGroupName = "OMS"

# Create AzureCredentials credential

$AureCred = Get-Credential
New-AzureRmAutomationCredential `
    -Name AzureCredentials `
    -AutomationAccountName $AutomationAccountName `
    -ResourceGroupName $ResouceGroupName `
    -Value $AureCred