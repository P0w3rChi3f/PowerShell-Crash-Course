$servers = Get-ADComputer -Filter 'OperatingSystem -like "Windows Server *"' -SearchBase "OU=SubOU3,OU=SubOU2,OU=SubOU1,DC=SubDomain1,DC=SubDomain2,DC=SubDomain3,DC=com"
$date = Get-Date -Format m

foreach ($server in $Servers) {

    $SN = $Server.SamAccountName.Trim('$')

    Invoke-Command -ComputerName $SN -ScriptBlock {

        $path = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\'
        $name = 'PendingFileRenameOperations'
        $keyPresent = Get-ItemProperty -Path $path -Name $name -ErrorAction SilentlyContinue

        if ($keyPresent -ne $null) {

        $keyPresent | Select-Object pscomputername, @{Label='RebootRequired'; Expression={$true}}
        
        }

        else {$keyPresent | Select-Object pscomputername, @{Label='RebootRequired'; Expression={$false}}}

    } | Export-Csv C:\AGMLogs\RebootRequired_$date.csv -Append





} # Close Foreach

