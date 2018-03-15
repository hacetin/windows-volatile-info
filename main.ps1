<#

This script collects volatile informations in Windows OS and print them to files shown as below.

System Processes                ->    system_processes.csv
Running Services                ->    running_services.csv
DNS Client Cache                ->    dns_client_cache.csv
ARP Cache                       ->    arp_cache.csv
Clipboard Information           ->    clipboard.txt
Currently Visible Networks      ->    networks.txt

#>


#Prints green colored text to the host
function Print-Info($Text) {Write-Host -ForegroundColor GREEN $Text}

Print-Info "...Starting Volatile Informations Script..."

Print-Info "Getting System Processes"
Get-Process | Export-Csv system_processes.csv

Print-Info "Getting Running Services"
Get-Service | Where-Object {$_.Status -eq "Running"} | Export-Csv running_services.csv

Print-Info "Getting DNS Client Cache"
Get-DnsClientCache | Export-Csv dns_client_cache.csv

Print-Info "Getting ARP Cache"
Get-NetNeighbor | Export-Csv arp_cache.csv

Print-Info "Getting Clipboard Information"
Get-Clipboard | Out-File clipboard.txt

Print-Info "Getting Currently Visible Networks"
netsh wlan show networks | Out-File networks.txt