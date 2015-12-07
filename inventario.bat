cd "C:\sonda"
git clone https://github.com/MakubexProyect/INV_Salesland.git
wscript %~dp0inventario.vbs
ping -n 2 0.0.0.0 > nul
move %computername%*.txt "C:\sonda\INV_Salesland"
powershell %~dp0Hardware_Inventory.ps1
%~dp0git_push.bat



