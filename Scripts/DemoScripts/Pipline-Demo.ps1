Get-Service | ConvertTo-HTML | Out-File .\TempFiles\services.html ; .\TempFiles\services.html

notepad.exe
Get-Process -name Notepad | Stop-Process

get-process | Out-GridView
get-process | export-csv .\TempFiles\processes.csv -NoTypeInformation -force
.\TempFiles\processes.csv

###############################################################################################
# Demo in PWSHv5
###############################################################################################
$localName = "$env:COMPUTERNAME", 'localhost', 'DEMO-DC', 'Demo-Client', 'Demo-LinuxClient'
$localName | Out-File .\TempFiles\servers.txt -Force
 
code .\TempFiles\servers.txt

$localServices = 'ClickToRunSvc', 'SSDPSRV', 'Themes'
$localServices | Out-File .\TempFiles\services.txt -Force
code .\TempFiles\services.txt

Get-help get-service -Full


Get-content .\TempFiles\servers.txt | Get-Service #(fail)
Get-Service -ComputerName (Get-Content .\TempFiles\servers.txt)
Get-Service | Get-Member | Select-Object -First 4
Get-Service -ComputerName $env:COMPUTERNAME, localhost
Get-process -name note* | stop-process #(win)


