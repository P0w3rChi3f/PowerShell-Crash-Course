<# 

Created by James Honeycutt
Script was built in PowerShell 2.0

#>

#$today = get-date -DisplayHint Date
$45DayCuttoff = (get-date).AddDays(-45)
$SearchBase = "OU=OU1,OU=Users,OU=OU3,OU=States,DC=SubDomain1,DC=SubDomain2,DC=SubDomain3,DC=com"
$Users = Get-ADUser -Filter {-not(LastLogonTimeStamp -like "*") -or (LastLogonTimeStamp -lt $45DayCuttoff)} -SearchBase $SearchBase -Properties LastLogonTimestamp | Select-Object Name, SamAccountName, Description, @{N='lastLogonTimestamp'; E={[DateTime]::FromFileTime($_.LastLogonTimestamp).ToString('dd MMM yy')}}
$Date = get-date -DisplayHint date -Format ddMMMyy

foreach ($user in $users){

                $user.name +  " has not logged in the past 45 day, Their last login was " + $user.lastLogonTimestamp    #"C:\Scripts\LastLogon\LastLog.csv"
                Disable-ADAccount -Identity $User.SamAccountName
                Set-ADUser -Identity $User.SamAccountName -Description ("Disabled Due to Inactivity ($date) - Ran By Script Last - Logon Date was " + $user.lastLogonTimestamp)
                dsquery user "OU=SubOU3,OU=SubOU2,OU=SubOU1,DC=SubDomain1,DC=SubDomain2,DC=SubDomain3,DC=com" -name $user.Name | dsmove -newparent "OU=Disabled Accounts,OU=SubOU3,OU=SubOU2,OU=SubOU1,DC=SubDomain1,DC=SubDomain2,DC=SubDomain3,DC=com"
                
                     }



$User | Export-Csv "\\FileServer01\Path\to\ShareFolder\ADCleanUpReports\Users\LastUserLogon_($Date).csv"

$Users = Search-ADAccount -AccountInactive -UsersOnly -SearchBase "OU=SubOU3,OU=SubOU2,OU=SubOU1,DC=SubDomain1,DC=SubDomain2,DC=SubDomain3,DC=com" -TimeSpan (New-TimeSpan -Days 45) 

$Users | Out-GridView
