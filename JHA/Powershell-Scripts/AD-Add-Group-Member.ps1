# This script will iterate through the CSV file indicated on line 19 and add group members to specified group


BEGIN{
    #Checks if the user is in the administrator group. Warns and stops if the user is not.
    If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator"))
    {
        Write-Warning "You are not running this as local administrator. Run it again in an elevated prompt."
	    Break
    }
    try {
    Import-Module ActiveDirectory
    }
    catch {
    Write-Warning "The Active Directory module was not found"
    }
    try {
    $Users = Import-CSV C:\Support\AD_Groups2021-05.csv
    }
    catch {
    Write-Warning "The CSV file was not found"
    }
}
PROCESS{

    foreach($User in $Users){
        try{
            $GroupMembers=$user.Members.split(",")
                        foreach($GroupMember in $GroupMembers){
                        Add-ADGroupMember $User.Name $GroupMember
                     }
        }
        catch{
        }

    }
}
END{
 
}