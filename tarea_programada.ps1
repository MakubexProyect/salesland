$A=New-ScheduledTaskAction -Execute ‘%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe’ -Argument ‘Backup-GPO -All -Path Z:\GPOS_AD’
$T=New-ScheduledTaskTrigger -AtStartup
$U=New-ScheduledTaskPrincipal -UserId “$($env:USERDOMAIN)\$($env:USERNAME)” -LogonType ServiceAccount
$S=New-Scheduledtasksettingsset
$D=Set-ScheduledTask -Action $A -Principal $U -Trigger $T -Settings $S
Register-ScheduledTask SALESLAND -InputObject $D