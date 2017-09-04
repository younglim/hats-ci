@echo OFF
pushd %~dp0

goto check_Permissions

:check_Permissions
    echo Administrative permissions required. Detecting permissions...

    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
		goto run_Application
    ) else (
        echo Failure: Attempting to run as administrator.
		powershell "Start-Process cmd -verb runAs '/C cd %cd% && %~nx0'" & exit

    )

    pause >nul

:run_Application
echo ""
echo "Created By younglim - NO WARRANTY PROVIDED"
echo "=========================================="
echo.
echo Please close all instances of Internet Explorer till the installation completes.
echo
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command ".\00_Create_Folder_Permissions.ps1"
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command ".\01_Install_Python27_Virtualenv_Robot.ps1"
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command ".\02_Install_Android_Requirements.ps1"
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command ".\03_Install_Browser_Drivers.ps1"
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command ".\04_Install_Git.ps1"
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command ".\05_Cleanup_Create_Shell.ps1"
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command ".\06_Patches_Env_Setup.ps1"
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command ".\07_Run_Browser_Test.ps1"

pause
