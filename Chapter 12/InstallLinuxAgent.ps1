Param(
  [string]$TargetServer
)

#Import Module - Runbooks Folder on Hybrid Worker
Import-Module 'C:\Runbooks\Modules\Posh-SSH\Posh-SSH.psd1' -Force

#Get Various Cred / OMS Variables
$cred = Get-AutomationPSCredential -Name 'LinuxAdminAcct'
$TargetServerIP = $TargetServer
$WorkspaceID = Get-AutomationVariable -Name 'OMSWorkspaceID'
$PrimaryKey = Get-AutomationVariable -Name 'OMSPrimaryKey'

Write-Output "Performing install on $TargetServer"
	
#Initiate SSH Session
$Out = New-SSHSession -ComputerName $TargetServerIP -Credential (Get-Credential $cred) -AcceptKey

#Save Sesssion ID
$Out = $Session = Get-SSHSession 

Write-Output "Starting copy and install"
	
Write-Output "Copying installer"

$Out = Set-SCPFile -LocalFile 'C:\Runbooks\OMSInstall\omsagent-1.0.0-47.universal.x64.sh' -RemotePath "/tmp/" -ComputerName $TargetServerIP -Credential (Get-Credential $cred) 
	
WRITE-OUTPUT "Installing"

$Out = Invoke-SSHCommand -Index $Session.SessionID -Command "chmod +x /tmp/omsagent-1.0.0-47.universal.x64.sh"

$Out = Invoke-SSHCommand -Index $Session.SessionID -Command "md5sum /tmp/omsagent-1.0.0-47.universal.x64.sh"

$Out = Invoke-SSHCommand -Index $Session.SessionID -Command "sudo /tmp/omsagent-1.0.0-47.universal.x64.sh --install -w $WorkspaceID -s $PrimaryKey"

WRITE-OUTPUT "Installation complete"

WRITE-OUTPUT "Close SSH Session"
$OUT = Remove-SSHSession -Index $Session.SessionID 
