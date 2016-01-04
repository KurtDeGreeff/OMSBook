# Variables
$VM = 'OMSVM'

# Set Local DSC Configuration to connect to
# Azure Automation DSC

Set-DscLocalConfigurationManager `
    -Path 'C:\DscMetaConfigs\' `
    -ComputerName $VM `
    -Verbose