read-host "What is your name?“

Code “C:\Scripts\PowerShell\UserAccounts\Uploaded to GitHub\New-ADUser_Prompted.ps1”

[void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

$computername = [Microsoft.VisualBasic.Interaction]::InputBox('Enter a computer name','Computer Name','localhost')

$computername
