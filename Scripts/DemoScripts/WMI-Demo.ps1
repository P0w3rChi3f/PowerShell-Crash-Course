Get-WmiObject -Namespace root\CIMv2 -list | Where-Object {$_.name -like '*dis*'} 
Get-WmiObject -class win32_desktop -filter "name='169BASEIMAGE\\169user'"

& C:\Users\169user\Desktop\Tools\WMIExplorer_2.0.0.0\WmiExplorer.exe 

get-help about_WMI
get-help about_WMI_Cmdlets
