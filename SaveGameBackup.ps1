# Path: SaveGameBackup.ps1
class SaveGame {
  [string] $Name
  [string] $SavePath
}

# Common folder paths you may want to use in your references
$DESKTOP = "$([Environment]::GetFolderPath('Desktop'))"
$USER_PROFILE = "$($env:USERPROFILE)"
$ROAMING_APPDATA = "$($env:APPDATA)"
$LOCAL_APPDATA = "$($env:LOCALAPPDATA)"
$LOCALLOW_APPDATA = "$($LOCAL_APPDATA)".replace("Local", "LocalLow")
$DOCUMENTS = "$([Environment]::GetFolderPath('MyDocuments'))"
# Be sure to update this to your Steam folder
$STEAM_COMMON = "E:\SteamLibrary\steamapps\common"

# Change this to the folder where you want to store your backups
$backup_folder = "$DESKTOP\SaveGameBackup"

# TODO Add Ender Lillies

# Add your save games here
$save_games = @(
  [SaveGame]@{ Name = "Aeterna Noctis"; SavePath = "$LOCALLOW_APPDATA\AeternaTheGame\Aeterna Noctis" }
  # [SaveGame]@{ Name = "Baldur's Gate 3"; SavePath = "$LOCAL_APPDATA\Larian Studios\Baldur's Gate 3\PlayerProfiles" }
  [SaveGame]@{ Name = "Bo, Path of the Teal Lotus"; SavePath = "$LOCALLOW_APPDATA\Squid Shock Studios\Bo" }
  [SaveGame]@{ Name = "Dave the Diver"; SavePath = "$LOCALLOW_APPDATA\nexon\DAVE THE DIVER\SteamSData\3043950" }
  [SaveGame]@{ Name = "Cryptical Path"; SavePath = "$LOCALLOW_APPDATA\OldSkullGames\CrypticalPath\76561197963309678\Saves" }
  [SaveGame]@{ Name = "Dead Cells"; SavePath = "$STEAM_COMMON\Dead Cells\save" }
  # [SaveGame]@{ Name = "Elden Ring"; SavePath = "$ROAMING_APPDATA\EldenRing\76561197963309678" }
  [SaveGame]@{ Name = "Ender Lilies"; SavePath = "$LOCAL_APPDATA\EnderLilies\Saved\SaveGames" }
  [SaveGame]@{ Name = "Ender Magnolia"; SavePath = "$LOCAL_APPDATA\EnderMagnolia\Saved\SaveGames" }
  [SaveGame]@{ Name = "Everspace 2"; SavePath = "$LOCAL_APPDATA\ES2\Saved\SaveGames" }
  [SaveGame]@{ Name = "Hades"; SavePath = "$DOCUMENTS\Saved Games\Hades" }
  [SaveGame]@{ Name = "Hades 2"; SavePath = "$USER_PROFILE\Saved Games\Hades II" }
  [SaveGame]@{ Name = "Have a Nice Death"; SavePath = "$LOCALLOW_APPDATA\MagicDesignStudio\HaveANiceDeath" }
  [SaveGame]@{ Name = "Hollow Knight"; SavePath = "$LOCALLOW_APPDATA\Team Cherry\Hollow Knight" }
  # [SaveGame]@{ Name = "Horizon Zero Dawn"; SavePath = "$DOCUMENTS\Horizon Zero Dawn\Saved Game" }
  [SaveGame]@{ Name = "Nine Sols"; SavePath = "$LOCALLOW_APPDATA\RedCandleGames\NineSols" }
  [SaveGame]@{ Name = "Prince of Persia Lost Crown"; SavePath = "$DOCUMENTS\My Games\Prince Of Persia The Lost Crown" }
  [SaveGame]@{ Name = "Remnant 2"; SavePath = "$USER_PROFILE\Saved Games\Remnant2\Steam\3043950" }
)

# Create the backup folder if it doesn't exist
if (-not (Test-Path $backup_folder)) {
  New-Item -ItemType Directory -Force -Path $backup_folder
}

# Create a folder for the current backup
$time_stamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$new_backup_folder = "$backup_folder\$time_stamp"
New-Item -ItemType Directory -Force -Path $new_backup_folder

# Copy the save games
foreach ($save_game in $save_games) {
  Write-Host "Backing up $($save_game.Name) from path $($save_game.SavePath)" -ForegroundColor Yellow
  $save_game_folder = "$new_backup_folder\$($save_game.Name)"
  New-Item -ItemType Directory -Force -Path $save_game_folder
  Copy-Item -Path $save_game.SavePath -Destination $save_game_folder -Recurse
}

# Clone the Remnant 2 folder to the alt account
# Write-Host "Cloning Remnant 2 main account to alt account"
# Copy-Item -Path "$USER_PROFILE\Saved Games\Remnant2\Steam\3043950\*" -Destination "$USER_PROFILE\Saved Games\Remnant2\Steam\1720142546" -Recurse

Write-Host "Backup complete: $new_backup_folder" -ForegroundColor Green

# Add prompt to prevent window from closing
Read-Host -Prompt "Press Enter to exit"