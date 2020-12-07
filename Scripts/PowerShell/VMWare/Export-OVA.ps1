# Requires PowerCLI
# Script will fail if there is a space in the name

param (
    [cmdletBinding()]
        [parameter(Mandatory=$true)]
        [alias("Host","vCenter")]
        [ValidatePattern("[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}")]
        [String[]] $Vsphere             
    )

function Export-OVA { 
    
    
    process {
        $PowerCLIInstalled = test-path "C:\Program Files (x86)\WindowsPowerShell\Modules\VMware.PowerCLI"
    
        if ($PowerCLIInstalled) 
            {write-host "PowerCLI is installed"} 
        else 
            {Write-Host "PowerCLI is being installed"
             Install-Module -Name VMware.PowerCLI}

        #Connecting to Vsphere or ESXi Host
        Write-host "Connecting to " $Vsphere
        Connect-VIServer $Vsphere -force

        if (test-path .\OVA)
            {Write-host "OVA directory already exists"}
        else {
            write-host "Creating new directory at $(get-location)\OVA and exporting OVAs"
            New-Item -ItemType Directory -Path .\OVA
        }

        Write-host "Exporting OVA Files to $(get-location)\OVA"
        get-vm * | Export-VApp -Destination .\OVA\ -Format ova

        Disconnect-VIServer -Confirm:$false
    }
    
}

export-OVA $Vsphere