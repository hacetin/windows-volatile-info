# WindowsVolatileInfo

This script collects volatile informations in Windows OS and print them to file named **Windows_Volatile_Information_Report_(Start_Timestamp).txt** with the headers below.

System Processes
Running Services
DNS Client Cache
ARP Cache
Clipboard Information
Visible Networks
Active TCP/UDP Connections 

**NOTE 1:**
If the host has admin credentials, Active TCP/UDP Connections will have application names.

**NOTE 2:**
This script is compatible Powershell 2.0 and higher versions. (This script is not tried at Powershell 1.0) **Get-DnsClientCache, Get-NetNeighbor and Get-Clipboard** functions are defined after Powershell 3.0. If the Powershell version is greater than or equal to 3, the script uses predefined Powershell functions. But if Powershell version is lower than 3, the script uses its own functions.

## Before 

To run any PowerShell script, Execution Policy should be set to RemoteSigned. Also, Scope should be set to Process to use Get-Help command for this script.
Here is the command for doing those

```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
```

To by-pass execution policy, read the Usage part.

## Usage

Use "Get-Help" to see description and example in the host if the Scope is set Process.

```
PS C:\Users\user> Get-Help.\Report-Volatile-Info.ps1
```

Run **Report-Volatile-Info.ps1** as a normal Powershell script 

```
PS C:\Users\user> .\Report-Volatile-Info.ps1
```

To by-pass execution policy, use

```
PS C:\Users\user> PowerShell.exe -ExecutionPolicy Bypass -File .\Report-Volatile-Info.ps1 
```
 
### All commands for download(clone) and run

```
PS C:\Users\user> git clone https://github.com/hacetin/WindowsVolatileInfo.git
PS C:\Users\user> cd .\WindowsVolatileInfo\
PS C:\Users\user\WindowsVolatileInfo> PowerShell.exe -ExecutionPolicy Bypass -File .\Report-Volatile-Info.ps1
```

## Example Report Format

This is an example report format for a Windows 10 machine with Powershell 5.1

**Windows_Volatile_Information_Report_(Start_Timestamp).txt**

```
WINDOWS VOLATILE INFORMATION REPORT


SYSTEM PROCESSES

Handles NPM(K)  PM(K)   WS(K)   CPU(s)  Id  SI  ProcessName           
------- ------  -----   -----   ------  --  --  -----------           
...


RUNNING SERVICES

Status  Name    DisplayName                                          
------  ----    -----------                                          
...


DNS CLIENT CACHE

Entry   RecordName  RecordType  Status  Section TimeToLive  Data Length Data                              
-----   ----------  ----------  ------  ------- ----------  ----------- ----                              
...


ARP CACHE

ifIndex IPAddress   LinkLayerAddress    State   PolicyStore
------- ---------   ----------------    -----   -----------
...


CLIPBOARD INFORMATION

here is the clipboard info


VISIBLE NETWORKS
 
Interface name : ... 
There are ... networks currently visible. 

SSID 1 : ...
    Network type            : ...
    Authentication          : ...
    Encryption              : ...
...
   
   
ACTIVE TCP/UDP CONNECTIONS

Active Connections

Proto   Local Address   Foreign Address     State   PID
...
[application_name]
```
