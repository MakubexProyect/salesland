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
#Cuenta
$user = "Administrador"
$pass = "Sonda.05"
schtasks /create /TN "TOI\TOI-Inventario" /RU $user /RP $pass /XML C:\sonda\toi\toi_programer\TOI_Inventario.xml /F
schtasks /create /TN "TOI\TOI-PP" /RU $user /RP $pass /XML C:\sonda\toi\toi_programer\TOI_Inventario.xml /F
schtasks /create /TN "TOI\TOI-Wallpeaper" /RU $user /RP $pass /XML C:\sonda\toi\toi_programer\TOI_Inventario.xml /F
schtasks /create /TN “TOI\TOI-Update_Task” /RU "SYSTEM" /XML C:\sonda\toi\toi_programer\TOI-Update_Task.xml /F
schtasks /create /TN “TOI\TOI-User” /RU "SYSTEM" /XML C:\sonda\toi\toi_programer\TOI-User.xml /F
robocopy "C:\sonda\toi\fondo\" "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp" *.lnk

#Cambiar la tarea para que se ejecute con Usuarios GRUPO
C:\Windows\System32\taskschd.msc /s
C:\sonda\toi\Install\Setup.exe