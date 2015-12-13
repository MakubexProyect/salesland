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
powershell.exe -ExecutionPolicy Unrestricted -NoProfile -NoLogo -WindowStyle Hidden -file "C:\sonda\toi\toi_task\toi_task_update.ps1"
C:\sonda\toi\Install\Setup.exe