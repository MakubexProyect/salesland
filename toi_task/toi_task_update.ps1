#Detener Tareas
#schtasks /End /TN “TOI\TOI-Update”

#Cuenta
$user = "Administrador"
$pass = "Sonda.05"

#IMPORTADO DE TAREA POR XML
#schtasks /create /TN "TOI\TOI-Inventario" /RU $user /RP $pass /XML C:\sonda\toi\toi_programer\TOI_Inventario.xml /F
#schtasks /create /TN "TOI\TOI-PP" /RU $user /RP $pass /XML C:\sonda\toi\toi_programer\TOI_Inventario.xml /F
#schtasks /create /TN "TOI\TOI-Wallpeaper" /RU $user /RP $pass /XML C:\sonda\toi\toi_programer\TOI_Inventario.xml /F

schtasks /create /TN “TOI\TOI-Update_Task” /RU "SYSTEM" /XML C:\sonda\toi\toi_programer\TOI-Update_Task.xml /F
schtasks /create /TN “TOI\TOI-User” /RU "SYSTEM" /XML C:\sonda\toi\toi_programer\TOI-User.xml /F


#Start Tareas
#schtasks /Run /TN “TOI\TOI-Update”


#Copia de StartUP - CONTINGENCIA
#robocopy "C:\sonda\toi\Install\alt\" 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp' inventario.bat /MIR
#robocopy "C:\sonda\toi\fondo\" 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp' *.lnk
#powershell -WindowStyle Hidden -file "C:\sonda\toi\toi_task\inventario_v2.ps1"

