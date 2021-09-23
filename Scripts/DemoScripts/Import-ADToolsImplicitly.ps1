Set-Item WSMan:\localhost\Client\TrustedHosts -Value '*'
$creds = Get-Credential vagrant

$session = new-pssession -ComputerName 'demo-dc' -Credential $creds
invoke-command -command{import-module activedirectory} -session $session
import-pssession -session $session -module activedirectory -prefix BSides-

