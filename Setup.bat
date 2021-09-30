@echo off
xcopy "%~dp0acpimof.dll" "%windir%\system32\" /Y
xcopy "%~dp0acpimof.dll" "%windir%\sysWOW64\" /Y
REG ADD HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WmiAcpi /v MofImagePath /d "%windir%\system32\acpimof.dll" /f
pause