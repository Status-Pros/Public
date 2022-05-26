# Clear Teams Cache

$clearCache = "Y"
$clearCache = $clearCache.ToUpper()

if ($clearCache -eq "Y"){
    # Stopping Teams Process

    try{
        Get-Process -ProcessName Teams | Stop-Process -Force
        Start-Sleep -Seconds 3
        
    }catch{
        echo $_
    }
    
    # Clearing Teams Disk Cache

    try{
        Get-ChildItem -Path $env:APPDATA\"Microsoft\teams\application cache\cache" | Remove-Item -recurse -Confirm:$false
        Get-ChildItem -Path $env:APPDATA\"Microsoft\teams\blob_storage" | Remove-Item -recurse -Confirm:$false
        Get-ChildItem -Path $env:APPDATA\"Microsoft\teams\databases" | Remove-Item -recurse -Confirm:$false
        Get-ChildItem -Path $env:APPDATA\"Microsoft\teams\cache" | Remove-Item -recurse -Confirm:$false
        Get-ChildItem -Path $env:APPDATA\"Microsoft\teams\gpucache" | Remove-Item -recurse -Confirm:$false
        Get-ChildItem -Path $env:APPDATA\"Microsoft\teams\Indexeddb" | Remove-Item -recurse -Confirm:$false
        Get-ChildItem -Path $env:APPDATA\"Microsoft\teams\Local Storage" | Remove-Item -recurse -Confirm:$false
        Get-ChildItem -Path $env:APPDATA\"Microsoft\teams\tmp" | Remove-Item -recurse -Confirm:$false
        
    }catch{
        echo $_
    }

    # Stopping Chrome Process

    try{
        Get-Process -ProcessName Chrome| Stop-Process -Force
        Start-Sleep -Seconds 3
        
    }catch{
        echo $_
    }

    # Clearing Chrome Cache
    
    try{
        Get-ChildItem -Path $env:LOCALAPPDATA"\Google\Chrome\User Data\Default\Cache" | Remove-Item -Confirm:$false
        Get-ChildItem -Path $env:LOCALAPPDATA"\Google\Chrome\User Data\Default\Cookies" -File | Remove-Item -Confirm:$false
        Get-ChildItem -Path $env:LOCALAPPDATA"\Google\Chrome\User Data\Default\Web Data" -File | Remove-Item -Confirm:$false
        
    }catch{
        echo $_
    }
    
    # Stopping IE Process
    
    try{
        Get-Process -ProcessName MicrosoftEdge | Stop-Process -Force
        Get-Process -ProcessName IExplore | Stop-Process -Force
        
    }catch{
        echo $_
    }

    # Clearing IE Cache
    
    try{
        RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 8
        RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 2
        
    }catch{
        echo $_
    }

    # Cleanup Complete... Launching Teams
    Start-Process -FilePath $env:LOCALAPPDATA\Microsoft\Teams\current\Teams.exe -WindowStyle Minimized
    
}


