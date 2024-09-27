### Written by Brenden Coyte ###

$Title = 'FSRM Quota Updater'

function Show-Menu
{
    Clear-Host
    Write-Host "=========== $Title ==========="
    Write-Host "1: Press '1' for Branches."
    Write-Host "2: Press '2' for Users."
    Write-Host "Q: Press 'Q' to quit."
}

function Get-FSRMBranchQuota{
    $FolderID = Read-host "Enter the Folder ID or Name (e.g. 007 or Sydney)"
    $FolderPath = Get-ChildItem -Path D:\Location\Of\Folder | where-object{$_.Name -match $BranchID} | % {$_.FullName}
    Get-FSRMQuota -path $FolderPath
}

function Get-FSRMUserQuota{
    $Username = Read-host "Enter the User's username (e.g. john.smith)"
    $User = Get-ADUser -Identity $Username -Properties * | % {$_.HomeDirectory}
    $UserID = $User.replace("\\folderlocation","D:") #not required if you map to \\folderlocation is FSRM
    Get-FSRMQuota -path $UserID
}

Do{
    Show-Menu –Title $Title
    $menuoptions = Read-Host "Please type in an option"
    switch ($menuoptions){
        '1' {
            Get-FSRMBranchQuota
        } '2' {
            Get-FSRMUserQuota
        } 'q' {
            exit
        }
        default {
            'You should consider going to specsavers!'
            break
        }
    }
    Pause
}
until ($menuoptions -eq 'q')
