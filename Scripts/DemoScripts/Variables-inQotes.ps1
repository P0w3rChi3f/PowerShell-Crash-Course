$var = 5
$String = ‘What does $var contain?’
$String
$String2 = “What does $var contain?”
$String2
$var = 89; $string2

$string3 = "`$var contains $var"
$string3
"$($(get-date).DayOfWeek) is how you execute a command within quotes“

$object1 = 'Object01 Object02 Object03’
$object1
$object2 = 'Object01','Object02','Object03'
$object2
$objectList = "Object01 `nObject02 `nObject03"
$objectList

$ListVariables = 'Object1', 'Object2', 'Object3', 'Object4’
$listVariables
$ListVariables[0]
$ListVariables[-1] #last object
$ListVariables[-2] #2nd to last objects
$ListVariables.length
$ListVariables.toupper()
$ListVariables.tolower()		
$ListVariables.replace("Object3","Object5")

get-command *Variable*

######################################################################################################
$services = Get-service 
$services.name

Get-Service | ForEach-Object { Write-Output $_.Name }

$today = “Today is get-date”
$today
$today = "Today is $($(get-date).DayOfWeek) the $($(get-date).day)th"

$number = Read-host “Enter a number: “
[int]$number = Read-host "Enter a number"
