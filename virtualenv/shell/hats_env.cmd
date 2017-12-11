@echo OFF

SET "PATH=%WINDIR%\system32\WindowsPowerShell\v1.0;%WINDIR%;%PROGRAMFILES%\hats;"

FOR /F "tokens=* USEBACKQ" %%F IN (`powershell -command "hats_shell echo `$env:path` | select -Last 1"`) DO (
SET "PATH=%%F;%PATH%"
)

%~1