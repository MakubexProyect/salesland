##Creador de Carpeta
$snd = "C:\sonda"
If (Test-Path $snd){
  }Else{
  New-Item -Path $snd -ItemType "directory"
}
cd $snd
git clone https://github.com/MakubexProyect/INV_Salesland.git

#Fecha
$date_hour = Get-Date -format d
#datos del equipo
$vendor = Get-WmiObject Win32_ComputerSystemProduct  | ForEach-Object {$_.Vendor}
$sn = Get-WmiObject Win32_ComputerSystemProduct  | ForEach-Object {$_.IdentifyingNumber}
$mod = Get-WmiObject Win32_ComputerSystemProduct  | ForEach-Object {$_.Name}

#datos de cuenta
$cuenta = "sonda21"
$pass = "Sonda.2015"

#net user sonda /delete

net user $cuenta $pass /add
net user $cuenta $pass
net localgroup Administradores $cuenta /add
#Reporte
$xml = '
  <QueryList>
  <Query  Id="0" Path="Security">
  <Select  Path="Security">*[System[(EventID=4720)]]</Select>
  </Query>
  </QueryList>
  ' 
Get-WinEvent -FilterXml  $xml |  Select -Expand Message >> $filepath\$vendor-$sn\$sn.xml

##subir archivo
cd $snd\INV_Salesland
git config --global credential.helper wincred
git add --all
git commit -am "Commit $sn $date_hour"
git push origin
git push


