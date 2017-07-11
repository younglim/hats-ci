    function create-7zip([String] $aDirectory, [String] $aZipfile){
        [string]$pathToZipExe = "$($Env:ProgramFiles)\7-Zip\7z.exe";
        [Array]$arguments = "a", "-tzip", "$aZipfile", "$aDirectory", "-r";
        & $pathToZipExe $arguments;
    }

    create-7zip "${Env:ProgramFiles}\hats" "hats.zip"