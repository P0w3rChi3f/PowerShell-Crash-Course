# Start
<#

Get-WmiObject -class Win32_LogicalDisk -computername localhost -filter "drivetype=3" |
    Sort-Object -property DeviceID |
    Format-Table -property DeviceID,
        @{label='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
        @{label='Size(GB)';expression={$_.Size / 1GB -as [int]}},
        @{label='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}

#>

##################################################################################################################

# Add Variables to top of Script
<#
$computer = 'localhost'

Get-WmiObject -class Win32_LogicalDisk `
    -computername $computer `
    -filter "drivetype=3" |
    Sort-Object -property DeviceID |
    Format-Table -property DeviceID,
        @{label='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
        @{label='Size(GB)';expression={$_.Size / 1GB -as [int]}},
        @{label='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}

#>

##################################################################################################################

# Paramiterized Script
<#
param (
$computername = 'localhost'
)

Get-WmiObject -class Win32_LogicalDisk `
    -computername $computername `
    -filter "drivetype=3" |
    Sort-Object -property DeviceID |
    Format-Table -property DeviceID,
        @{label='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
        @{label='Size(GB)';expression={$_.Size / 1GB -as [int]}},
        @{label='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}

#>

##################################################################################################################

# Two parameters in parameterized script

<#

param (
$computername = "localhost",
$driveType = 3
)

Get-WmiObject -class Win32_LogicalDisk `
    -computername $computername `
    -filter "drivetype=$driveType" |
    Sort-Object -property DeviceID |
    Format-Table -property DeviceID,
        @{label='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
        @{label='Size(GB)';expression={$_.Size / 1GB -as [int]}},
        @{label='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}

#>

##################################################################################################################

# Documenting Parameterized Script

<#
.SYNOPSIS
Get-DiskInventory retrieves logical disk information from one or
more computers.

.DESCRIPTION
Get-DiskInventory uses WMI to retrieve the Win32_LogicalDisk
instances from one or more computers. It displays each disk's
drive letter, free space, total size, and percentage of free
space.

.PARAMETER computername
The computer name, or names, to query. Default: Localhost.

.PARAMETER drivetype
The drive type to query. See Win32_LogicalDisk documentation
for values. 3 is a fixed disk, and is the default.

.EXAMPLE
Get-DiskInventory -computername SERVER-R2 -drivetype 3

#>
<#
param (
$computername = "localhost",
$driveType = 3
)

Get-WmiObject -class Win32_LogicalDisk `
    -computername $computername `
    -filter "drivetype=$driveType" |
    Sort-Object -property DeviceID |
    Format-Table -property DeviceID,
        @{label='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
        @{label='Size(GB)';expression={$_.Size / 1GB -as [int]}},
        @{label='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}

#>
##################################################################################################################

# Improving Parameterized Script

<#
.SYNOPSIS
Get-DiskInventory retrieves logical disk information from one or
more computers.

.DESCRIPTION
Get-DiskInventory uses WMI to retrieve the Win32_LogicalDisk
instances from one or more computers. It displays each disk's
drive letter, free space, total size, and percentage of free
space.

.PARAMETER computername
The computer name, or names, to query. Default: Localhost.

.PARAMETER drivetype
The drive type to query. See Win32_LogicalDisk documentation
for values. 3 is a fixed disk, and is the default.

.EXAMPLE
Get-DiskInventory -computername SERVER-R2 -drivetype 3

#>

#
[CmdletBinding()] 

param (

[Parameter(Mandatory=$True)]
[String]
[Alias('hostname')]
$computername = 'localhost',
[Int]
$driveType = 3
)


Write-Verbose "Connecting to $computername"
Write-Verbose "Looking for drive type $drivetype"

Get-WmiObject -class Win32_LogicalDisk `
    -computername $computername `
    -filter "drivetype=$driveType" |
    Sort-Object -property DeviceID |
    Select-Object -property DeviceID,
        @{label='FreeSpace(MB)';expression={$_.FreeSpace / 1MB -as [int]}},
        @{label='Size(GB)';expression={$_.Size / 1GB -as [int]}},
        @{label='%Free';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}
#>

#################################################################################################################

