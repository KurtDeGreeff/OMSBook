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

# Create AzureSubscriptionID variable

$AzureSubscriptionID = "<your Azure Subscription ID>"
New-AzureRmAutomationVariable `
    -AutomationAccountName $AutomationAccountName `
    -ResourceGroupName $ResouceGroupName `
    -Name AzureSubscriptionID `
    -Encrypted $false `
    -Value $AzureSubscriptionID

# Create OMSWorkspaceID variable

$OMSWorkspaceID = "<your OMS Workspace ID>"
New-AzureRmAutomationVariable `
    -AutomationAccountName $AutomationAccountName `
    -ResourceGroupName $ResouceGroupName `
    -Name OMSWorkspaceID `
    -Encrypted $false `
    -Value $OMSWorkspaceID

# Create OMSWorkspacePrimaryKey variable

$OMSPriamryKey = "<your OMS Priamry Key>"
New-AzureRmAutomationVariable `
    -AutomationAccountName $AutomationAccountName `
    -ResourceGroupName $ResouceGroupName `
    -Name OMSWorkspacePrimaryKey `
    -Encrypted $true `
    -Value $OMSPriamryKey
