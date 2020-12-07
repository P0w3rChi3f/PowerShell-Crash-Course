# Check to see if PowerShell SSH is available
(Get-Command New-PSSession).ParameterSets.Name

<# Results of prvious command
SSHHost
SSHHostHashParam
#>

###############################################################################################
# Windows Setup and Configuration
###############################################################################################

# Check to see if clent and server is installed
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'

# Install the OpenSSH Client
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# Install the OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

#initial config

# OPTIONAL but recommended:
Set-Service -Name sshd -StartupType 'Automatic'
Set-Service -Name ssh-agent -StartupType 'Automatic'
Start-Service ssh-agent
Start-Service sshd

# Confirm the Firewall rule is configured. It should be created automatically by setup.
Get-NetFirewallRule -Name *ssh*
# There should be a firewall rule named "OpenSSH-Server-In-TCP", which should be enabled
# If the firewall does not exist, create one
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22


# Edit the sshd_config file located at $env:ProgramData\ssh
PasswordAuthentication yes

# Create the SSH subsystem that hosts a PowerShell process on the remote computer:
Subsystem powershell c:/progra~1/powershell/7/pwsh.exe -sshs -NoLogo
# Must use 8.3 shortnames 
Get-CimInstance Win32_Directory -Filter 'Name="C:\\Program Files"' |
  Select-Object EightDotThreeFileName

  ###########################################################################################################################
  # Linux Config (CentOS 8)
  ###########################################################################################################################

  # Install Client and Server (must be in bash shell, I ran into issues doing this from pwsh)
  yum install openssh

  # Edit the sshd_config file at location /etc/ssh

PasswordAuthentication yes
Subsystem powershell /usr/bin/pwsh -sshs -NoLogo

systemctl restart sshd
