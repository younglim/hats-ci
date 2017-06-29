@echo OFF
pushd %~dp0

echo "hats Shell [64-bit] - Created By younglim - NO WARRANTY PROVIDED"
echo "================================================================"
echo.

@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -NoExit -ExecutionPolicy Bypass -Command ".\hats_shell.ps1" %*
