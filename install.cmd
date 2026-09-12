@echo off
setlocal
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\install.ps1"
set "installer_result=%ERRORLEVEL%"
if not "%installer_result%"=="0" echo Installation needs attention. See the message above.
pause
exit /b %installer_result%
