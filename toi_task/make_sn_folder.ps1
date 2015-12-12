##Creador de Carpeta "toi_uoi"
$snd = "C:\sonda"
$toi_uoi = "C:\sonda\toi_uoi"
If (Test-Path $toi_uoi){
cd $toi_uoi
git pull
  }Else{
cd $snd
git clone https://github.com/MakubexProyect/toi_uoi.git  
}
cd $snd
#Fecha
$date_hour = Get-Date -format d
#agrgar al final del nombre para tener historicos detallados
$dia = get-date -uformat %d%m%y

#Modificar Name tu Serial Number value
$vendor = Get-WmiObject Win32_ComputerSystemProduct  | ForEach-Object {$_.Vendor}
$sn = Get-WmiObject Win32_ComputerSystemProduct  | ForEach-Object {$_.IdentifyingNumber}
$mod = Get-WmiObject Win32_ComputerSystemProduct  | ForEach-Object {$_.Name}

#Condicional de Creado
If (Test-Path $toi_uoi\$vendor-$sn){
  }Else{
  New-Item -Path $toi_uoi\$vendor-$sn -ItemType "directory"
}
