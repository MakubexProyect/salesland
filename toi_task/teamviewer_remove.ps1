$team = "C:\Program Files (x86)\TeamViewer\"
TASKKILL /IM TeamViewer.exe /F
TASKKILL /IM TeamViewer_Service.exe /F
net stop TeamViewer 
cd $team
.\uninstall.exe /S
Remove-Item -path $env:userprofile\AppData\Roaming\TeamViewer\* -force -recurse
Remove-Item HKCU:\Software\Teamviewer -recurse
Remove-Item HKLM:\Software\Teamviewer -recurse
Remove-Item -path $env:userprofile\AppData\Local\Temp\TeamViewer\* -force -recurse
Remove-Item -path $team
Remove-Item -path $env:userprofile\AppData\Roaming\TeamViewer -force -recurse