Param(
    [Parameter(Mandatory=$false)][PSCredential]$ServerAdminCred,
    [Parameter(Mandatory=$false)][string]$ComputerName,
    [Parameter(Mandatory=$false)][string]$ServiceName
)

If (!$ServerAdminCred)
{
    $ServerAdminCred = Get-AutomationPSCredential RestartServiceRunbookDefaultCred
}
If (!$ComputerName)
{
    $ComputerName = Get-AutomationVariable RestartServiceRunbookDefaultComputerName
}
If (!$ServiceName)
{
    $ServiceName = Get-AutomationVariable RestartServiceRunbookDefaultServiceName
}

$Service = Get-WmiObject -Query "Select * from Win32_Service Where Name = '$ServiceName'" -Credential $ServerAdminCred -ComputerName $ComputerName

If ($Service.State -ieq 'stopped')
{
    If ($Service.StartMode -ine 'disabled')
    {
        Write-Verbose "Starting service '$ServiceName' on computer '$ComputerName'."
        $Service.StartService()
    } else {
        Write-Error "Unable to start service '$ServiceName' on computer '$ComputerName' because it is disabled."
    }
} else {
    Write-Verbose "Not need to start the service '$ServiceName' on computer '$ComputerName' because it is not stopped. Current state: '$($Service.State)'."
}
Write-Output "Done."