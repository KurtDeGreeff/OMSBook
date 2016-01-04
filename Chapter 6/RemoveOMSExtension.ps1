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

$VMName = "OMSVM"
$ResouceGroupName = "OMS"

# Remove OMS Extension on a VM

Remove-AzureRmVMExtension `
    -ResourceGroupName $ResouceGroupName `
    -VMName $VMName `
    -Name OMSExtension