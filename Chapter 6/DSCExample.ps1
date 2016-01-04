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
$SetTimeZoneConifgPath = 'C:\Scripts\OMSBook\Chapter 6\SetTimeZone.ps1'
$VM = 'OMSVM'
$DSCConfigPath = 'C:\DSCConfig'


# Import DSC Configuration
Import-AzureRmAutomationDscConfiguration `
    -SourcePath $SetTimeZoneConifgPath `
    -Description 'Configuration for TimeZone' `
    -ResourceGroupName $ResourceGroupName `
    -AutomationAccountName $AutomationAccountName `
    -Published `
    -force

# Compile Configuration
$CompilationJob = Start-AzureRmAutomationDscCompilationJob `
    -ConfigurationName 'SetTimeZone' `
    -ResourceGroupName $ResourceGroupName `
    -AutomationAccountName $AutomationAccountName

# Wait Until compilation job is completed
# Execute this to check status
$CompilationJob | Get-AzureRmAutomationDscCompilationJob 

# Get Azure Automation DSC Node
$NodeObj = Get-AzureRmAutomationDscNode `
    -Name $VM `
    -ResourceGroupName $ResourceGroupName `
    -AutomationAccountName $AutomationAccountName

# Get Azure Automation Node Configuration
$ConfigurationObj = Get-AzureRmAutomationDscNodeConfiguration `
    -ConfigurationName 'SetTimeZone' `
    -ResourceGroupName  $ResourceGroupName `
    -AutomationAccountName $AutomationAccountName

# Apply DSC node Configuration to DSC Node
Set-AzureRmAutomationDscNode `
    -NodeConfigurationName $ConfigurationObj.Name `
    -Id  $NodeObj.Id `
    -ResourceGroupName $ResourceGroupName `
    -AutomationAccountName $AutomationAccountName `
    -Force 

# Execute locally on the machine
Update-DscConfiguration -Wait -Verbose

# Verify Compliance 
Get-AzureRmAutomationDscNode `
    -Id $NodeObj.Id `
    -ResourceGroupName $ResourceGroupName `
    -AutomationAccountName $AutomationAccountName