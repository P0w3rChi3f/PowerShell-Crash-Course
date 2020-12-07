###########################################
#    Prompted Create New User Script      #
#                                         #
#    Script Created by James Honeycutt    #
#                                         #
#    Last modified on 12 October 2016     #
###########################################



Import-Module ActiveDirectory

<#
Here is where I get the required Variables from the user
#>
 
$FName = Read-Host 'Please enter the users first name.'
$MidInit = Read-Host 'Please enter the users middle initial.'
$Lname = Read-Host 'Please enter the users last name.'
$personalTitle = Read-Host 'Please enter Mr. Mrs. or Rank.'
$EmployeeType = Read-Host 'Is the user a CIV, NFG, CTR or MIL'
$Office = Read-Host 'What building does the user work in?'
$IPphone = Read-Host 'What is the last four of the users work number?'
$EmployeeID = Read-Host 'What is the users enterprise email prefix'
$JobTitle = Read-Host 'What is the users job title?'
$Department = Read-Host 'What is the users office symble'
$Company = Read-Host 'Please list the users contract company for contractors, Arknasas State Department for state employees, ARNG-PEC for all military and DACs.'
#$env:USERNAME = $EmployeeID
#$Manager

<#
Here are the static variables
#>

$Path = "OU=SubOU3,OU=SubOU2,OU=SubOU1,DC=SubDomain1,DC=SubDomain2,DC=SubDomain3,DC=com"
$extensionAttribute1 = "Attrib1"
$extensionAttribute2 = "Attrib2"
$extensionAttribute4 = "US"
$WebPage = "www.google.com"
$HomeDrive = "U:"


<#
This loop checks to see if the users EUN (Enterprise User Name) is over 15 characters.
Then sets the Logon Name to either the EUN or the first 15 Characters of the EUN.
02 Feb 2016 - Changed length from 15 - 20
#>

If ($EmployeeID.Length -gt 20) {
$PreLogon= $EmployeeID.substring(0,19)}
else 
{$PreLogon = $EmployeeID} 

If ($PreLogon.EndsWith(".")) {
$PreLogon = $EmployeeID.Substring(0,18)}

<#
These variable are contigent on User input and the static variables
#>

$UserPrincipalName = $EmployeeID + "@states.org"
#$PrefName = $FName+"."+$MidInit+"."+$Lname+"."+$EmployeeType
$Telephone = "(501) 222-"+$IPphone
$Email = $EmployeeID+"@mail.org"
#$PreLogon = $FName+"."+$Lname+"."+$EmployeeType
$DisplayName = $LName+","+" "+$FName+" "+$MidInit+" "+$personalTitle+" "+$EmployeeType+" "+$extensionAttribute1+" "+$extensionAttribute2
#$PreLogon = $EmployeeID

#26 Jan 2016 changed $Homedirectory from "\\FileServer01\users\"+$EmployeeID
#12 Oct 2016 changed $Homedirectory from ""\\FileServer01.subDomain1.com\Profiles\$EmployeeID\HomeDrive"
$HomeDirectory = "\\FileServer01.subDomain1.com\Profiles\$PreLogon\HomeDrive" 

<#
Here are the default security groups every user is a part of.
#>

$VPNuser = "CN=VPN Users,OU=GROUPS,OU=SubOU3,OU=SubOU2,OU=SubOU1,DC=SubDomain1,DC=SubDomain2,DC=SubDomain3,DC=com"
$DomainUsers= "CN=Company Domain Users,OU=Global Groups,OU=GROUPS,OU=SubOU3,OU=SubOU2,OU=SubOU1,DC=SubDomain1,DC=SubDomain2,DC=SubDomain3,DC=com"
#$DistroA = "CN=Company Distribution A (All Company Employees),OU=Organizational Distribution Lists,OU=GROUPS,OU=SubOU3,OU=SubOU2,OU=SubOU1,DC=SubDomain1,DC=SubDomain2,DC=SubDomain3,DC=com"
#$Sharpoint = "CN=Company Sharepoint Users,OU=Global Groups,OU=GROUPS,OU=SubOU3,OU=SubOU2,OU=SubOU1,DC=SubDomain1,DC=SubDomain2,DC=SubDomain3,DC=com"

<#
I create the user and populate all the required fields for Company
    26Jan2016- changed samAccountName from $PreLogon to $EmployeeID
#>
New-ADUser -sAMAccountName $PreLogon -Name $DisplayName -path $Path -Company $Company -Department $Department -DisplayName $DisplayName -EmailAddress $Email -EmployeeNumber $EmployeeID -HomeDirectory $HomeDirectory -HomeDrive $HomeDrive -Office $Office -OfficePhone $Telephone -Surname $Lname -GivenName $Fname -UserPrincipalName $UserPrincipalName -OtherAttributes @{'wWWHomePage'=$WebPage; 'employeeType'="$EmployeeType";'ipPhone'="$IPphone"; 'personalTitle'="$personalTitle"; 'title'="$JobTitle"; 'extensionAttribute1'="$extensionAttribute1";'extensionAttribute2'="$extensionAttribute2";'extensionAttribute4'="$extensionAttribute4"}


<#
Here is where I add the security groups to the Users account.
#>
$UserMember = Get-ADUser -Filter {surname -like $Lname} -SearchBase "OU=SubOU3,OU=SubOU2,OU=SubOU1,DC=SubDomain1,DC=SubDomain2,DC=SubDomain3,DC=com" 

Add-ADGroupMember -Identity $DomainUsers -Members $UserMember.DistinguishedName
Add-ADGroupMember -Identity $VPNuser -Members $UserMember.DistinguishedName
#Add-ADGroupMember -Identity $DistroA -Members $UserMember.DistinguishedName
Add-ADGroupMember -Identity $ArSharpoint -Members $UserMember.DistinguishedName



 #$PreLogon
