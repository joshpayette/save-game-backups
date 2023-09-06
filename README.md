# Save Game Backup Script

## Description

This is a basic Powershell script that will back up your save games to a specified directory. 
Each backup will be placed in a folder named after the current date and time, allowing you to keep 
multiple backups.

## Usage

1. Download the script and place it in a directory of your choice.
2. Open the script in a text editor and change the value of the `$backup_folder` variable to the directory 
   you want to back up to.
3. Add your games to the `$save_games` array, using the format:
```powershell
[SaveGame]@{ Name = "THE GAME NAME"; SavePath = "C:\The\Game\Save\Path" }
```
4. Save the script.
5. Run the script by right-clicking it and selecting `Run with Powershell`.

## Scheduling the script to run automatically

1. Open Task Scheduler as administrator.
1. Click `Create Task...`.
1. Give the task a name and description.
1. Under `Security options`, select `Run with highest privileges`.
1. Under `Configure for`, select `Windows 10`.
1. Under `Triggers`, click `New...`.
1. Select `Daily` and click `OK`.
1. Under `Triggers`, click `New...` again.
1. Select `At startup` and click `OK`.
1. Under `Actions`, click `New...`.
1. Under `Program/script`, enter `powershell.exe`.
1. Under `Add arguments`, enter `-File C:\Path\To\Script\SaveGameBackup.ps1`.
1. Click `OK`.
1. Under Settings, check `Run task as soon as possible after a scheduled start is missed`
1. Click `OK` again.

### Test the scheduled task

1. Click `Task Scheduler Library` in the left pane.
1. Find the scheduled task in the main pane and right-click it.
1. Select `Run`.
1. If it ran correclty, you should have a Powershell window up asking you to close it, showing the results.