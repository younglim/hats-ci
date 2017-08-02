@echo OFF
pushd %~dp0

goto check_Permissions

:check_Permissions
    echo Administrative permissions required. Detecting permissions...

    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
        IF EXIST "%PROGRAMFILES(X86)%" (GOTO 64BIT) ELSE (GOTO 32BIT)

    ) else (
        echo Failure: Attempting to run as administrator.
        powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process '%CD%\patches.cmd' -Verb runas"
        exit
        
    )

:64BIT
echo Patch Internet Explorer FEATURE_BFCACHE
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Internet Explorer\MAIN\FeatureControl\FEATURE_BFCACHE" /v iexplore.exe /t REG_DWORD /d 0 /f
GOTO END

:32BIT
echo Patch Internet Explorer FEATURE_BFCACHE
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\MAIN\FeatureControl\FEATURE_BFCACHE" /v iexplore.exe /t REG_DWORD /d 0 /f
GOTO END

:END
exit