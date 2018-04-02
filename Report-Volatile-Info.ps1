<#

.SYNOPSIS
    This script collects volatile informations in Windows OS.

.DESCRIPTION
    This script collects volatile informations in Windows OS and print them to file
    named "Windows_Volatile_Information_Report_<Timestamp>.txt" with the headers below.

    System Processes
    Running Services
    DNS Client Cache
    ARP Cache
    Clipboard Information
    Visible Networks
    Active TCP/UDP Connections
    
.EXAMPLE
    ./Report-Volatile-Info.ps1

#>

#If powershell version lower than 3, define some functions
If((Test-Path Variable:PSVersionTable) -And ($PSVersionTable.PSVersion.Major -lt 3)) 
{
    # Source: https://gallery.technet.microsoft.com/scriptcenter/ad12dc1c-b0c7-44d6-97c7-1a537b0b4fef
    Function Get-DnsClientCache{ 
    $DNSCache = @() 
     
    Invoke-Expression "IPConfig /DisplayDNS" | 
    Select-String -Pattern "Record Name" -Context 0,5 | 
        %{ 
            $Record = New-Object PSObject -Property @{ 
            Name = ($_.Line -Split ":")[1] 
            Type = ($_.Context.PostContext[0] -Split ":")[1] 
            TTL = ($_.Context.PostContext[1] -Split ":")[1] 
            Length = ($_.Context.PostContext[2] -Split ":")[1] 
            Section = ($_.Context.PostContext[3] -Split ":")[1] 
            HostRecord = ($_.Context.PostContext[4] -Split ":")[1] 
            } 
            $DNSCache += $Record 
        } 
        Return $DNSCache 
    }

    #Source: http://www.nivot.org/post/2009/10/14/PowerShell20GettingAndSettingTextToAndFromTheClipboard
    Function Get-Clipboard {
            $command = {
                    add-type -an system.windows.forms
                    [System.Windows.Forms.Clipboard]::GetText()
            }
            powershell -sta -noprofile -command $command
    }

    Function Get-NetNeighbor { 
        $ARPCache = arp -a
        return $ARPCache
    }
} 

$Timestamp = Get-Date -UFormat "%Y%m%d_%H%M%S_%Z"
$OutputFileName = ".\Windows_Volatile_Information_Report_" + $Timestamp + ".txt"

#Prints text to the host as green colored 
Function Print-Host-Info($Text) {Write-Host -ForegroundColor GREEN $Text}

#Appends text to output file defined above
Function Append-File($Text) {$Text.ToUpper() | Out-File -Append $OutputFileName}

Print-Host-Info "...Starting Volatile Informations Script..."

Append-File "WINDOWS VOLATILE INFORMATION REPORT`n`n"

Print-Host-Info "Getting System Processes"
Append-File "SYSTEM PROCESSES"
Get-Process | Format-Table -AutoSize -Wrap | Out-File -Append -FilePath $OutputFileName

Print-Host-Info "Getting Running Services"
Append-File "RUNNING SERVICES"
Get-Service | Where-Object {$_.Status -eq "Running"} | Format-Table -AutoSize -Wrap | 
    Out-File -Append -FilePath $OutputFileName

Print-Host-Info "Getting DNS Client Cache"
Append-File "DNS CLIENT CACHE"
Get-DnsClientCache | Format-Table -AutoSize -Wrap | Out-File -Append -FilePath $OutputFileName

Print-Host-Info "Getting ARP Cache"
Append-File "ARP CACHE"
Get-NetNeighbor | Format-Table -AutoSize -Wrap | Out-File -Append -FilePath $OutputFileName

Print-Host-Info "Getting Clipboard Information"
Append-File "CLIPBOARD INFORMATION`n"
Get-Clipboard | Out-File -Append -FilePath $OutputFileName
Append-File "`n"

Print-Host-Info "Getting Visible Networks"
Append-File "VISIBLE NETWORKS"
netsh wlan show networks | Out-File -Append -FilePath $OutputFileName

Append-File "ACTIVE TCP/UDP CONNECTIONS"
Print-Host-Info "Getting Active TCP/UDP Connections with Application Names"
If(([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()`
    ).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    netstat -anob | Out-File -Append -FilePath $OutputFileName
}
Else # If there is no permission for -b parameter
{
    Write-Host -ForegroundColor RED "You don't have admin credentials."
    Print-Host-Info "Getting Active TCP/UDP Connections"
    netstat -ano | Out-File -Append -FilePath $OutputFileName
}
