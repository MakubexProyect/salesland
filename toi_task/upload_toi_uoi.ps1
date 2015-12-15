$vendor = Get-WmiObject Win32_ComputerSystemProduct  | ForEach-Object {$_.Vendor}
$sn = Get-WmiObject Win32_ComputerSystemProduct  | ForEach-Object {$_.IdentifyingNumber}
$date_hour = Get-Date -format d

##subir archivo
cd "C:\sonda\toi_uoi\$vendor-$sn"
git pull
git config --global user.email "celso.diaz@sonda.com"
git config --global credential.helper wincred
git add --all
git commit -am "Commit $sn $date_hour"
git push