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

# Create Resource Group

New-AzureRmResourceGroup `
    -Name 'OMS' `
    -Location "West Europe"

# Create Automation Account 

New-AzureRmAutomationAccount `
    -ResourceGroupName 'OMS' `
    -Name 'OMSBook2' `
    -Location "West Europe" `
    -Plan Free 