Function ViewVM-SetState {
    [cmdletBinding()]
    Param (
        [parameter(Mandatory=$true)]
        [string]$vm,                    #VM name
        [parameter(Mandatory=$true)]
        [ValidateSet("MAINTENANCE","READY","DELETING","ERROR")] 
        [string]$state,                    #State to set the VM to
        [parameter(Mandatory=$true)]
        [string]$ViewIPAddress,            #Connection Server IP Address
        $credential                        #Connection Server Credential
    )

    $ldapBaseURL = 'LDAP://'+$ViewIPAddress + ':389/'
    $script = [scriptblock]::Create("(Get-DesktopVM -Name $vm).machine_id")
    $session = New-PSSession -ComputerName $ViewIPAddress -Credential $credential

    $Machine_Id = Invoke-Command -Session $session -ScriptBlock $script

    $objMachine_Id = [ADSI]($ldapBaseURL + "cn=" + $Machine_Id + ",ou=Servers,dc=vdi,dc=vmware,dc=int")
    $objMachine_Id.PSBase.UserName = "administrator"
    $objMachine_Id.PSBase.Password = "password"

    switch ($state) {
        "MAINTENANCE" { 
            $objMachine_Id.put("pae-vmstate", "MAINTENANCE")
        }
        "READY" {
            $objMachine_Id.put("pae-vmstate", "READY")
        }
        "DELETING" {
            $objMachine_Id.put("pae-vmstate", "DELETING")
        }
        "ERROR" {
            $objMachine_Id.put("pae-vmstate", "ERROR")
        }
        default {
            break
        }
    }
    $objMachine_Id.setinfo()

    Return ""
}