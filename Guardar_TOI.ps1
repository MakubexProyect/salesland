#Fecha
$date_hour = Get-Date -format d

#Carpetas de GIT
$toi = "$snd\toi"
cd $toi
git config --global credential.helper wincred
git add --all
git commit -am "celso.diaz@sonda.com $date_hour"
git push origin