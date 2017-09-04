@echo OFF

if [%1]==[] goto empty_param

set PATH=C:\Program Files\hats\hats/Scripts;C:\Program Files\hats\androidSDK\emulator;C:\Windows;C:\Windows\system32;C:\Windows\system32\WindowsPowerShell\v1.0;C:\Program Files\hats\Python27;C:\Program Files\hats\Python27\Scripts;C:\Program Files\hats\jdk\bin;C:\Program Files\hats\drivers;C:\Program Files\hats\utils;C:\Program Files\hats\nodejs;C:\Program Files\hats\node_modules\.bin;./node_modules/.bin;C:\Program Files\hats\npm-global;C:\Program Files\hats\npm-global\bin;C:\Program Files\hats\androidSDK\tools;C:\Program Files\hats\androidSDK\tools\bin\;C:\Program Files\hats\androidSDK\platform-tools;C:\Program Files\hats\Git\cmd;C:\Program Files\hats\Git\mingw32\bin;C:\Program Files\hats\Git\usr\bin

call %*
exit /B 1

:empty_param
echo Error: Parameters not specified.
exit /B 1
