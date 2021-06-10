Clear-Host
$DC = Read-Host "FQDN of domain controller to connect to"
Get-DnsServerZone ; write-host "`n"
$Zone = Read-Host "Zone name to process"
$SavePath = Read-Host "Path to save CSV"
Get-DnsServerResourceRecord -ComputerName $DC -ZoneName $Zone | Where-Object {(-not $_.TimeStamp) -and ($_.Hostname -ne "@") -and ($_.Hostname -ne "_msdcs")} | Select-Object HostName, RecordType, @{n='IP';E={$_.recorddata.IPV4Address}}, @{n='HostNameAlias';E={$_.recorddata.HostNameAlias}}, @{n='MailExchange';E={$_.recorddata.MailExchange}}, @{n='DescriptiveText';E={$_.recorddata.DescriptiveText}}, @{n='DomainName';E={$_.recorddata.DomainName}} | Export-Csv $SavePath -NoTypeInformation