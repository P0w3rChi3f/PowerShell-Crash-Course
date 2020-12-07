
#$today = get-date -DisplayHint Date
$45DayCuttoff = (get-date).AddDays(-45)
$SearchBase = "OU=CAC_Users,OU=Users,OU=NGPE,OU=States,DC=ng,DC=ds,DC=army,DC=mil"
$Users = Get-ADUser -Filter {-not(LastLogonTimeStamp -like "*") -or (LastLogonTimeStamp -lt $45DayCuttoff)} -SearchBase $SearchBase -Properties LastLogonTimestamp | Select-Object Name, SamAccountName, Description, @{N='lastLogonTimestamp'; E={[DateTime]::FromFileTime($_.LastLogonTimestamp).ToString('dd MMM yy')}}
$Date = get-date -DisplayHint date -Format ddMMMyy

foreach ($user in $users){

                $user.name +  " has not logged in the past 45 day, Their last login was " + $user.lastLogonTimestamp    #"C:\Scripts\LastLogon\LastLog.csv"
                Disable-ADAccount -Identity $User.SamAccountName
                Set-ADUser -Identity $User.SamAccountName -Description ("Disabled Due to Inactivity ($date) - Ran By Script Last - Logon Date was " + $user.lastLogonTimestamp)
                dsquery user "OU=NGPE,OU=States,DC=ng,DC=ds,DC=army,DC=mil" -name $user.Name | dsmove -newparent "OU=Disabled Accounts,OU=Users,OU=NGPE,OU=States,DC=ng,DC=ds,DC=army,DC=mil"
                
                     }



$User | Export-Csv "\\ngpea7-fl0-1\InfoStore\Information Technology Division\Public\ADCleanUpReports\Users\LastUserLogon_($Date).csv"

$Users = Search-ADAccount -AccountInactive -UsersOnly -SearchBase "OU=CAC_Users,OU=Users,OU=NGPE,OU=States,DC=ng,DC=ds,DC=army,DC=mil" -TimeSpan (New-TimeSpan -Days 45) 

$Users | Out-GridView
