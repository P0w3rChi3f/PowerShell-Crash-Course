#Format-Table
    #-autosize (adjusts to column width)
       Get-Process | Select-Object -last 15 | Format-Table

    #ii) -property (instead of piping to Select-Object)
       Get-Process | Select-Object -last 15 | Format-Table -Property MachineName, ID, ProcessName, responding

    #iii) –groupBy
        Get-Service | Sort-Object -Property status |Format-Table -groupBy Status

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
    ConvertTo-Json | Out-File .\Services.json

#Custom Columns
    Get-Process | Select-Object -first 5 | Format-Table -Property name,vm
    Get-Process | Select-Object -first 5 | 
        Format-Table Name,  @{name='VM(MB)';expression={$_.VM / 1MB -as [int]}} –autosize

Code “C:\Scripts\PowerShell\Server\Uploaded to GitHub\Get-ServerRebootStatus.ps1”

$userData = Import-Csv '.\UserData.csv'

$userData | Select-Object -First 5 | 
    Format-Table -property ID, @{name='FName';expression={$_.first_name}}, 
    @{name='LName';expression={$_.last_name}}, email, gender

$userData | Select-Object ID, @{name='FName';expression={$_.first_name}}, 
    @{name='LName';expression={$_.last_name}}, email, gender | 
    export-csv '.\User.csv' -NoTypeInformation

get-command out-*

Write-Host "Colorful Text!" -ForegroundColor black -BackgroundColor Green

$OriginalFC = $host.ui.RawUI.ForegroundColor
$OriginalBC = $host.UI.RawUI.BackgroundColor
$host.ui.RawUI.ForegroundColor = “Red”
$host.UI.RawUI.BackgroundColor = "Yellow"

Write-output 'Hello'
write-output "Hello" | where-object { $_.length -ge 5 } | out-default | write-host

$host.ui.RawUI.ForegroundColor = $OriginalFC
$host.UI.RawUI.BackgroundColor = $OriginalBC


Get-ChildItem C:\Users\$env:USERNAME\Documents\*.pdf; Write-Information -MessageData "Here are your PDFs!" #-InformationAction Continue
