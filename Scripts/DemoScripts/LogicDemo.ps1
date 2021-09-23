#If/Elses
#
 $a = 11
if (($a -gt 2) -and ($a -le 10))
    {Write-Host "The Value `$a is greater than 2 less than 10."}
elseif  ($a -le 2)
    {Write-Host "The value `$a is less than 2."}
else {Write-Host "The value `$a is greater than 10."} 

#>

######################################################################################
code .\Scripts\Examples\New-ADUser_Prompted.ps1
######################################################################################

#Switch
#
[string]$a = 14
switch ($a)
         {
            1 {"It is one."}
            2 {"It is two."}
            3 {"It is three."; Break}
            4 {"It is four."}
            3 {"Three again."}
    Default {"I have know idea what this is!!!!!"}         
        }
#>

######################################################################################
code ".\Scripts\Examples\Get-IOCs.ps1"
code ".\Scripts\Examples\ViewVM-SetState.ps1"
######################################################################################

# ternary operator PWSH 7
$IsWindows ? (Write-Host "This is a Windows Machine") : (Write-Host "This is not a Windows machine")

#ForEach
#
$letters = "a","b","c","d"
foreach ($letter in $letters) {Write-Host $letter}

1..25 | ForEach-Object {New-Item -Type File -Name "file$_.pdf" -Path .\TempFiles\}
0..255| ForEach-Object {"192.168.10.$_" | Tee-Object .\TempFiles\IPList.txt -Append}
#>

######################################################################################
 code “.\Scripts\Examples\Get-InactiveUsers.ps1”
######################################################################################

#For

for($i=1; $i -le 100; $i++){Write-Host $i}

######################################################################################

#Do-Until

######################################################################################
code .\Scripts\Examples\lockaccounts.ps1
######################################################################################

#Do-While

######################################################################################
code .\Scripts\Examples\Generate-Files.ps1
######################################################################################

#While

######################################################################################
code .\Scripts\Examples\Invoke-RandomUser.ps1
######################################################################################

do
    {
        if ($x[$a] -lt 0) { continue }
        Write-Host $x[$a]
    }
        while (++$a -lt 10)