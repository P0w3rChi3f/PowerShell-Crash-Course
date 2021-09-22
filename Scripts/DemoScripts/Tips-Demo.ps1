
Get-WinEvent -Path ".\Scripts\PowerShellCTF\Win7-security.evtx" | 
Where-Object { $_.id -eq 4624 } | Select-Object -ExpandProperty message | 
    Select-String -Pattern "Logon\D+:\s+3" | Measure-Object

#Operators: -as, -is, -replace, -join, -split, -in, -contains as - operator produces a new object in an attempt to convert an existing object into a different type
    1000 / 3 -as [int]

#Is - It’s designed to return True or False if an object is of a particular type or not
    123.45 -is [int]
    "SERVER-R2" -is [string]
    $True -is [bool]
    (Get-Date) -is [datetime]
    
#Replace - operator is designed to locate all occurrences of one string within another and replace those occurrences with a third string (linux sed command)
    "192.168.34.12" -replace "34","15"
    
#join and -split operators are designed to convert arrays to delimited lists, and vice versa (linux Cut, and Awk commands)
    $array = "one","two","three","four","five"
    $array -join "|"
    $string = $array -join "|"
    $string
    
#split - It takes a delimited string and makes an array from it
    $array = (gc computers.tdf) -split "`t"
    
#Contains – operator is used to test whether a given object exists within a collection
    $collection = 'abc','def','ghi','jkl'
    $collection -contains 'abc'
    
#Like - operator is designed for wildcard string comparisons
    'this' -contains '*his*'
    
#String Manipulation
    "Hello" | gm
    
#IndexOf() tells you the location of a given character within the string:
    "SERVER-R2".IndexOf("-")
    
#ToLower() and ToUpper() convert the case of a string
    $computername = "SERVER17"
    $computername.tolower()
    
#Trim() removes whitespace from both ends of a string;
    $username = " Don "
    $username.Trim()

#TrimStart() and TrimEnd() remove whitespace from the beginning or end of a string, respectively
    
#Date manipulation
    get-date | Get-Member
    $90daysago = $today.adddays(-90)

    $90daysago