# This script will take input from a CSV file and update AD user attributes according to the information provided

# Get CSV content
$CSVrecords = Import-Csv c:\support\UserAttribExport.csv

# Create arrays for skipped and failed users
$SkippedUsers = @()
$FailedUsers = @()
clear-variable -Name "user"

# Loop through CSV records
foreach ($CSVrecord in $CSVrecords) {
    $sam = $CSVrecord.samAccountName
    $user = Get-ADUser -Properties * $sam
    if ($user) {
        try{

# mailNickname
        if ($user.mailNickname -eq $null -or $user.mailNickname -eq ""){
            if ($CSVrecord.mailNickname -eq $null -or $CSVrecord.mailNickname -eq ""){}
            else{
                $user | set-aduser -Add @{mailNickname=$CSVrecord.mailNickname}
            }
        }
            else{
                    if ($CSVrecord.mailNickname -ne $null -or $CSVrecord.mailNickname -ne ""){
                        $user | set-aduser -replace @{mailNickname=$CSVrecord.mailNickname}
                    }
                    else{}
                }

# proxyAddresses
        if ($user.proxyAddresses -eq $null -or $user.proxyAddresses -eq ""){
            if ($CSVrecord.proxyAddresses -eq $null -or $CSVrecord.proxyAddresses -eq ""){}
            else{
                $user | set-aduser -Add @{proxyAddresses=$CSVrecord.proxyAddresses -split ","}
            }
        }
            else{
                    if ($CSVrecord.proxyAddresses -ne $null -or $CSVrecord.proxyAddresses -ne ""){
                        $user | set-aduser -replace @{proxyAddresses=$CSVrecord.proxyAddresses -split ","}
                    }
                    else{}
                }        

# showInAddressBook
        if ($user.showInAddressBook -eq $null -or $user.showInAddressBook -eq ""){
            if ($CSVrecord.showInAddressBook -eq $null -or $CSVrecord.showInAddressBook -eq ""){}
            else{
                $user | set-aduser -Add @{showInAddressBook=$CSVrecord.showInAddressBook -split ";"}
            }
        }
            else{
                    if ($CSVrecord.showInAddressBook -ne $null -or $CSVrecord.showInAddressBook -ne ""){
                        $user | set-aduser -replace @{showInAddressBook=$CSVrecord.showInAddressBook -split ";"}
                    }
                    else{}
                }

# title                 
        if ($user.title -eq $null -or $user.title -eq ""){
            if ($CSVrecord.title -eq $null -or $CSVrecord.title -eq ""){}
            else{
                $user | set-aduser -Add @{title=$CSVrecord.title}
            }
        }
            else{
                    if ($CSVrecord.title -ne $null -or $CSVrecord.title -ne ""){
                        $user | set-aduser -replace @{title=$CSVrecord.title}
                    }
                    else{}
                }

# telephoneNumber     !!!!! this is where I finished            
        if ($user.telephoneNumber -eq $null -or $user.telephoneNumber -eq ""){
            if ($CSVrecord.telephoneNumber -eq $null -eq $null -or $CSVrecord.telephoneNumber -eq ""){}
            else{
                $user | set-aduser -Add @{telephoneNumber=$CSVrecord.telephoneNumber}
            }
        }
            else{
                    if ($CSVrecord.telephoneNumber -ne $null -or $CSVrecord.telephoneNumber -ne ""){
                        $user | set-aduser -replace @{telephoneNumber=$CSVrecord.telephoneNumber}
                    }
                    else{}
                }

# physicalDeliveryOfficeName                 
        if ($user.physicalDeliveryOfficeName -eq $null -or $user.physicalDeliveryOfficeName -eq ""){
            if ($CSVrecord.physicalDeliveryOfficeName -eq $null -or $CSVrecord.physicalDeliveryOfficeName -eq ""){}
            else{
                $user | set-aduser -Add @{physicalDeliveryOfficeName=$CSVrecord.physicalDeliveryOfficeName}
            }
        }
            else{
                    if ($CSVrecord.physicalDeliveryOfficeName -ne $null -or $CSVrecord.physicalDeliveryOfficeName -ne ""){
                        $user | set-aduser -replace @{physicalDeliveryOfficeName=$CSVrecord.physicalDeliveryOfficeName}
                    }
                    else{}
                }

# homeDrive                 
        if ($user.homeDrive -eq $null -or $user.homeDrive -eq "" ){
            if ($CSVrecord.homeDrive -eq $null -or $CSVrecord.homeDrive -eq ""){}
            else{
                $user | set-aduser -Add @{homeDrive=$CSVrecord.homeDrive}
            }
        }
            else{
                    if ($CSVrecord.homeDrive -ne $null -or $CSVrecord.homeDrive -ne ""){
                        $user | set-aduser -replace @{homeDrive=$CSVrecord.homeDrive}
                    }
                    else{}
                }

# homeDirectory                
        if ($user.homeDirectory -eq $null -or $user.homeDirectory -eq ""){
            if ($CSVrecord.homeDirectory -eq $null -or $CSVrecord.homeDirectory -eq ""){}
            else{
                $user | set-aduser -Add @{homeDirectory=$CSVrecord.homeDirectory}
            }
        }
            else{
                    if ($CSVrecord.homeDirectory -ne $null -or $CSVrecord.homeDirectory -ne ""){
                        $user | set-aduser -replace @{homeDirectory=$CSVrecord.homeDirectory}
                    }
                    else{}
                }

# employeeid                 
        if ($user.employeeid -eq $null -or $user.employeeid -eq ""){
            if ($CSVrecord.employeeid -eq $null -or $CSVrecord.employeeid -eq ""){}
            else{
                $user | set-aduser -Add @{employeeid=$CSVrecord.employeeid}
            }
        }
            else{
                    if ($CSVrecord.employeeid -ne $null -or $CSVrecord.employeeid -ne ""){
                        $user | set-aduser -replace @{employeeid=$CSVrecord.employeeid}
                    }
                    else{}
                }

        } catch {
        $FailedUsers += "$sam"
        Write-Warning "$sam user FAILED to update."
        }
    }
    else {
        Write-Warning "$sam not found, skipped"
        $SkippedUsers += "$sam"
    }
}

# Array skipped users
# $SkippedUsers

# Array failed users
# $FailedUsers


$SkippedUsers | out-file 'c:\support\skippedusers.csv'
$FailedUsers | out-file 'c:\support\failedusers.csv'