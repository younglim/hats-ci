@echo OFF

if [%1]==[] goto empty_param

set PATH=C:\Program Files\hats\robot\Scripts;C:\Windows;C:\Windows\system32;C:\Windows\system32\WindowsPowerShell\v1.0;C:\Program Files\hats\Python27;C:\Program Files\hats\Python27\Scripts;C:\Program Files\hats\jdk\bin;C:\Program Files\hats\drivers;C:\Program Files\hats\utils

call %*
exit /B 1

:empty_param
echo Error: Parameters not specified.
exit /B 1
