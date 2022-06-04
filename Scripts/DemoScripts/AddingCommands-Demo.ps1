
#Snapins
Code “.\Scripts\Examples\Refresh-availableVMs.ps1”
################################################################################

#Modules
Code “.\Scripts\Examples\New-ADUser_Prompted.ps1”
Code “.\Scripts\Examples\Export-OVA.ps1”
################################################################################

Get-module -ListAvailable
Get-command *host*
Get-help get-host
Get-help get-vmhost

Install-Module -Name VMware.PowerCLI

($env:psmodulepath).Split(";")

get-module -ListAvailable VM* | ForEach-Object ($_.name) { install-Module -Name $_.Name}
get-module -ListAvailable VM* | ForEach-Object ($_.name) { Uninstall-Module -Name $_.Name}
