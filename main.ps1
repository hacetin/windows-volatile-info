<#

This script collects volatile informations in Windows OS and print them to file
named "Windows_Volatile_Information_Report_<Timestamp>" with the headers below.

System Processes
Running Services
DNS Client Cache
ARP Cache
Clipboard Information
Visible Networks
Active TCP/UDP Connections

#>

$Timestamp = Get-Date -UFormat "%Y%m%d_%H%M%S_%Z"
$OutputFileName = "Windows_Volatile_Information_Report_" + $Timestamp + ".txt"

#Prints text to the host as green colored 
function Print-Host-Info($Text) {Write-Host -ForegroundColor GREEN $Text}

#Appends text to output file defined above
function Append-File($Text) {$Text.ToUpper() | Out-File -Append $OutputFileName}

Print-Host-Info "...Starting Volatile Informations Script..."

Append-File("WINDOWS VOLATILE INFORMATION REPORT`n`n")

Print-Host-Info "Getting System Processes"
Append-File("SYSTEM PROCESSES")
Get-Process | Format-Table -AutoSize -Wrap | Out-File -Append $OutputFileName

Print-Host-Info "Getting Running Services"
Append-File("RUNNING SERVICES")
Get-Service | Where-Object {$_.Status -eq "Running"} | Format-Table -AutoSize -Wrap | 
    Out-File -Append $OutputFileName

Print-Host-Info "Getting DNS Client Cache"
Append-File("DNS CLIENT CACHE")
Get-DnsClientCache | Format-Table -AutoSize -Wrap | Out-File -Append $OutputFileName

Print-Host-Info "Getting ARP Cache"
Append-File("ARP CACHE")
Get-NetNeighbor | Format-Table -AutoSize -Wrap | Out-File -Append $OutputFileName

Print-Host-Info "Getting Clipboard Information"
Append-File("CLIPBOARD INFORMATION`n")
Get-Clipboard | Out-File -Append $OutputFileName
Append-File("`n")

Print-Host-Info "Getting Visible Networks"
Append-File("VISIBLE NETWORKS")
netsh wlan show networks | Out-File -Append $OutputFileName

Append-File("ACTIVE TCP/UDP CONNECTIONS")
Try
{
    Print-Host-Info "Getting Active TCP/UDP Connections with Application Names"
    netstat -anob | Out-File -Append $OutputFileName
}
Catch # If there is no permission for -b parameter
{
    Write-Host -ForegroundColor RED "FAILED. Most probably, you don't have the permission."
    Print-Host-Info "Getting Active TCP/UDP Connections"
    netstat -ano | Out-File -Append $OutputFileName
}