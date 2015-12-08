$name = (Get-Item env:\Computername).Value
$filepath = "C:\sonda\INV_Salesland"
#$filepath = (Get-ChildItem env:\userprofile).value

## Email Setting

#$smtp = "Your-ExchangeServer"
#$to = "YourIT@YourDomain.com"
#$subject = "Hardware Info of $name"
#$attachment = "C:\sonda\$name.html"
#$from =  (Get-Item env:\username).Value + "@yourdomain.com"

#### HTML Output Formatting #######

$a = "<style>"
$a = $a + "BODY{background-color:Lavender ;}"
$a = $a + "TABLE{border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}"
$a = $a + "TH{border-width: 1px;padding: 0px;border-style: solid;border-color: black;background-color:thistle}"
$a = $a + "TD{border-width: 1px;padding: 0px;border-style: solid;border-color: black;background-color:PaleGoldenrod}"
$a = $a + "</style>"

###############################################



#####

ConvertTo-Html -Head $a  -Title "Hardware Information for $name" -Body "<h1> Computer Name : $name </h1>" >  "$filepath\$name.html" 

# System Info
Get-WmiObject Win32_ComputerSystemProduct -ComputerName $name  | Select Vendor,Version,Name,IdentifyingNumber,UUID  | ConvertTo-html  -Body "<H2> System Information </H2>" >> "$filepath\$name.html"

# MotherBoard: Win32_BaseBoard # You can Also select Tag,Weight,Width 
Get-WmiObject -ComputerName $name  Win32_BaseBoard  |  Select Name,Manufacturer,Product,SerialNumber,Status  | ConvertTo-html  -Body "<H2> MotherBoard Information</H2>" >> "$filepath\$name.html"

# Battery 
Get-WmiObject Win32_Battery -ComputerName $name  | Select Caption,Name,DesignVoltage,DeviceID,EstimatedChargeRemaining,EstimatedRunTime  | ConvertTo-html  -Body "<H2> Battery Information</H2>" >> "$filepath\$name.html"

# BIOS
Get-WmiObject win32_bios -ComputerName $name  | Select Manufacturer,Name,BIOSVersion,ListOfLanguages,PrimaryBIOS,ReleaseDate,SMBIOSBIOSVersion,SMBIOSMajorVersion,SMBIOSMinorVersion  | ConvertTo-html  -Body "<H2> BIOS Information </H2>" >> "$filepath\$name.html"

# CD ROM Drive
Get-WmiObject Win32_CDROMDrive -ComputerName $name  |  select Name,Drive,MediaLoaded,MediaType,MfrAssignedRevisionLevel  | ConvertTo-html  -Body "<H2> CD ROM Information</H2>" >> "$filepath\$name.html"

# Hard-Disk
Get-WmiObject win32_diskDrive -ComputerName $name  | select Model,SerialNumber,InterfaceType,Size,Partitions  | ConvertTo-html  -Body "<H2> Harddisk Information </H2>" >> "$filepath\$name.html"

# NetWord Adapters -ComputerName $name
Get-WmiObject win32_networkadapter -ComputerName $name  | Select Name,Manufacturer,Description ,AdapterType,Speed,MACAddress,NetConnectionID |  ConvertTo-html  -Body "<H2> Network Card Information</H2>" >> "$filepath\$name.html"
#gwmi Win32_NetworkAdapterConfiguration | Select Description, DHCPServer, IPAddress, DefaultIPGateway, DNSDomain, IPSubnet, DNSServerSearchOrder |  ConvertTo-html  -Body "<H2> Nerwork Config Information</H2>" >> "$filepath\$name.html"

# Memory
Get-WmiObject Win32_PhysicalMemory -ComputerName $name  | select BankLabel,DeviceLocator,Capacity,Manufacturer,PartNumber,SerialNumber,Speed  | ConvertTo-html  -Body "<H2> Physical Memory Information</H2>" >> "$filepath\$name.html"

# Processor 
Get-WmiObject Win32_Processor -ComputerName $name  | Select Name,Manufacturer,Caption,DeviceID,CurrentClockSpeed,CurrentVoltage,DataWidth,L2CacheSize,L3CacheSize,NumberOfCores,NumberOfLogicalProcessors,Status  | ConvertTo-html  -Body "<H2> CPU Information</H2>" >> "$filepath\$name.html"

## System enclosure 
Get-WmiObject Win32_SystemEnclosure -ComputerName $name  | Select Tag,AudibleAlarm,ChassisTypes,HeatGeneration,HotSwappable,InstallDate,LockPresent,PoweredOn,PartNumber,SerialNumber  | ConvertTo-html  -Body "<H2> System Enclosure Information </H2>" >> "$filepath\$name.html"

#Tarjeta de Video
gwmi Win32_VideoController | Select Caption, DriverVersion, VideoModeDescription, VideoProcessor | ConvertTo-html  -Body "<H2> Informacion de GPU </H2>" >> "$filepath\$name.html"

#Monitor
gwmi Win32_DesktopMonitor | Select MonitorManufacturer, Name, ScreenHeight, ScreenWidth | ConvertTo-html  -Body "<H2> Monitor Information </H2>" >> "$filepath\$name.html"
#gwmi WmiMonitorID -ComputerName $name -Namespace root\wmi | Select InstanceName, YearOfManufacture 

#Teclado
gwmi Win32_Keyboard -Namespace root\cimv2 | Select CreationClassName, Name, Status, Description, NumberOfFunctionKeys | ConvertTo-html  -Body "<H2> Keyboard Information </H2>" >> "$filepath\$name.html"

#IMP
gwmi Win32_Printer | Select Location, Name, ShareName, SystemName, PortName | ConvertTo-html  -Body "<H2> Printer Information </H2>" >> "$filepath\$name.html"
gwmi Win32_TCPIPPrinterPort | Select Description, HostAddress, Name, PortNumber, Queue, SNMPEnabled | ConvertTo-html -Body "<H2> Port Printer Information </H2>" >> "$filepath\$name.html"



#Compartida
Get-WmiObject Win32_Share | Select Name, Path, Description | ConvertTo-html  -Body "<H2> Carpetas Compartidas </H2>" >> "$filepath\$name.html"
#Disk Detalle
gwmi Win32_Volume | Select Label, Caption, FileSystem, Capacity, SerialNumber | ConvertTo-html  -Body "<H2> Discos </H2>" >> "$filepath\$name.html"
#Services List
#gwmi Win32_Service | Select Name, StartMode, State, Status | ConvertTo-html -Body "<H2> Services List </H2>" >> "$filepath\$name.html"
Get-WmiObject -class win32_Product | Select Name, Vendor, Version | ConvertTo-html  -Body "<H2> Programas Instalados </H2>" >> "$filepath\$name.html"
#gwmi Win32_SystemDriver | Select Name, Started, Status | ConvertTo-html  -Body "<H2> Driver List </H2>" >> "$filepath\$name.html"

gwmi Win32_OperatingSystem | Select Name
[System.Environment]::OSVersion.Version

#HW Change
#Get-WmiObject Win32_DeviceChangeEvent -Namespace ROOT/cimv2 | Select EventType


## Invoke Expressons
invoke-Expression "$filepath\$name.html"

#### Sending Email

#Send-MailMessage -To $to -Subject $subject -From $from  $subject -SmtpServer $smtp -Priority "High" -BodyAsHtml -Attachments "$filepath\$name.html" 
