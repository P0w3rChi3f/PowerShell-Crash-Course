
Get-WinEvent -Path "C:\Scripts\PowerShellCTF\Win7-security.evtx" | 
Where-Object { $_.id -eq 4624 } | Select-Object -ExpandProperty message | 
    Select-String -Pattern "Logon\D+:\s+3" | Measure-Object


get-date | Get-Member
$90daysago = $today.adddays(-90)

$90daysago