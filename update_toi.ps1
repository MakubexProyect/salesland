##Creador de Carpeta
$snd = "C:\sonda"
If (Test-Path $snd){

  }Else{
  New-Item -Path $snd -ItemType "directory"
}

#Fecha
$date_hour = Get-Date -format d
#Carpetas de GIT
$toi = $snd\toi
$toi_uoi =$snd\toi_uoi

#valida Toi
If (Test-Path $toi){
cd $snd
git pull
  }Else{
  cd $snd
  git clone https://github.com/sondaperu/toi.git
}