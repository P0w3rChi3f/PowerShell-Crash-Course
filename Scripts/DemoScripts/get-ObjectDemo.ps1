tasklist | gm

Get-Process | ConvertTo-HTML | Out-File processes.html
.\processes.html

get-process | get-member | Where-Object {$_.membertype -eq 'Property'} | 
    Group-Object MemberType | Sort-Object count –Descending

(Get-service –name bits).start()
(Get-service –name bits).stop()

(Get-Process wpa_supplicant).Start

Get-Service * | Where-Object {($_.starttype -like "man*") -and ($_.status -eq "Stopped")} | 
    Select-Object -Property Name, Status, StartType

get-service * | Where-Object {$_.starttype -like "man*"} | Select-Object Name, Status, StartType | 
    Group-Object status | Sort-Object count –Descending

Get-Process | Sort-Object VM -descending | Get-Member
Get-Process | Sort-Object VM -descending | Select-Object Name,ID,VM | Get-Member
