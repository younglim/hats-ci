@echo OFF

@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass "& Set-Location '%~dp0\scrcpy-win64'; .\scrcpy.exe %*"
