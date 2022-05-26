# Remove Teams Machine-Wide Installer (if it exists)
$MachineWide = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq "Teams Machine-Wide Installer"}
if($MachineWide -ne $null) {
$MachineWide.Uninstall()
}
else {
}