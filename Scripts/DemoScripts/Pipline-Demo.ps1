Get-Service | ConvertTo-HTML | Out-File services.html ; .\services.html

notepad.exe
Get-Process -name Notepad | Stop-Process

get-process | Out-GridView
get-process | export-csv .\processes.csv -NoTypeInformation -force
.\processes.csv

###############################################################################################
 
$localName = 'DESKTOP-62EO89A', 'localhost'
$localName | Out-File .\servers.txt -Force
 
.\servers.txt

$localServices = 'ClickToRunSvc', 'SSDPSRV', 'Themes'
$localServices | Out-File .\services.txt -Force
.\services.txt

Get-help get-service –full


Get-content .\servers.txt | Get-Service #(fail)
Get-Service -ComputerName Desktop-62EO89A,localhost
Get-process -name note* | stop-process #(win)


