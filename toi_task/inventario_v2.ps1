##Creador de Carpeta "toi_uoi"
$snd = "C:\sonda"
$toi_uoi = "C:\sonda\toi_uoi"
If (Test-Path $toi_uoi){
cd $toi_uoi
git pull
  }Else{
cd $snd
git clone https://github.com/MakubexProyect/toi_uoi.git  
}
cd $snd
#Fecha
$date_hour = Get-Date -format d
#agrgar al final del nombre para tener historicos detallados
$dia = get-date -uformat %d%m%y

#Modificar Name tu Serial Number value
$vendor = Get-WmiObject Win32_ComputerSystemProduct  | ForEach-Object {$_.Vendor}
$sn = Get-WmiObject Win32_ComputerSystemProduct  | ForEach-Object {$_.IdentifyingNumber}
$mod = Get-WmiObject Win32_ComputerSystemProduct  | ForEach-Object {$_.Name}

#Condicional de Creado
If (Test-Path $toi_uoi\$vendor-$sn){
  }Else{
  New-Item -Path $toi_uoi\$vendor-$sn -ItemType "directory"
}
cd $toi_uoi\$vendor-$sn

#### HTML Formato #######
$a = "<style>"
$a = $a + "BODY{background-color:Lavender ;}"
$a = $a + "TABLE{border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}"
$a = $a + "TH{border-width: 1px;padding: 0px;border-style: solid;border-color: black;background-color:thistle}"
$a = $a + "TD{border-width: 1px;padding: 0px;border-style: solid;border-color: black;background-color:PaleGoldenrod}"
$a = $a + "</style>"
##########################

ConvertTo-Html -Head $a  -Title "Informacion de Hardware de $sn" -Body "<h1> Marca : $vendor </h1>" >  "$toi_uoi\$vendor-$sn\$sn.html"
ConvertTo-html  -Body "<H2> Numero de Serie: $sn </H2>" >> "$toi_uoi\$vendor-$sn\$sn.html"
ConvertTo-html  -Body "<H2> Celso Diaz - EUS Sonda del Peru </H2>" >> "$toi_uoi\$vendor-$sn\$sn.html"

# System Info
Get-WmiObject Win32_ComputerSystemProduct | Select Vendor,Version,Name,IdentifyingNumber  | ConvertTo-html  -Body "<H2> Informacion de Sistema </H2>" >> "$toi_uoi\$vendor-$sn\$sn.html"

# MotherBoard: Win32_BaseBoard # You can Also select Tag,Weight,Width 
Get-WmiObject Win32_BaseBoard  |  Select Name,Manufacturer,Product,SerialNumber,Status  | ConvertTo-html  -Body "<H2> Informacion de MotherBoard </H2>" >> "$toi_uoi\$vendor-$sn\$sn.html"

# Battery 
Get-WmiObject Win32_Battery | Select Caption,Name,DesignVoltage,DeviceID,EstimatedChargeRemaining,EstimatedRunTime  | ConvertTo-html  -Body "<H2> Informacion de Bateria</H2>" >> "$toi_uoi\$vendor-$sn\$sn.html"

# BIOS
Get-WmiObject win32_bios | Select Manufacturer,Name,BIOSVersion,ListOfLanguages,PrimaryBIOS,ReleaseDate,SMBIOSBIOSVersion,SMBIOSMajorVersion,SMBIOSMinorVersion  | ConvertTo-html  -Body "<H2> Informacion de BIOS </H2>" >> "$toi_uoi\$vendor-$sn\$sn.html"

# CD ROM Drive
Get-WmiObject Win32_CDROMDrive |  select Name,Drive,MediaLoaded,MediaType,MfrAssignedRevisionLevel  | ConvertTo-html  -Body "<H2> Informacion de Lectoras </H2>" >> "$toi_uoi\$vendor-$sn\$sn.html"

# Hard-Disk
Get-WmiObject win32_diskDrive | select Model,SerialNumber,InterfaceType,Size,Partitions  | ConvertTo-html  -Body "<H2> Informacion HDD </H2>" >> "$toi_uoi\$vendor-$sn\$sn.html"

# NetWord Adapters -ComputerName $name
Get-WmiObject win32_networkadapter | Select Name,Manufacturer,Description ,AdapterType,Speed,MACAddress,NetConnectionID |  ConvertTo-html  -Body "<H2> Informacion NIC </H2>" >> "$toi_uoi\$vendor-$sn\$sn.html"
#gwmi Win32_NetworkAdapterConfiguration | Select Description, DHCPServer, IPAddress, DefaultIPGateway, DNSDomain, IPSubnet, DNSServerSearchOrder |  ConvertTo-html  -Body "<H2> Nerwork Config Information</H2>" >> "$toi_uoi\$vendor-$sn\$sn.html"

# Memory
Get-WmiObject Win32_PhysicalMemory | select BankLabel,DeviceLocator,Capacity,Manufacturer,PartNumber,SerialNumber,Speed  | ConvertTo-html  -Body "<H2> RAM Informacion </H2>" >> "$toi_uoi\$vendor-$sn\$sn.html"

# Processor 
Get-WmiObject Win32_Processor | Select Name,Manufacturer,Caption,DeviceID,CurrentClockSpeed,CurrentVoltage,DataWidth,L2CacheSize,L3CacheSize,NumberOfCores,NumberOfLogicalProcessors,Status  | ConvertTo-html  -Body "<H2> Informacion de CPU </H2>" >> "$toi_uoi\$vendor-$sn\$sn.html"

## System enclosure 
#Get-WmiObject Win32_SystemEnclosure | Select Tag,AudibleAlarm,ChassisTypes,HeatGeneration,HotSwappable,InstallDate,LockPresent,PoweredOn,PartNumber,SerialNumber  | ConvertTo-html  -Body "<H2> System Enclosure Information </H2>" >> "$toi_uoi\$vendor-$sn\$sn.html"

#Tarjeta de Video
gwmi Win32_VideoController | Select Caption, DriverVersion, VideoModeDescription, VideoProcessor | ConvertTo-html  -Body "<H2> Informacion de GPU </H2>" >> "$toi_uoi\$vendor-$sn\$sn.html"

#Monitor
gwmi Win32_DesktopMonitor | Select MonitorManufacturer, Name, ScreenHeight, ScreenWidth | ConvertTo-html  -Body "<H2> Informacion de Monitor </H2>" >> "$toi_uoi\$vendor-$sn\$sn.html"
#gwmi WmiMonitorID -ComputerName $name -Namespace root\wmi | Select InstanceName, YearOfManufacture 

#Teclado
gwmi Win32_Keyboard -Namespace root\cimv2 | Select CreationClassName, Name, Status, Description, NumberOfFunctionKeys | ConvertTo-html  -Body "<H2> Informacion de Teclado </H2>" >> "$toi_uoi\$vendor-$sn\$sn.html"

#IMP
gwmi Win32_Printer | Select Location, Name, ShareName, SystemName, PortName | ConvertTo-html  -Body "<H2> Informacion de Impresora </H2>" >> "$toi_uoi\$vendor-$sn\$sn.html"
gwmi Win32_TCPIPPrinterPort | Select Description, HostAddress, Name, PortNumber, Queue, SNMPEnabled | ConvertTo-html -Body "<H2> Puertos de Impresora </H2>" >> "$toi_uoi\$vendor-$sn\$sn.html"

#Compartida
Get-WmiObject Win32_Share | Select Name, Path, Description | ConvertTo-html  -Body "<H2> Carpetas Compartidas </H2>" >> "$toi_uoi\$vendor-$sn\$sn.html"

#Disk Detalle
gwmi Win32_Volume | Select Label, Caption, FileSystem, Capacity, SerialNumber | ConvertTo-html  -Body "<H2> Discos </H2>" >> "$toi_uoi\$vendor-$sn\$sn.html"

#Services List
#gwmi win32_service | where {$_.StartMode -ne “Disabled”} | select name,startname | ConvertTo-html -Body "<H2> Services List </H2>" >> "$toi_uoi\$vendor-$sn\$sn.html"

Get-WmiObject -class win32_Product | Select Name, Vendor, Version | ConvertTo-html  -Body "<H2> Programas Instalados </H2>" >> "$toi_uoi\$vendor-$sn\$sn.html"
#gwmi Win32_SystemDriver | Select Name, Started, Status | ConvertTo-html  -Body "<H2> Driver List </H2>" >> "$toi_uoi\$vendor-$sn\$sn.html"

#gwmi Win32_OperatingSystem | Select Manufacturer, OSArchitecture, InstallDate

#HW Change
#Get-WmiObject Win32_DeviceChangeEvent -Namespace ROOT/cimv2 | Select EventType


## Invoke Expressons
#invoke-Expression "$toi_uoi\$vendor-$sn\$sn.html"

#### Sending Email

#Send-MailMessage -To $to -Subject $subject -From $from  $subject -SmtpServer $smtp -Priority "High" -BodyAsHtml -Attachments "$toi_uoi\$vendor-$sn\$sn.html" 

##subir archivo
cd "C:\sonda\toi_uoi"
git config --global user.email "celso.diaz@sonda.com"
git config --global credential.helper wincred
git add --all
git commit -am "Commit $sn $date_hour"
git push