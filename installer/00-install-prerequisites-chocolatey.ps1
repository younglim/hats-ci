 	Set-ExecutionPolicy Bypass
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    chocolatey install firefox -x86 --no-progress -y
    chocolatey install googlechrome nodejs-lts --no-progress -y
    chocolatey upgrade googlechrome nodejs-lts firefox --no-progress -y
    chocolatey uninstall jdk8 python2 --no-progress -y > $null
    
	if ((gwmi win32_operatingsystem | select osarchitecture).osarchitecture -eq "64-bit") {
        Remove-Item -Recurse -Force -ErrorAction silentlycontinue "${Env:ProgramFiles(x86)}\hats"
	  }
	  else {
	    Remove-Item -Recurse -Force  -ErrorAction silentlycontinue "${Env:ProgramFiles}\hats"
	}

    refreshenv
    echo $env:path
    