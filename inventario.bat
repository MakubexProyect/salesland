cd "C:\sonda"
git clone https://github.com/MakubexProyect/INV_Salesland.git
ping -n 2 0.0.0.0 > nul
powershell %~dp0Hardware_Inventory.ps1
%~dp0git_push.bat



