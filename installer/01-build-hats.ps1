    function create-7zip([String] $aDirectory, [String] $aZipfile){
        [string]$pathToZipExe = "$($Env:ProgramFiles)\7-Zip\7z.exe";
        [Array]$arguments = "a", "-tzip", "$aZipfile", "$aDirectory", "-r";
        & $pathToZipExe $arguments;
    }

 	Set-ExecutionPolicy Bypass

    Remove-Item -Recurse -Force -ErrorAction silentlycontinue "${Env:ProgramFiles}\hats"

    cd ../virtualenv

    .\00_Install_and_Run_Robot.bat

    cd ../../
    create-7zip "${Env:ProgramFiles}\hats" "hats.zip"