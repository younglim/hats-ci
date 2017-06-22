 	Set-ExecutionPolicy Bypass
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    chocolatey install firefox -x86 --no-progress -y
    chocolatey install googlechrome nodejs-lts --no-progress -y
    chocolatey upgrade googlechrome nodejs-lts firefox --no-progress -y
    chocolatey uninstall jdk8 python2 --no-progress -y > $null
    refreshenv
    echo $env:path
    