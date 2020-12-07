


#$password = "PassWord"

$Testusers = Get-ADUser -Filter * -SearchBase "OU=LockedOutTest,OU=HRRTC101,OU=Users,OU=VDI,OU=PE,OU=States,DC=org" -Properties SamAccountName, UserPrincipalName, LockedOut 
    
    
    ForEach ($user in $TestUsers) {
        
        Do {Invoke-Command -ComputerName ngpevmtestscript -Credential $user.SamAccountName -ErrorAction SilentlyContinue -ScriptBlock {Get-Process}
            }
        Until ((Get-ADUser -Identity $user.SamAccountName -Properties LockedOut).LockedOut)

        Write-Output "$($user.SamAccountName) has been locked out"

    }



 #GET-ADUSER –filter * –searchbase ‘CN=Legal,CN=Boston,DC=Blueville,DC=Local’ | UNLOCK-ADACCOUNT


 

