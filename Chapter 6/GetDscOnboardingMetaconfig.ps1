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
$DSCConfigPath = 'C:\DSCConfig'
$VM = 'OMSVM'

# Create folder if do not exits
If (!(Test-path -Path $DSCConfigPath))
{
    New-Item `
        -Path C:\ `
        -ItemType Directory `
        -Name DSCConfig
}

# Create DSC configuration for connection to
# Azure Automation DSC
Get-AzureRmAutomationDscOnboardingMetaconfig `
    -ResourceGroupName $ResourceGroupName `
    -AutomationAccountName $AutomationAccountName `
    -ComputerName $VM `
    -OutputFolder $DSCConfigPath