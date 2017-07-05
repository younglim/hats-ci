@echo OFF

if [%1]==[] goto usage

@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -File "%~dp0hats_shell.ps1" %*
exit /B 1

:usage
echo "hats Shell [64-bit] - Created By younglim - NO WARRANTY PROVIDED"
echo "================================================================"
echo.

@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -NoExit -ExecutionPolicy Bypass -Command ".\hats_shell.ps1"

pause