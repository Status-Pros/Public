clear
$DC = Read-Host "FQDN of domain controller to connect to"
Get-DnsServerZone ; write-host "`n"
$Zone = Read-Host "Zone name to process"
$SavePath = Read-Host "Path to save CSV"
Get-DnsServerResourceRecord -ComputerName $DC -ZoneName $Zone | where {(-not $_.TimeStamp) -and ($_.Hostname -ne "@") -and ($_.Hostname -ne "_msdcs")} | select HostName, RecordType, @{n='IP';E={$_.recorddata.IPV4Address}} | Export-Csv $SavePath -NoTypeInformation