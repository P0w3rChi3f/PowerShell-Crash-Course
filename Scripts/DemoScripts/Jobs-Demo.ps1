$creds = Get-Credential vagrant
$machines = 'localhost', $env:COMPUTERNAME, 'demo-dc', "vagrant-10"


# Start a job
start-job -ScriptBlock {Get-Service} 
Get-Job
Receive-Job -Keep
Start-Job -ScriptBlock {Invoke-Command -ComputerName 'demo-dc', 'vagrant-10', localhost, $env:COMPUTERNAME -Credential $creds -ScriptBlock {Get-WinEvent -LogName Security}}

Get-job | receive-job

#####################################################################
Code .\Scripts\Examples\Create-EvilTask.ps1
#####################################################################

#Digital Signatures PWSHv5
Set-AuthenticodeSignature ".\Scripts\Examples\Backup-Files.ps1" `
    (get-childitem Cert:\CurrentUser\My -CodeSigningcert)

#####################################################################
code ".\Scripts\Examples\Backup-Files.ps1"
#####################################################################