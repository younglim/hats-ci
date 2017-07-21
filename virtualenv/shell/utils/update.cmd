@echo OFF
pushd %~dp0

goto check_Permissions

:check_Permissions
    echo Administrative permissions required. Detecting permissions...

    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
        @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command ".\update_ps.ps1"
    ) else (
        echo Failure: Attempting to run as administrator.
        echo %CD%
		    @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" –NoProfile –ExecutionPolicy Bypass -Command "Start-Process '%CD%\update.cmd' -Verb runas"
    )
