
#Snapins
Code “C:\Scripts\PowerShell\VMware\Refresh-availableVMs.ps1”
################################################################################

#Modules
Code “C:\Scripts\PowerShell\UserAccounts\New-ADUser_Prompted.ps1”
Code “C:\Scripts\PowerShell\VMware\Export-OVA.ps1”
################################################################################

Get-module –listavailable
Get-command *host*
Get-help get-host
Get-help get-vmhost

$env:psmodulepath

get-module -ListAvailable VM* | ForEach-Object ($_.name) { install-Module -Name $_.Name}
get-module -ListAvailable VM* | ForEach-Object ($_.name) { Uninstall-Module -Name $_.Name}
