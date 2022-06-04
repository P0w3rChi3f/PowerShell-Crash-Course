Update-Help

Get-Command *even*
# Discover Commands
get-help Get-WinEvent
get-help Set-ExecutionPolicy

Get-Command get-*event*
Get-NetFirewallRule | Get-Member
(Get-NetFirewallRule).Description
Show-Command Get-process
Get-alias gci

# External Commands
sc.exe qc "bits"
Get-CimInstance Win32_Service | Where-Object {$_.name -like "Bits"} | Select-Object PSConfiguration, PSStatus
Get-Service bits | Select-Object Name, DisplayName, StartType, StartUpType, BinaryPathName, DependentServices, ServiceDependsOn, ServiceType

$NBTSTAT = nbtstat /n | select-string "<" | Where-Object {$_ -notmatch "__MSBROWSE__"} | ForEach-Object {$_.Line.trim()} | ForEach-Object {$temp = $_ -split "\s+"; [PSCUstomObject]@{Name = $temp[0]; NBTCode = $temp[1]; Type = $temp[2]; Status = $temp[3]}} $NBTSTAT

dir /Q
cmd /c "dir /Q"




