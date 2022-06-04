#Format-Table
    #-autosize (adjusts to column width)
       Get-Process | Select-Object -last 15 | Format-Table

    #ii) -property (instead of piping to Select-Object)
       Get-Process | Select-Object -last 15 | Format-Table -Property MachineName, ID, ProcessName, responding

    #iii) –groupBy
        Get-Service | Sort-Object -Property status |Format-wide -groupBy Status

    #iv) –wrap
       Get-Service | Format-Table Name,Status,DisplayName -autoSize –wrap

#Format-Wide (wide list)
        Get-Service | Format-Table

#Format-list
    #-property
        Get-Process | Format-list -Property Name,ID

    #-groupBy
        Get-Process | Format-list -Property Name,ID -GroupBy name

    #-others
#out-*
get-command out-*
Get-Service | Group-Object -Property Status | Sort-Object -Property Count -Descending | 
    ConvertTo-Json | Out-File .\TempFiles\Services.json

#Custom Columns
    Get-Process | Select-Object -first 5 | Format-Table -Property name,vm
    Get-Process | Select-Object -first 5 | 
        Format-Table Name,  @{name='VM(MB)';expression={$_.VM / 1MB -as [int]}} –autosize

Code '.\Scripts\Examples\Check-ServerReboot.ps1'

$userData = Import-Csv '.\NeedFiles\UserData.csv'

$userData | Select-Object -First 5 | 
    Format-Table -property ID, @{name='FName';expression={$_.first_name}}, 
    @{name='LName';expression={$_.last_name}}, email, gender

$userData | Select-Object ID, @{name='FName';expression={$_.first_name}}, 
    @{name='LName';expression={$_.last_name}}, email, gender | 
    export-csv '.\User.csv' -NoTypeInformation

get-command out-*

Write-Host "Colorful Text!" -ForegroundColor red -BackgroundColor Yellow

#demo in a terminal
$OriginalFC = $host.ui.RawUI.ForegroundColor
$OriginalBC = $host.UI.RawUI.BackgroundColor

$host.ui.RawUI.ForegroundColor = "gree"
$host.UI.RawUI.BackgroundColor = "Yellow"

Write-output 'Hello'
write-output "Hello" | where-object { $_.length -ge 6 } | out-default | write-host

$host.ui.RawUI.ForegroundColor = $OriginalFC
$host.UI.RawUI.BackgroundColor = $OriginalBC


Get-ChildItem .\TempFiles\*.pdf; Write-Host "Here are your PDFs!" -ForegroundColor Red -BackgroundColor Yellow #-InformationAction Continue

0..255| ForEach-Object {"192.168.10.$_" | Tee-Object .\TempFiles\IPList.txt -Append}
code .\TempFiles\IPList.txt