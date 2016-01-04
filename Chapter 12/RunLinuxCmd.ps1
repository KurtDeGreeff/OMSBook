Param(
  [string]$TargetServer,
  [string]$LinuxCommand,
  [string]$Message
)

Write-Output "Importing POSH-SSH module on Hybrid Worker"

#Import Module - Runbooks Folder on Hybrid Worker
Import-Module 'C:\Runbooks\Modules\Posh-SSH\Posh-SSH.psd1' -Force

#Get Various Cred / OMS Variables
Write-Output "Getting Various Cred / OMS Variables"

$cred = Get-AutomationPSCredential -Name 'LinuxAdminRoot'
$TargetServerIP = $TargetServer
$WorkspaceID = Get-AutomationVariable -Name 'OMSWorkspaceID'
$PrimaryKey = Get-AutomationVariable -Name 'OMSPrimaryKey'

Write-Output "Performing Action on $TargetServer"
    
#Initiate SSH Session
Write-Output "Initiating SSH Session for $TargetServer" 

$Out = New-SSHSession -ComputerName $TargetServerIP -Credential (Get-Credential $cred) -AcceptKey

#Save Sesssion ID
$Session = Get-SSHSession 

Write-Output $Message
	
$Out = Invoke-SSHCommand -Index $Session.SessionID -Command "$LinuxCommand"

WRITE-Output "Script complete. Close SSH session"

$OUT = Remove-SSHSession -Index $Session.SessionID

Write-Output "Closed SSH session. Runbook complete"

