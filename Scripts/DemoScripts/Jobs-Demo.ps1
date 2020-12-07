Code C:\Scripts\PowerShell\_InProgress\Create-EvilTask.ps1
# Start a job
start-job -ScriptBlock {Get-Service} 
start-job -scriptblock {get-eventlog security -computer localhost, DESKTOP-52INA1A } -Credential $creds

# WMI as job
start-job -scriptblock {get-eventlog security -computer localhost, DESKTOP-52INA1A } -Credential $creds

Get-jobs | receive-jobs

#####################################################################
Code 'C:\Scripts\PowerShell\_InProgress\Create-EvilTask.ps1'
#####################################################################

#Digital Signatures PWSHv5
Set-AuthenticodeSignature "C:\Scripts\Publish\PowerShell\Files\Backup-Files.ps1" `
    (get-childitem Cert:\CurrentUser\My -CodeSigningcert)

#####################################################################
code "C:\Scripts\Publish\PowerShell\Files\Backup-Files.ps1"
#####################################################################