#Fecha
$date_hour = Get-Date -format d
#datos del equipo
$vendor = Get-WmiObject Win32_ComputerSystemProduct  | ForEach-Object {$_.Vendor}
$sn = Get-WmiObject Win32_ComputerSystemProduct  | ForEach-Object {$_.IdentifyingNumber}
$mod = Get-WmiObject Win32_ComputerSystemProduct  | ForEach-Object {$_.Name}

#datos de cuenta
$cuenta = "sonda"
$pass = "Sonda.2015"

$snd = "C:\sonda"
$toi_uoi = "C:\sonda\toi_uoi"

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
Get-WinEvent -FilterXml  $xml |  Select -Expand Message >> $toi_uoi\$vendor-$sn\$sn.xml

##subir archivo
cd "C:\sonda\toi_uoi"
git config --global credential.helper wincred
git add --all
git commit -am "Commit $sn $date_hour"
git push origin
git push


