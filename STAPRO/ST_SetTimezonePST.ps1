$action = New-ScheduledTaskAction -Execute 'tzutil.exe' '/s "Pacific Standard Time"'

$stateChangeTrigger = Get-CimClass `
    -Namespace ROOT\Microsoft\Windows\TaskScheduler `
    -ClassName MSFT_TaskSessionStateChangeTrigger

$onUnlockTrigger = New-CimInstance `
    -CimClass $stateChangeTrigger `
    -Property @{
        StateChange = 8  # TASK_SESSION_STATE_CHANGE_TYPE.TASK_SESSION_UNLOCK (taskschd.h)
    } `
    -ClientOnly

$onRCTrigger = New-CimInstance `
    -CimClass $stateChangeTrigger `
    -Property @{
        StateChange = 3  # TASK_SESSION_STATE_CHANGE_TYPE.TASK_REMOTE_CONNECT (taskschd.h)
    } `
    -ClientOnly

$trigger = @(
    $(New-ScheduledTaskTrigger -AtLogOn),
    $(New-ScheduledTaskTrigger -AtStartup),
    $onUnlockTrigger
    $onRCTrigger
)

Register-ScheduledTask SetTimeZonePST -Action $action -Trigger $trigger -User "NT AUTHORITY\SYSTEM"