@echo OFF

FOR /F "tokens=* USEBACKQ" %%F IN (`powershell -command "%PROGRAMFILES%\hats\hats_shell.cmd echo `$env:path` | select -Last 1"`) DO (
SET "PATH=%%F;%WINDIR%;%PROGRAMFILES%\hats;%SYSTEM32%\WindowsPowerShell\v1.0"
)

%~1