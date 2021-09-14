<#
Created by CW2 James Honeycutt
Created on 31 May 2019
Last updated 05 June 2019

TO DO:

Add Error Checking
    Error arises when file name is 255+ characters long
    Error arised in my environment when setting the ACL on root profile folder, but sub folders are set correctly
    
Add EFS to destination folder

Convert to module and have it load on login

#>

<#
.SYNOPSIS
Script to back up files by file type and stores them to a file share

.DESCRIPTION
Script goes through your profile and looks for a default set of file extensions.  The default file extensions are: .pdf, .doc, .docx, .ppt, .pptx, .xls, .xlsx. Other file extensions can be added to the list with the -AddFileExt parameter. The extention must start with a "."(Period) and have a length of 3-5 characters long.  The files are back up to the file share in accordence with the 169CPT Draft File Share SOP.  There is not an option to change the file path at this time

.PARAMETER AddFileExt
Parameter allows you to add additional file extensions to the list to be backed up.  The format of the extension: must start with a period and have a length of 3-5 characters.  Example: .ps1, .py, .back.  To add multiple extensions at onec, they must be separated by a comma.  You can all the parameter by the alias of "EXT" or "filetype".

.PARAMETER SetACL
Switch parameter allows you to tell the script to copy the ACLs from your profile folder and copy them to the backup destination folder.  Probably only need to set this on your first run and not need on the additional runs.

.PARAMETER DestinationPath
Mandatory parameter to set where the files will be copy too.  The parameter can also be call by one of its aliases: DestPath or DPath.

.EXAMPLE
Backup-Files -DestinationPath [path to where the files will be copied]
Basic command to just back up your files

.EXAMPLE
Backup-Files -DestinationPath [] -AddFileExt .ps1
Add an additional file extension to backup with the defaults

.EXAMPLE 
Backup-Files -DestinationPath [] -AddFileExt .ps1, .py, .back
Add multiple file extentions to backup with the defaults

.EXAMPLE
Backup-Files -DestinationPath [] -SetACL
Backup file and set the ACL on the destination folder

.EXAMPLE
Backup-Files [] -AddFileExt .ps1, .py, .back -SetACL
Backup files with additional extentions and set the ACLs on the destination folder


#>
function Backup-Files { 
    [CmdletBinding(SupportsShouldProcess = $True)]
    param (

        [Parameter(Mandatory = $True)]
        [ValidatePattern("[0-9A-Za-z]")]
        [alias('DestPath', 'DPath')]
        [string]
        $DestinationPath,

        [Parameter(Mandatory = $False)]
        [Validatelength(3, 5)]
        [ValidatePattern("^\.[0-9A-Za-z][0-9A-Za-z][0-9A-Za-z]")]
        [alias('ext', 'filetype')]
        [string[]]
        $AddFileExt = $null,

        [Parameter(Mandatory = $false)]
        [switch]
        $SetACL
    ) # Close AddFileExt Parameter

    #param()

    BEGIN {  
        $LoggedOnUser = $env:USERNAME
        $FileExtentions = ".pdf", ".doc", ".docx", ".ppt", ".pptx", ".xls", ".xlsx"
        $profilePath = "C:\users\honey\Documents" #"C:\Users\$LoggedOnUser"
        $DestPath = "c:\Backup\$loggedOnUser"
    } # Close Begin Block

    PROCESS {
        # Create the destination dirctory if it doesn't exist
        If (-not(Test-path $DestPath)) { New-Item -ItemType Directory -Path $DestPath }
        
        # Adds any additional file extentions that need copied
        foreach ($ext in $AddFileExt) {
            $FileExtentions = $FileExtentions + $ext
        }# Close Add Ext ForEach
        
        # Copies each file by extension from users profile to destination directory (keeping file structor integrety)
        foreach ($fileExtension in $FileExtentions) {
            Get-ChildItem $profilePath\*$FileExtension -Recurse | 
                ForEach-Object {
                $SplitFiles = $_.fullname -split '\\'
                $DestFile = $splitFiles[3..($splitFiles.Length -1)] -join '\' 
                $SubPath = $splitFiles[3..($splitFiles.Length -2)] -join '\'
                If (-not(Test-path $DestPath\$SubPath)) { New-Item -ItemType Directory -Path $DestPath\$SubPath }
                Copy-Item -path $_.fullname -Destination $DestPath\$DestFile
            } # Close Copy Foreach
        } # Close FileExtention Foreach
        
        if ($SetACL) {
            $acl = get-acl -path $profilePath 
            $acl.SetAccessRuleProtection($True, $True)
            set-acl -path $DestPath -AclObject $acl
        } # Close Set ACL IF Block

    } # Close Process Block

    END {} # Close End Block
}# Close Function
    

 


<# Add these to the script 

#>
