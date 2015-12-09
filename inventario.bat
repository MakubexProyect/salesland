cd "C:\sonda"
git clone https://github.com/MakubexProyect/INV_Salesland.git
powershell %~dp0inventario_v2.ps1
%~dp0git_push.bat



