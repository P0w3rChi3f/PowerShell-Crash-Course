Measure-command -expression {Get-Service -name *B* | Stop-Service}
Measure-command -expression {Get-Service -name *B* | ForEach-Object { $_.Stop()}}
Measure-command -expression {Get-WmiObject Win32_Service -filter "name LIKE '%B%'" | Invoke-WmiMethod -name StopService}
Measure-command -expression {Get-WmiObject Win32_Service -filter "name LIKE '%B%'" | ForEach-Object { $_.StopService()}}
Measure-command -expression {Stop-Service -name *B*}