Get-WmiObject -Namespace root\CIMv2 -list | Where-Object {$_.name -like '*dis*'} 
Get-WmiObject -class win32_desktop -filter "name='DESKTOP-52INA1A\\honey’”

& C:\Users\honey\Desktop\WmiExplorer.exe

get-help about_WMI
get-help about_WMI_Cmdlets
