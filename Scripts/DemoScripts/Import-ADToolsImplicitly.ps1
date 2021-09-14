Set-Item WSMan:\localhost\Client\TrustedHosts -Value '192.168.42.230'
$creds = Get-Credential demo\vagrant

$session = new-pssession -ComputerName '192.168.42.230' -Credential $creds
invoke-command -command{import-module activedirectory} -session $session
import-pssession -session $session -module activedirectory -prefix rem

