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

#Tareas que se ejecutaran
#powershell -WindowStyle Hidden -file "C:\sonda\toi\Install\Install_TOI.ps1"
C:\sonda\toi\fondo\Bginfo.exe C:\sonda\toi\fondo\sonda.bgi /timer:00 /ACCEPTEULA





#COpia de StartUP
robocopy "C:\sonda\toi\Install\alt\" 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp' inventario.bat /MIR
robocopy "C:\sonda\toi\fondo\" 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp' *.lnk
#powershell -WindowStyle Hidden -file "C:\sonda\toi\toi_task\inventario_v2.ps1"