# WindowsVolatileInfo

This script collects volatile informations in Windows OS and print them to file named **Windows_Volatile_Information_Report_(Start_Timestamp).txt** with the headers below.

System Processes
Running Services
DNS Client Cache
ARP Cache
Clipboard Information
Visible Networks
Active TCP/UDP Connections 

**NOTE:**
If you have admin credentials, Active TCP/UDP Connections will have application names.


## Usage
Run **main.ps1** as normal powershell script 

```
PS C:\Users\user> .\main.ps1
```

You can by-pass execution policy with 

```
PS C:\Users\user> Get-Content .\main.ps1 | PowerShell.exe -noprofile -
```
 
### All commands for download(clone) and run

```
PS C:\Users\user> git clone https://github.com/hacetin/WindowsVolatileInfo.git
PS C:\Users\user> cd .\WindowsVolatileInfo\
PS C:\Users\user\WindowsVolatileInfo> Get-Content .\main.ps1 | PowerShell.exe -noprofile -
```

## Example Report Format

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