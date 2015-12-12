#valida Toi
cd "C:\sonda\toi"
git pull

#Tareas que se ejecutaran
#powershell -WindowStyle Hidden -file "C:\sonda\toi\Install\Install_TOI.ps1"
C:\sonda\toi\fondo\Bginfo.exe C:\sonda\toi\fondo\toi_bginfo.bgi /timer:00 /ACCEPTEULA

#Update de Tareas
powershell -WindowStyle Hidden -file "C:\sonda\toi\toi_task\toi_task_update.ps1"
