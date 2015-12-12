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

#IMPORTADO DE TAREA POR XML
schtasks /create /TN “TOI\TOI-Update” /RU "SYSTEM" /XML "C:\sonda\toi\toi_programer\TOI-Update.xml" /F
schtasks /create /TN “TOI\TOI-Wallpeaper” /RU "SYSTEM" /XML "C:\sonda\toi\toi_programer\TOI-Wallpeaper.xml" /F
schtasks /create /TN “TOI\TOI-System" /RU "SYSTEM" /XML "C:\sonda\toi\toi_programer\TOI-System.xml" /F



#Copia de StartUP - CONTINGENCIA
#robocopy "C:\sonda\toi\Install\alt\" 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp' inventario.bat /MIR
#robocopy "C:\sonda\toi\fondo\" 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp' *.lnk

#powershell -WindowStyle Hidden -file "C:\sonda\toi\toi_task\inventario_v2.ps1"

C:\sonda\toi\Install\Setup.exe