Code C:\Scripts\PowerShell\_InProgress\Create-EvilTask.ps1
# Start a job
start-job -ScriptBlock {Get-Service} 
start-job -scriptblock {get-eventlog security -computer localhost, $env:COMPUTERNAME } -Credential $creds

# WMI as job
start-job -scriptblock {get-eventlog security -computer localhost, $env:COMPUTERNAME } -Credential $creds

Get-jobs | receive-jobs

#####################################################################
Code .\Scripts\Examples\Create-EvilTask.ps1
#####################################################################

#Digital Signatures PWSHv5
Set-AuthenticodeSignature ".\Scripts\Examples\Backup-Files.ps1" `
    (get-childitem Cert:\CurrentUser\My -CodeSigningcert)

#####################################################################
code ".\Scripts\Examples\Backup-Files.ps1"
#####################################################################