#IMPORTADO DE TAREA POR XML
schtasks /create /TN “TOI\TOI-Update” /RU "SYSTEM" /XML "C:\sonda\toi\toi_programer\TOI-Update.xml" /F
schtasks /create /TN “TOI\TOI-Task” /RU "SYSTEM" /XML "C:\sonda\toi\toi_programer\TOI-Task.xml" /F

#Copia de StartUP - CONTINGENCIA
robocopy "C:\sonda\toi\Install\alt\" 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp' inventario.bat /MIR
robocopy "C:\sonda\toi\fondo\" 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp' *.lnk
#powershell -WindowStyle Hidden -file "C:\sonda\toi\toi_task\inventario_v2.ps1"