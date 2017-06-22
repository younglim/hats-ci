 	Set-ExecutionPolicy Bypass
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    chocolatey install jdk8 nodejs-lts nvda --no-progress -y
    chocolatey install firefox python2 -x86 --no-progress -y
    refreshenv
    echo $env:path
    