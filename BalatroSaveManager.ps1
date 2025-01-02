$user = (whoami).split("\")[1] # Gets the user for documents folder

$confirmusage = Read-Host 'This script is provided with no warrenty and no guarentee of working, 
This script saves backups of the users save folder and saves them as zip files in Documents/BalatroSaveManager/time.zip.
Ignore my bad coding. 
Would you like to continue? (y/n)
'
# Function to get all files in BalatroSaveManager and format them correctly.
Function Open-Backups {
    $files = Get-ChildItem -Path "C:/Users/$user/Documents/BalatroSaveManager/" -File
    $counter = 1
        foreach ($file in $files) {
             Write-Output "$counter. $($file.Name)"
             $counter++ 
    }}
Function Copy-Backup {

}
Function Open-Menu {
    $openitem = Read-Host 'What function would you like to do.
    1. Back-up Save
    2. Revert to Save
    3. List all backups
    '
    if ($openitem -eq 1) {
            New-Item "C:/Users/$user/Documents/BalatroSaveManager/" -Type Directory *> $null 
        $timestamp = Get-Date -Format "yyyy-MM-dd-HH-mm-ss"
            Compress-Archive -LiteralPath C:/Users/$user/AppData/Roaming/Balatro/ -DestinationPath C:/Users/$user/Documents/BalatroSaveManager/$timestamp.zip
            Write-Host "Saved backup to C:/Users/$user/Documents/BalatroSaveManager/$timestamp.zip"
        Open-Menu
        }
    if ($openitem -eq 2) {
        $files = Get-ChildItem -Path "C:/Users/$user/Documents/BalatroSaveManager/" -File
    $counter = 1
        foreach ($file in $files) {
             Write-Output "$counter. $($file.Name)"
             $counter++ 
        }
        $selection = Read-Host "Enter the number for the backup to restore"
        $selectedFile = $files[$selection - 1].FullName
         $backupbefore = Read-Host 'Would you like to backup the current save file first? (Y/n)'
              if ($backupbefore -eq 'n') { 
                Remove-Item -Path "C:\Users\$user\AppData\Roaming\Balatro\" -Recurse -Force *> $null 
                Expand-Archive -Path $selectedFile -DestinationPath C:/Users/$user/AppData/Roaming/ -Force
                Open-Menu
        }
              else {
            New-Item "C:/Users/$user/Documents/BalatroSaveManager/" -Type Directory *> $null
            $timestamp = Get-Date -Format "yyyy-MM-dd-HH-mm-ss"
            Compress-Archive -LiteralPath C:/Users/$user/AppData/Roaming/Balatro/ -DestinationPath C:/Users/$user/Documents/BalatroSaveManager/$timestamp.zip
            Write-Host "Saved backup to C:/Users/$user/Documents/BalatroSaveManager/$timestamp.zip"
            Remove-Item -Path "C:\Users\$user\AppData\Roaming\Balatro" -Recurse -Force *> $null
            Expand-Archive -Path $selectedFile -DestinationPath C:/Users/$user/AppData/Roaming/ -Force
            Open-Menu
        }
} 
    if ($openitem -eq 3) {
        Open-Backups
        Open-Menu
        }
}
        #Finally, run the script with all functions defined.
        if ($confirmusage -eq 'y') {
            Open-Menu
        }
        else {return}                                                               
