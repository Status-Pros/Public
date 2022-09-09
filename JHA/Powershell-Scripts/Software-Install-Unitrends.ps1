mkdir c:\unitemp
wget https://bpagent.s3.amazonaws.com/latest/windows/Unitrends_Agentx64.msi -OutFile c:\unitemp\Unitrends_Agentx64.msi
msiexec.exe /i /quiet FORCE_BOOT=FALSE "C:\unitemp\Unitrends_Agentx64.msi"
Remove-Item -recurse -force "c:\unitemp\"