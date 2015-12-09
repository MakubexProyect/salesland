###PUSH SUBIDA DE ARCHIVO
cd "C:\sonda\salesland"
git config --global credential.helper wincred
set BRANCH = "origin"
git add --all
git commit -am "Commit %computername% %date%"
git push origin


