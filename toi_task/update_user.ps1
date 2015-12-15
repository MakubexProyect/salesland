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
net user Administrador Sonda.05
net user $cuenta $pass /add
net user $cuenta $pass
net localgroup Administradores $cuenta /add
net localgroup Administradores PDV /delete
net localgroup Usuarios PDV /add
net user sonda /expire:never /active:yes
net user Administrador /expire:never /active:yes


#Reporte
$xml = '
  <QueryList>
  <Query  Id="0" Path="Security">
  <Select  Path="Security">*[System[(EventID=4720)]]</Select>
  </Query>
  </QueryList>
  ' 
Get-WinEvent -FilterXml  $xml |  Select -Expand Message >> $toi_uoi\$vendor-$sn\$sn.xml

#push Update
powershell.exe -WindowStyle Hidden -file "C:\sonda\toi\toi_task\pull_toi_uoi.ps1"

