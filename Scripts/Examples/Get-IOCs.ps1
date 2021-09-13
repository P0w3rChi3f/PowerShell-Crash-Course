#######################################################
###         Created by CW3 James Honeycutt          ###
###                 13 March 2020                   ###
###                                                 ###
###         SANs Community Instructor for SEC505    ###
###                  and SEC511                     ###    
###                                                 ###
###             Twitter: @P0w3rChi3f                ###
####################################################### 

try {
    Set-ExecutionPolicy RemoteSigned -Confirm:$false -Force
}
catch {}

function Get-IOCs {
    <#
    .SYNOPSIS 
        Script take in a .txt file and pull out IOC type information then formatsit for Zeek Intel Framwork.

    .DESCRIPTION
        Script take in a .txt file and pull out IOC type information then formatsit for Zeek Intel Framwork.  You can use the provided regexto pull the information or you can provide your own.  This allows you the flexability to search text documents for specific IOCs (Indicators of Compromise).  The tab separated test file (.tsv) for Zeek will be stored in the oporators documents forlder with the name of ZeekIntelFrameworkFile.tsv.

    .PARAMETER URLPattern
        This parameter defaults to ([A-Za-z]+://)([-\w]+(?:\.\w[-\w]*)+)(:\d+)?(/[^.!,?"<>\[\]{}\s\x7F-\xFF]*(?:[.!,?]+[^.!,?"<>\[\]{}\s\x7F-\xFF]+)*)?    You have the flexability to use your own or change it to something like http:\\www.google.com

    .PARAMETER HashPattern
        This parameter defaults to (\b[A-F-0-9]{32}\b)|(\b[A-F-0-9]{40}\b)|(\b[A-F-0-9]{64}\b)|(\b[A-F-0-9]{96}\b)|(\b[A-F-0-9]{128}\b)|(\b[A-F-0-9]{192}\b)|(\b[A-F-0-9]{256}\b)    You have the flexability to change it to any known hash value you wish to look for.

    .PARAMETER IPPattern
        This parameter defaults to (?:(?:\d|[01]?\d\d|2[0-4]\d|25[0-5])\.){3}(?:25[0-5]|2[0-4]\d|[01]?\d\d|\d)(?:\/\d{1,2})?    It only searches for IPv4 addresses, but gives you the flexability to add an IPv6 regex or specify a single IP. 

    .PARAMETER Outpath
        You can change the path location of the output file

    .EXAMPLE
        Get-IOCs

    .EXAMPLE
        Get-IOCs -HashPatter (\b[A-F-0-9]{32}\b)

    .EXAMPLE
        Get-IOCs -URLPattern https://badguyURL.com
    .EXAMPLE
        Get-IOCs -IPPattern 1.1.1.1

    .NOTES
        More IOCs can be added to the script.  There are five (5) places you need to modify to add another IOC.
            1.  In the "Variables to Populate", create a variable with the corrispondig REGEX pattern.
            2.  Add another property un "Create My Custom IOC Object".
            3.  Under the "Create the Output Object" you have to add a property to the switch function and tell it what the Zeek Indicator type is. Reference https://blog.zeek.org/2014/01/intelligence-data-and-bro_4980.html
            4.  Under the "ZeekOutPut Object" you need to create a property of a key:value pair.
            5.  In the "Output Zeek File" you have to add the new property to the select statement.
    #>

    # Variables to populate IOC Object
    [CmdletBinding()]
    param (
        # Create the REGEX patterns
        [Parameter()]
        [String]
        $URLPattern = '([A-Za-z]+://)([-\w]+(?:\.\w[-\w]*)+)(:\d+)?(/[^.!,?"<>\[\]{}\s\x7F-\xFF]*(?:[.!,?]+[^.!,?"<>\[\]{}\s\x7F-\xFF]+)*)?',

        [Parameter()]
        [String]
        $HashPattern = '(\b[A-F-0-9]{32}\b)|(\b[A-F-0-9]{40}\b)|(\b[A-F-0-9]{64}\b)|(\b[A-F-0-9]{96}\b)|(\b[A-F-0-9]{128}\b)|(\b[A-F-0-9]{192}\b)|(\b[A-F-0-9]{256}\b)',

        [Parameter()]
        [String]
        $IPPattern = '(?:(?:\d|[01]?\d\d|2[0-4]\d|25[0-5])\.){3}(?:25[0-5]|2[0-4]\d|[01]?\d\d|\d)(?:\/\d{1,2})?',

        [Parameter()]
        [String]
        $DatePattern = '\d{6}Z\s(?:Jan(?:uary)?|Feb(?:ruary)?|Mar(?:ch)?|Apr(?:il)?|May?|June?|July?|Aug(?:ust)?|Sep(?:tember)?|Oct(?:ober)?|Nov(?:ember)?|Dec(?:ember)?)\s(?:19|20)?(?:9[0-9]|2[0-9]|(?:Jan(?:uary)?|Feb(?:ruary)?|Mar(?:ch)?|Apr(?:il)?|May?|June?|July?|Aug(?:ust)?|Sep(?:tember)?|Oct(?:ober)?|Nov(?:ember)?|Dec(?:ember)?)\s?(\d{2}).\s([19|20][0-9]\d{2})',

        [Parameter()]
        [String]
        $filename = "ZeekIntelFrameworkFile.tsv",

        [Parameter()]
        [String]
        $OutPath = "$env:USERPROFILE\Documents"

    )# Close Parameter Block

    # Create a file browser input box and creae my file variable
    Add-Type -AssemblyName System.Windows.Forms
    $FileBrowser = New-Object System.Windows.forms.OpenFileDialog -Property @{
        InitialDirectory = [System.Environment]::GetFolderPath('Desktop')
    }# Close file browser object

    $FileBrowser.ShowDialog()
    $InputFile = Get-Content $FileBrowser.FileName

    $OutPutFile = $OutPath + $filename

    #Create my custom IOC object
    $IOCs = [PSObject]@{
        IP = $InputFile | Select-String -Pattern $IPPattern -AllMatches | Select-Object -Expand Matches | Select-Object -Expand Value
        URLs = $InputFile | Select-String -Pattern $URLPattern -AllMatches | Select-Object -Expand Matches | Select-Object -Expand Value
        Hashes = $InputFile | Select-String -Pattern $HashPattern -AllMatches | Select-Object -Expand Matches | Select-Object -Expand Value
    }# Close IOC Object

    # Create the output object
    $IndicatorSource = $InputFile[0].PSChildName
    $Date = $InputFile | Select-String -Pattern $DatePattern | Select-Object -ExpandProperty Matches | Select-Object -ExpandProperty Value | Select-First 1
    $MetaDoNotice = "T"

    $ZeekOutPut = @()

    foreach ($key in $IOCs.keys) {
        switch ($key) {
            IP {$IndicatorType = 'Intel::ADDR'}
            URLs {$IndicatorType = 'Intel::URL'}
            Hashes {$IndicatorType = 'Intel::Hash'}
        Default {}
        }# Close Switch Block

        # Builds the ZeekOutPut Object
        foreach ($value in $IOCs.$key){
            $ZeekOutPut += New-Object -TypeName psobject -Property @{Value = $value; IndicatorType = $IndicatorType; IndicatorSource = $IndicatorSource; MetaDoNotice = $MetaDoNotice; Date = $Date}
        }# Close IOC Value Foreach block
    }# Close IOC Key Foreach block

    #Output the Zeek file
    $ZeekOutPut | Select-Object '#fields_indicator', Value, IndicatorType, IndicatorSource, MetaDoNotice , Date | Export-Csv -Delimiter "`t" $OutPutFile -NoTypeInformation

    (Get-Content $OutPutFile) | ForEach-Object {$_ -replace '"', ''} | Out-File $OutPutFile -Force -Encoding ascii
    
}# Close IOC Function

Get-IOCs