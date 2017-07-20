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
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command ".\uninstall ps.ps1"
echo "Deleting installed files..."
cd c:\
(goto) 2>nul & rmdir "c:\program files\hats" /q /s 

pause