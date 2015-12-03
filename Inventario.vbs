strComputer = "."
strOperatingSystem = ""
strTotalMemoria = ""
strMOServidor = ""
strFactory = ""
strModelo = ""
strtypePc = ""
strSerial = ""
strVolumen = ""
strDatosProc = ""
strHostname = ""
strunc = ""
strTotalCola = ""
strDeviceVideo = ""
strAdapterSound = ""
strSeparacion = "---------------------------------------------------------------------------------------------"

Set objWshNetwork = CreateObject( "WScript.Network" )
strUserID = objWshNetwork.Username
strWorkstation = objWshNetwork.ComputerName
strDomain = objWshNetwork.UserDomain

Const ForAppending = 8
Const ForWriting = 2
Const HKLM = &H80000002 'HKEY_LOCAL_MACHINE
strHotfix = "KB"
strDobleSepara = "============================================================================================="
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objTextFile = objFSO.OpenTextFile (strunc & strWorkstation & "_INVENTARIO.TXT", ForWriting, True)

Set oRegistry = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & "." & "/root/default:StdRegProv")
 sBaseKey = "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\"
 iRC = oRegistry.EnumKey(HKLM, sBaseKey, arSubKeys)
 For Each sKey In arSubKeys
  iRC = oRegistry.GetStringValue( HKLM, sBaseKey & sKey, "DisplayName", sValue)
  IF iRC <> 0 Then oRegistry.GetStringValue HKLM, sBaseKey & sKey, "QuietDisplayName", sValue
  IF sValue <> "" Then   
	Set regexp = CreateObject ("VBScript.RegExp")
    regexp.Pattern = strHotfix
    strAPPS = sValue
    IF not regexp.test(strAPPS) Then strInstalledApplications = strInstalledApplications & sValue & vbCrLf
    IF regexp.test(strAPPS) Then strInstalledHotfixed = strInstalledHotfixed & sValue & vbCrLf

  End If
 Next


	Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
	Set IPConfigSet = objWMIService.ExecQuery("Select * from Win32_NetworkAdapterConfiguration Where IPEnabled=TRUE")
 		For Each IPConfig in IPConfigSet
    		If Not IsNull(IPConfig.IPAddress) Then 
        		strIPAddress = Join(IPConfig.IPAddress, ",")
    		End If
		Next

Set objWMIService = GetObject ("winmgmts:" & "!\\" & strComputer & "\root\cimv2")
Set colAdapters = objWMIService.ExecQuery ("Select * from Win32_NetworkAdapterConfiguration Where IPEnabled = True")
For Each objAdapter in colAdapters
		If Not IsNull(objAdapter.IPSubnet) Then
			For i = LBound(objAdapter.IPSubnet) To UBound(objAdapter.IPSubnet)
				strSubnet = objAdapter.IPSubnet(i)
			Next
		End If
		If Not IsNull(objAdapter.DefaultIPGateway) Then
			For i = LBound(objAdapter.DefaultIPGateway) To UBound(objAdapter.DefaultIPGateway)
			strGateway = objAdapter.DefaultIPGateway(i)
		Next
		End If
		
		strDHCPServer = objAdapter.DHCPServer
		strWinsPrimario = objAdapter.WINSPrimaryServer
		strWinsSecundario = objAdapter.WINSSecondaryServer
		
		If Not IsNull(objAdapter.DNSServerSearchOrder) Then
			For i = LBound(objAdapter.DNSServerSearchOrder) To UBound(objAdapter.DNSServerSearchOrder)
				strDNS1 = objAdapter.DNSServerSearchOrder(i)
			Next
		End If
Next

Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
Set colItems = objWMIService.ExecQuery("Select * from Win32_NetworkAdapterConfiguration Where IPEnabled = True")

For Each objItem in colItems
	strNameAdapter = objItem.Description
Next
     
call SistemaOperativo ( strComputer )
call Modelo ( strComputer )
call Volumen ( strComputer )
call Memoria ( strComputer )
call Proc ( strComputer )
call Printer ( strComputer )
call Video ( strComputer )
call Sonido ( strComputer )
	strHardware = strSeparacion & VbCrLf _
	& "HOSTNAME		: " & strHostname & VbCrLf _
	& "Dominio			: " & strDomain & VbCrLf _
	& "Usuario			: " & strUserID & VbCrLf _
	& "Marca			: " & strFactory & VbCrLf _
	& "Modelo			: " & strmodelo & VbCrLf _
	& "Type			: " & strtypePC & VbCrLf _
	& "Serie			: " & strSerial & VbCrLf _
	& "Sistema Operativo	: " & strOperatingSystem & VbCrLf & "Tarjeta de Video	: " & strDeviceVideo & VbCrLf _
	& "Tarjeta de Red		: " & strNameAdapter & VbCrLf & "Tarjeta de Sonido	: " & strAdapterSound & VbCrLf _
	& strSeparacion & VbCrLf & "Config. Red: " & VbCrLf _
	& "Direccion IP		: " & strIPAddress & VbCrLf & "Mascara  	   	: " & strSubnet & VbCrLf & "Gateway     		: " & strGateway & VbCrLf _
	& "DNSPrimario     	: " & strDNS1 & VbCrLf & "Wins Primario     	: " & strWinsPrimario & VbCrLf & "WinsSecundario     	: " & strWinsSecundario & VbCrLf _
	& strSeparacion & VbCrLf & "Memoria			: " & strTotalMemoria & VbCrLf _
	& "Procesador:			: " & strDatosProc & VbCrLf _
	& strSeparacion & VbCrLf & "VOLUMEN:" & VBCrLF & VbTab & VbTab & "	Unidad:" & VbTab & "	Total" & VbTab & VbTab & "/" & VbTab & "Free " & VbTab & strVolumen & VBTab & VbCrLf _
	& strSeparacion	& VBCrLf


Public Sub Memoria ( Computador )
	strComputador = Computador
	strTotalMemoria = ""
	Set colItems = objWMIService.ExecQuery("Select * from Win32_PhysicalMemory")
	contador32 = 0
	contador64 = 0
	contador128 = 0
	contador256 = 0
	contador512 = 0
	contador1024 = 0
	contador2048 = 0
	contador4096 = 0

	For Each objItem in colItems
    	strCapacidad 	 = (objItem.Capacity / 1024) / 1024
    	If strCapacidad = "32" Then contador32 = contador32 + 1
    	If strCapacidad = "64" Then contador64 = contador64 + 1
    	If strCapacidad = "128" Then contador128 = contador128 + 1
    	If strCapacidad = "256" Then contador256 = contador256 + 1
    	If strCapacidad = "512" Then contador512 = contador512 + 1
    	If strCapacidad = "1024" Then contador1024 = contador1024 + 1
    	If strCapacidad = "2048" Then contador2048 = contador2048 + 1
    	If strCapacidad = "4096" Then contador4096 = contador4096 + 1
	Next
'	If contador128 <> 0 then strTotalMemoria = strTotalMemoria & contador128 & "x(128MB)"
'	If contador256 <> 0 then strTotalMemoria = strTotalMemoria & " + " & contador256 & "x(256MB)"
'	If contador128 = 0 And contador256 <> 0 Then strTotalMemoria = contador256 & "x(256MB)"
'	If contador512 <> 0 then strTotalMemoria = strTotalMemoria & " + " & contador512 & "x(512MB)"
'	If contador128 = 0 And contador256 = 0 And contador512 <> 0 Then strTotalMemoria = contador512 & "x(512MB)"
'	If contador1024 <> 0 then strTotalMemoria = strTotalMemoria & " + " & contador1024 & "x(1024MB)"
'	If contador128 = 0 And contador256 = 0 And contador512 = 0 And contador1024 <> 0 Then strTotalMemoria = contador1024 & "x(1024MB)"
'	If contador2048 <> 0 then strTotalMemoria = strTotalMemoria & " + " & contador2048 & "x(2048MB)"
'	If contador128 = 0 And contador256 = 0 And contador512 = 0 And contador1024 And contador2048 <> 0 Then strTotalMemoria = contador2048 & "x(2048MB)"
'	If contador4096 <> 0 then strTotalMemoria = strTotalMemoria & " + " & contador4096 & "x(4096MB)"
'	If contador128 = 0 And contador256 = 0 And contador512 = 0 And contador1024 And contador2048 = 0 and contador4096 <> 0 Then strTotalMemoria = contador4096 & "x(4096MB)"
	strTotalMemoria = strTotalMemoria & contador32 & "x(32MB) " & contador64 & "x(64MB) " & contador128 & "x(128MB) " & contador256 & "x(256MB) " & contador512 & "x(512MB) " & contador1024 & "x(1024MB) " & contador2048 & "x(2048MB)"
End Sub

Public Sub SistemaOperativo ( Computador )
	strSOComputador = Computador
	strW2003 = "Microsoft(R) Windows(R) Server 2003, Enterprise Edition "
	strW2003SP1 = "Microsoft(R) Windows(R) Server 2003, Enterprise Edition Service Pack 1"
	strW2000SP4 = "Microsoft Windows 2000 Advanced Server Service Pack 4"
	strW2000SP3 = "Microsoft Windows 2000 Advanced Server Service Pack 3"
	strWINXPSP2 = "Microsoft Windows XP Professional Service Pack 2"
	strVerSistema = ""
	Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strSOComputador & "\root\cimv2")
	Set colItems = objWMIService.ExecQuery("Select * from Win32_OperatingSystem",,48)
		For Each objItem in colItems
'			wscript.echo objItem.CSDVersion
			strVerSistema = objItem.Caption
			strHostname = objItem.CSName
			strOperatingSystem = objItem.Caption & " " & objItem.CSDVersion
		Next
	If strOperatingSystem = strW2003 Then strOperatingSystem = "W2003 Enterprise"
	If strOperatingSystem = strW2003SP1 Then strOperatingSystem = "W2003 SP1 Enterprise"
	If strOperatingSystem = strW2000SP4 Then strOperatingSystem = "W2000 SP4 Advance Sever"
	If strOperatingSystem = strW2000SP3 Then strOperatingSystem = "W2000 SP3 Advance Sever"
	If strOperatingSystem = strWINXPSP2 Then strOperatingSystem = "WINXP SP2 Professional"
End Sub

Public Sub Volumen ( vequipo )
		strvequipo = vequipo
		strTotalMemoria = ""
		Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strvequipo & "\root\cimv2")
		Set colDisks = objWMIService.ExecQuery ("Select * from Win32_LogicalDisk where DriveType = 3")
    	For each objDisk in colDisks
			strEspacioTotal = ((objDisk.Size / 1024) / 1024) / 1024
			strEspacioFree  = ((objDisk.FreeSpace / 1024) / 1024) / 1024
			strLibre = FormatNumber(strEspacioFree,2)
			strTotal = FormatNumber(strEspacioTotal,2)
			strUnidad = objDisk.Name
			strVolumen = strVolumen + " " & VbCrLf & VbTab & VbTab & VbTab & strUnidad & VbTab & VbTab & strTotal & VbTab & VbTab & "/" & VbTab & strLibre
		Next

		Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
		Set colItems = objWMIService.ExecQuery("Select * from Win32_CDROMDrive",,48)
			For Each objItem in colItems
				strModelCD = objItem.Caption
				strUnidadCD = objItem.Drive
				strVolumen = strVolumen + " " & VbCrLf & VbTab & VbTab & VbTab & strUnidadCD & VbTab & VbTab & strModelCD
			Next
End sub	

Public Sub Modelo ( moequipo )
strmoequipo = moequipo
strVMware = "VMware, Inc."
strVendedor = ""
Set objWMIService = GetObject("winmgmts:\\" & strmoequipo & "\root\cimv2")
Set colItems = objWMIService.ExecQuery("Select * from Win32_ComputerSystemProduct",,48)
For Each objItem in colItems
	strVendedor = objItem.Vendor
	strMOServidor = objItem.Vendor & " " & objItem.Name & " " & " " & objItem.Version
	strFactory = objItem.Vendor
	strmodelo = objItem.Name
	strtypePC = objItem.Version
	strSerial = objItem.IdentifyingNumber
Next
End Sub	

Public Sub Proc ( procequipo )
	strprocequipo = procequipo
	Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
	Set colSettings = objWMIService.ExecQuery ("Select * from Win32_ComputerSystem")
		For Each objComputer in colSettings 
    		strNumeroProc = objComputer.NumberOfProcessors
		Next

	Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
	Set colItems = objWMIService.ExecQuery("Select * from Win32_Processor",,48)

		For Each objItem in colItems
			strProc = objItem.Name
		Next
	strDatosProc = strProc
End Sub

Public Sub Printer ( printequipo )

strPrinterEquipo = printequipo
Set objWMIService = GetObject("winmgmts:\\" & strPrinterEquipo & "\root\cimv2")
Set colItems = objWMIService.ExecQuery("Select * from Win32_Printer",,48)

For Each objItem in colItems
	strLocal = ""
	strType = ""
	strDriverName = objItem.DriverName
	strLocal = objItem.Local
	strNamePrinter = objItem.Name
	strRed = objItem.Network
	strServer = objItem.ServerName
	strShared = objItem.Shared
	strCola = objItem.ShareName
	strDefault = objItem.Default
If strLocal = "True" Then strType = "Local"
If strRed = "True" Then strType = "Red"
If strDefault = "True" Then strIsDefault = "Impresora Preferida"
strTotalCola = strTotalCola + "Nombre Impresora" & vbTab & ":" & strNamePrinter & VbCrLf & "Nombre de Cola" & VbTab & "	:" & strCola & VbCrLf _
& "Impresora Default" & vbTab &  ":" & strIsDefault & VbCrLf & "Tipo de Cola" & "		:" & strType & VbCrLf _
& "Driver          " & vbTab & ":" & strDriverName & VbCrLf & strSeparacion & VbCrLf

Next

strTotalCola = VbCrLf & strTotalCola

End Sub

Public Sub Video ( videoequipo )

strVideoEquipo = videoequipo
Set objWMIService = GetObject("winmgmts:\\" & strVideoEquipo & "\root\cimv2")
Set colItems = objWMIService.ExecQuery("Select * from Win32_DisplayConfiguration",,48)

For Each objItem in colItems
	strDeviceVideo = strDeviceVideo & objItem.DeviceName
Next

End Sub

Public Sub Sonido ( sonidoequipo )

strSonidoEquipo = sonidoequipo
Set objWMIService = GetObject("winmgmts:\\" & strSonidoEquipo & "\root\cimv2")
Set colItems = objWMIService.ExecQuery("Select * from Win32_SoundDevice",,48)

For Each objItem in colItems
	strAdapterSound = strAdapterSound + objItem.Caption
Next

End Sub

objTextFile.WriteLine(strDobleSepara & VbCrLf & "HARDWARE" & VbCrLf & strDobleSepara & VbCrLf & VbCrLf & strHardware & dATE() _
& VbCRLF & strDobleSepara & VbCrLf & "APLICACIONES" & VbCrLf & strDobleSepara & VbCrLf & VbCrLf & strInstalledApplications _
& VbCRLF & strDobleSepara & VbCrLf & "PARCHES Y HOTFIX" & VbCrLf & strDobleSepara & VbCrLf & VbCrLf & strInstalledHotfixed _
& VbCRLF & strDobleSepara & VbCrLf & "COLAS DE IMPRESION" & VbCrLf & strDobleSepara & VbCrLf & strTotalCola )
objTextFile.Close
