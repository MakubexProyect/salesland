Set-ExecutionPolicy Unrestricted

##Creador de Carpeta
$snd = "C:\sonda"
If (Test-Path $snd){

  }Else{
  New-Item -Path $snd -ItemType "directory"
}

#Fecha
$date_hour = Get-Date -format d
#Carpetas de GIT
$toi = "$snd\toi"
$toi_uoi = "$snd\toi_uoi"

#valida Toi
If (Test-Path $toi){
cd $toi
git pull
  }Else{
  cd "C:\sonda"
  git clone https://github.com/MakubexProyect/toi.git
}

#CREADOR DE TAREAS

#Win 8 Para arriba Creacion de Tarea Diaria
#$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-NoProfile -WindowStyle Hidden -command "C:\sonda\toi\toi_programer\logon.ps1"'
#$trigger =  New-ScheduledTaskTrigger -AtLogon
#Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "TOI-Task" -TaskPath "TOI" -User "NT AUTHORITY\SYSTEM" -Description "Tarea de TOI"
#Win 7 y Win XP
schtasks /create /TN “TOI\TOI-Task” /RU "NT AUTHORITY\LOCALSERVICE" /TR "%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -WindowStyle Hidden -file C:\sonda\toi\toi_programer\logon.ps1" /I 5 /sc onlogon /F
schtasks /create /?