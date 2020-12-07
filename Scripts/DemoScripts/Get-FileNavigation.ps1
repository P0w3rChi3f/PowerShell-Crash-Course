Get-childitem C:\Scripts\*\?????????.ps1
Get-childitem C:\Scripts\*\????.ps1
Get-childitem C:\Scripts\*\*.ps1
Get-childitem C:\*\*.ps1
Get-childitem C:\*\*\*.ps1

Get-childitem HKLM:\Software\Microsoft\Windows\CurrentVersion\Run
Get-childitem HKCU:\Software\Microsoft\Windows\CurrentVersion\Run
Get-childitem HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce
Get-childitem HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce

Measure-Command -Expression {Get-childitem HKCU:\Software\*\*\*\}
Measure-Command -Expression {Get-childitem HKCU:\Software\Microsoft\Windows\CurrentVersion}
