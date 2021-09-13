        
$session = New-PSSession –Computername VMWareViewBroker.FQDN.com

Invoke-Command -Session $session -ScriptBlock {


   Get-PSSnapin -name VMware* -Registered | Add-PSSnapin -Verbose
    
    $VMDesktop = Get-DesktopVM -Pool_id Powershell_Test
    $RemoteStatus = @{}
    foreach ($node in $VMDesktop) { 
        try {
            Get-RemoteSession -DnsName $node.HostName -ErrorAction Stop
            $RemoteStatus.Add($node.HostName, "Connected")
        }

        catch [System.Exception] {
            write-host $node.HostName "is available"
            $RemoteStatus.add($node.HostName, "Available")
        }
    }
   
    foreach ($item in $RemoteStatus.keys) {
    if ($RemoteStatus.Values -ne "CONNECTED") {

        Try {
             Remove-UserOwnership -Machine_id $item -ErrorAction SilentlyContinue
            }
       
         Catch [RemoveUserOwnership]
            {
            Write-host "No User assigned to machine"
            }
         Finally {
            $item | Send-LinkedCloneRefresh -Schedule (Get-date) -ForceLogoff $true
             }
    }
 } 
}


