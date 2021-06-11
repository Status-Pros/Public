Clear-Host
$DC = Read-Host "FQDN of domain controller to connect to"
Get-DnsServerZone -ComputerName $DC ; write-host "`n"
$Zone = Read-Host "Zone name"
$RecordPath = Read-Host "Path of CSV file to import to DNS"
$DNSRecords = Import-Csv $RecordPath

ForEach ($Record in $DNSRecords) {
    if ($Record.RecordType -eq 'A'){
        Add-DnsServerResourceRecord -ComputerName $DC -ZoneName $Zone -A -Name $Record.HostName -AllowUpdateAny -IPv4Address $Record.IP
        Write-Host "Added A Record for $($Record.Hostname)"
    }

    elseif ($Record.RecordType -eq 'CNAME'){
        Add-DnsServerResourceRecord -ComputerName $DC -ZoneName $Zone -CName -Name $Record.HostName -HostNameAlias $Record.HostNameAlias
        Write-Host "Added CNAME Record for $($Record.Hostname)"
    }

    elseif ($Record.RecordType -eq 'TXT'){
        Add-DnsServerResourceRecord -ComputerName $DC -ZoneName $Zone -TXT -Name $Record.HostName -DescriptiveText $Record.DescriptiveText
        Write-Host "Added TXT Record for $($Record.Hostname)"
    }

    elseif ($Record.RecordType -eq 'PTR'){
        Add-DnsServerResourceRecord -ComputerName $DC -ZoneName $Zone -PTR -Name $Record.HostName -PtrDomainName $Record.PtrDomainName
        Write-Host "Added PTR Record for $($Record.Hostname)"
    }

    elseif ($Record.RecordType -eq 'MX'){
        Add-DnsServerResourceRecord -ComputerName $DC -ZoneName $Zone -MX -Name $Record.HostName -MailExchange $Record.MailExchange -Preference $Record.MXPreference
        Write-Host "Added MX Record for $($Record.Hostname)"
    }

    else {
        Write-Host "Record type could not be identified for $($Record.HostName)..."
    }
}