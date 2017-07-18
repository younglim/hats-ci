@echo OFF
pushd %~dp0

goto run_Application

:run_Application
echo ""
echo "hats Installer Updater"
echo "======================"
echo.
echo
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command ".\update.ps1"
pause
