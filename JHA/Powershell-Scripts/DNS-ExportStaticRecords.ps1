$DC = Read-Host "FQDN of domain controller to connect to"
$Zone = Read-Host "Zone name"
$SavePath = Read-Host "Path to save CSV"
Get-DnsServerResourceRecord -ComputerName $DC -ZoneName $Zone | where {-not $_.TimeStamp} | Export-Csv $SavePath -NoTypeInformation