@echo off
cls
echo Good day, this will install AeroCtl and add it to startup with all the necessary things.
echo.
echo Be sure you ran this program as Admin by right clicking on the file and selecting Run as Administrator.
echo If you didn't do it, it will not work.
echo.
pause
timeout /t 1 /nobreak > nul
cls
echo First tell me if you laptop used ControlCenter or SmartManager originally
echo.
echo 1. Control Center
echo 2. Smart Manager
echo 3. I'm not yet an Admin just close.
echo.

choice /c 123

IF %ERRORLEVEL%==1 Goto ControlCenter
IF %ERRORLEVEL%==2 Goto SmartManager
IF %ERRORLEVEL%==3 Goto Close

:ControlCenter
xcopy "%~dp0CC\acpimof.dll" "%windir%\system32\" /Y
xcopy "%~dp0CC\acpimof.dll" "%windir%\sysWOW64\" /Y
REG ADD HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WmiAcpi /v MofImagePath /d "%windir%\system32\acpimof.dll" /f
Goto Step2

:SmartManager
xcopy "%~dp0SM\acpimof.dll" "%windir%\system32\" /Y
xcopy "%~dp0SM\acpimof.dll" "%windir%\sysWOW64\" /Y
REG ADD HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WmiAcpi /v MofImagePath /d "%windir%\system32\acpimof.dll" /f
Goto Step2

:Step2
cls

mkdir C:\AeroMinimal
bitsadmin /transfer "Downloading AeroCtl" /download /priority FOREGROUND https://f.0x.re/aeroctl/0.4.2/AeroCtl.UI.exe C:\AeroMinimal\AeroCtl.exe

cls
echo Do you want to add AeroCtl to Startup?
echo.
echo 1. Yes
echo 2. No
echo.

choice /c 12
IF %ERRORLEVEL%==1 Goto Step3
IF %ERRORLEVEL%==2 Goto End

:Step3

SchTasks /Create /XML %~dp0Startup.xml /tn AeroCtl

:End

cls
Echo Right now AeroCtl should be installed and in C:/AeroMinimal
Echo To remove delete the folder and task in Task Scheduler
echo.

pause

:Close