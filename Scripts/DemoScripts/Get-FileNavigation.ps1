get-help about_Providers
Get-PSProvider

Get-childitem .\Scripts\*\????????.ps1
Get-childitem .\Scripts\*\????.ps1
Get-childitem .\Scripts\*\*.ps1
Get-childitem .\*\*.ps1
Get-childitem .\*\*\*.ps1

Get-childitem HKLM:\Software\Microsoft\Windows\CurrentVersion\Run
Get-childitem HKCU:\Software\Microsoft\Windows\CurrentVersion\Run
Get-childitem HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce
Get-childitem HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce

Measure-Command -Expression {Get-childitem HKCU:\Software\*\*\*\}
Measure-Command -Expression {Get-childitem HKCU:\Software\Microsoft\Windows\CurrentVersion}
