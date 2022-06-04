$Creds = Get-Credential "vagrant"
New-Item -ItemType File -name MyComputerlist.txt -Path .\NeedFiles\ -Force


Set-Item WSMan:\localhost\Client\TrustedHosts -Value "localhost" -Concatenate
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "$env:ComputerName" -Concatenate
Set-Item WSMan:\localhost\Client\TrustedHosts -Value 'demo-dc' -Concatenate
Set-Item WSMan:\localhost\Client\TrustedHosts -Value 'vagrant-10' -Concatenate
Set-Item WSMan:\localhost\Client\TrustedHosts -Value 'vagrant-100' -Concatenate

Set-Item WSMan:\localhost\Client\TrustedHosts -Value "*"

Get-ChildItem WSMan:\localhost\Client\TrustedHosts
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
enter-pssession $env:COMPUTERNAME -Credential $Creds

# Invoke-command
Invoke-Command -computerName demo-dc, "vagrant-10", localhost  -Credential (Get-Credential) -command { Get-EventLog Security | Where-Object {$_.eventID -eq 4826}}

# Sessions
$sessions = New-PSSession -ComputerName demo-dc, "vagrant-10" -Credential $creds
Disconnect-PSSession -Name 'runspace17'
Connect-PSSession
Remove-PSSession

Enter-PSSession -Session $sessions[1]
Enter-PSSession -Session ($sessions |Where-Object { $_.computername -eq "demo-dc" })
Enter-PSSession -Session (Get-PSSession -ComputerName 'vagrant-10' -Credential $creds)

$s_server1,$s_server2,$s_server3,$s_server4 = new-pssession -computer 'localhost', $env:COMPUTERNAME, 'demo-dc', "vagrant-10" -Credential $creds

Invoke-Command -Command { Get-CimInstance Win32_Process } -Session $sessions | Format-Table -Property PSComputerName, processname, ProcessID, ParentProcessID

invoke-command -command { Get-CimInstance Win32_Process } -session $sessions | Select-Object ProcessName, PSComputerName, Path | Group-Object ProcessName | Sort-Object Count -Descending | Format-Table -AutoSize

# implicit remoting
$session = new-pssession demo-dc -Credential $creds
invoke-command -command { import-module activedirectory } -Session $session
import-pssession -session $session -module activedirectory -prefix ISSA

#research implicit remoting temp name

# PowerShell over SSH
# Install SSH Client and Server
Get-WindowsCapability -Online | Where-Object {$_.Name -like 'OpenSSH*'}
Add-WindowsCapability -Online -name 'OpenSSH.Server~~~~0.0.1.0'
start-servcice sshd

# Edit sshd_config on Windows
notepad.exe $env:ProgramData\ssh\sshd_config
# PasswordAuthentication Yes
# Create the SSH subsystem that hosts a PowerShell process on the remote computer:
# Get-CimInstance Win32_Directory -Filter 'Name="C:\\Program Files"' | Select-Object EightDotThreeFileName
# Subsystem powershell c:/progra~1/powershell/7/pwsh.exe -sshs -NoLogo
# PubkeyAuthentication yes
# Restart-Service sshd

# Edit sshd_config on Linux
sudo apt install openssh-client
sudo apt install openssh-server
# Edit the sshd_config file at location /etc/ssh
# PasswordAuthentication yes
# PubkeyAuthentication yes
# Subsystem powershell /usr/bin/pwsh -sshs -NoLogo
sudo systemctl restart sshd.service

Enter-PSSession -HostName 192.168.77.148 -UserName vagrant

###############################################################################
code '.\Scripts\Examples\Check-ServerReboot.ps1'
###############################################################################

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
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name LocalAccountTokenFilterPolicy -Value 0 -Type DWord
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