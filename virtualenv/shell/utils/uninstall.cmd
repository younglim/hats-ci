@echo OFF
pushd %~dp0

goto check_Permissions

:check_Permissions
    echo Administrative permissions required. Detecting permissions...

    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
        powershell -NoProfile -ExecutionPolicy Bypass -Command ".\uninstall_ps.ps1"
        
    ) else (
        echo Failure: Attempting to run as administrator.
        powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process '%CD%\uninstall.cmd' -Verb runas"
        GOTO END

    )

:END
exit