# $creds = Get-Credential demo-dc\vagrant
$creds = Get-Credential $env:COMPUTERNAME\vagrant

Set-Item WSMan:\localhost\Client\TrustedHosts -Value '192.168.42.208' 
Set-Item WSMan:\localhost\Client\TrustedHosts -Value '192.168.42.230'
Set-Item WSMan:\localhost\Client\TrustedHosts -Value 'demo-dc'

# WSMan Configs
Get-ChildItem WSMan:\localhost\Shell
Get-ChildItem WSMan:\localhost\Service\

# Enable Remote PowerShell
Test-WSMan
Get-PSSessionConfiguration
winrm quickconfig
Enable-PSRemoting -SkipNetworkProfileCheck -Verbose

# Enter-PSSession
enter-pssession localhost
enter-pssession $env:COMPUTERNAME -Credential $creds

# Invoke-command
Invoke-Command -computerName localhost, $env:COMPUTERNAME  -Credential $creds -command { Get-EventLog Security | Where-Object {$_.eventID -eq 4826}}

# Sessions
$sessions = New-PSSession -ComputerName localhost, $env:COMPUTERNAME -Credential $creds
Disconnect-PSSession -Name 'WinRM8'
Connect-PSSession
Remove-PSSession

Enter-PSSession -Session $sessions[0]
Enter-PSSession -Session ($sessions |Where-Object { $_.computername -eq ‘localhost’ })
Enter-PSSession -Session (Get-PSSession -ComputerName 'localhost')

$s_server1,$s_server2 = new-pssession -computer localhost, $env:COMPUTERNAME -Credential $creds

Invoke-Command -Command { Get-CimInstance Win32_Process } -Session $sessions | Format-Table -Property PSComputerName, processname, ProcessID, ParentProcessID

invoke-command -command { Get-CimInstance Win32_Process } -session $sessions | Select-Object ProcessName, PSComputerName, Path | Group-Object ProcessName | Sort-Object Count -Descending | Format-Table -AutoSize


#Trusted Hosts
Get-Item wsman:\localhost\Client\TrustedHosts
Set-Item wsman:localhost\client\trustedhosts -Value *

#########################################################################################

#reset WinRM
Disable-PSRemoting
winrm enumerate winrm/config/listener
winrm delete winrm/config/listener?address=*+transport=HTTP
Stop-Service winrm
Set-Service -Name winrm -StartupType Disabled
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System `
    -Name LocalAccountTokenFilterPolicy -Value 0 -Type DWord
Disable-NetFirewallRule -DisplayName 'Windows Remote Management (HTTP-In)' 
Get-NetFirewallRule -DisplayName 'Windows Remote Management (HTTP-In)'

#########################################################################################

$creds = Get-Credential jeademo\jea.admin

enter-pssession jea-demosvr -Credential $creds

New-Item -ItemType Directory -Name Dir01 
Remove-Item Dir01

enter-pssession jea-dc -Credential $creds

Invoke-Command -computerName jea-demosvr, jea-dc  -Credential $creds -command { Get-EventLog Security | Where-Object {$_.eventID -eq 4826}} | Group-Object pscomputername
        4624 

# Sessions
$demosvrSession = New-PSSession -ComputerName jea-demosvr -Credential $creds
$demosvrSession
Enter-PSSession -Session $demosvrSession

$comboSession = New-PSSession -ComputerName jea-demosvr -Credential $creds
$Session = New-PSSession -ComputerName jea-demosvr -Credential $creds

Get-PSSession
Disconnect-PSSession -Id 3
Disconnect-PSSession -Id 4

Get-PSSession
Connect-PSSession -id 3
Get-PSSession

$session = New-PSSession -ComputerName jea-demosvr, jea-dc -Credential $creds

Disconnect-PSSession
Connect-PSSession
Remove-PSSession

Enter-PSSession -Session $session[1]
Enter-PSSession -Session ($session | Where-Object { $_.computername -eq ‘jea-dc’ })
Enter-PSSession -Session (Get-PSSession -ComputerName 'jea-demosvr' -Credential $creds)



$s_server1,$s_server2 = new-pssession -computer localhost, DESKTOP-52INA1A -Credential $creds

Invoke-Command -Command { Get-WmiObject -Class win32_process } -Session $session | 
    Format-Table -Property PSComputerName, processname, ProcessID, ParentProcessID

invoke-command -command { get-wmiobject -class win32_process } -session $session | 
    Select-Object ProcessName, PSComputerName, Path | Group-Object ProcessName | 
    Sort-Object Count -Descending | Format-Table -AutoSize

Invoke-Command -Session $session {new-item -Type Directory -Path c:\ -Name Temp}

#Note !!!! at this point make a single session to demonstrate the copy-item without the for loop

foreach ($item in $session) {Copy-Item -Path c:\temp\Sessions.txt -Destination c:\temp -ToSession $item}

Invoke-Command -Session $session {remove-item -Path c:\Temp}