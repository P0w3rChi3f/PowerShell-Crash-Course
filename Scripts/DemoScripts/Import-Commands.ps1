get-command *sql*
Find-module *sql*
Find-Module sqlserver 
Install-module SqlServer

get-command *sql*
get-command -module SqlServer

Set-PSRepository –name “MyLocalStore”

#########################################################################

Uninstall-Module sqlserver -Force

