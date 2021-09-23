Get-WmiObject -Namespace root\CIMv2 -list | Where-Object {$_.name -like '*disk*'} 
Get-CimClass -Namespace root\CIMv2 | Where-Object {$_.CimClassName -like "*disk*"}

Get-WmiObject -class win32_desktop -filter "name='$env:Computername\\$env:USERNAME'"
Get-CimInstance -ClassName  Win32_Desktop -Filter "name='$env:COMPUTERNAME\\$env:USERNAME'"

& $env:USERPROFILE\Desktop\Tools\WMIExplorer_2.0.0.0\WmiExplorer.exe 

#must update help on PWSHv5 shell
get-help about_WMI
get-help about_WMI_Cmdlets

Get-Help about_CimSession
