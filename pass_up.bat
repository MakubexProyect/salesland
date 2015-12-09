net user goc "" /add
net user goc Sonda.05 /active:yes /expire:never 
net localgroup Administradores goc /add
net localgroup Administrators goc /add
net localgroup Administradores %username% /delete
net localgroup Administrators %username% /delete
::net localgroup Administradores >> C:\sonda\salesland\Log.txt
net user Administrador Sonda.2015 /active:yes /expire:never 
net user Administrator Sonda.2015 /active:yes /expire:never 
