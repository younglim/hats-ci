    function create-7zip([String] $aDirectory, [String] $aZipfile){
        [string]$pathToZipExe = "$($Env:ProgramFiles)\7-Zip\7z.exe";
        [Array]$arguments = "a", "-tzip", "$aZipfile", "$aDirectory", "-r";
        & $pathToZipExe $arguments;
    }

 	Set-ExecutionPolicy Bypass

	if ((gwmi win32_operatingsystem | select osarchitecture).osarchitecture -eq "64-bit") {
         Remove-Item -Recurse -Force -ErrorAction silentlycontinue "${Env:ProgramFiles(x86)}\hats"
	}
	else {
	     Remove-Item -Recurse -Force -ErrorAction silentlycontinue "${Env:ProgramFiles}\hats"
	}

    cd hats-ci/virtualenv

    .\00_Install_and_Run_Robot.bat

    cd ../../
    create-7zip "$env:ProgramFiles\hats" "hats.zip"