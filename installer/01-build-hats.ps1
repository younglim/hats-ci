    function create-7zip([String] $aDirectory, [String] $aZipfile){
        [string]$pathToZipExe = "$($Env:ProgramFiles)\7-Zip\7z.exe";
        [Array]$arguments = "a", "-tzip", "$aZipfile", "$aDirectory", "-r";
        & $pathToZipExe $arguments;
    }

    Remove-Item -Recurse -Force -ErrorAction silentlycontinue 'hats.zip'

    create-7zip "C:\Program Files\hats" "hats.zip"

    & taskkill /F /IM iexplore.exe /T /FI "STATUS eq RUNNING"
    & taskkill /F /IM firefox.exe /T /FI "STATUS eq RUNNING"
    & taskkill /F /IM chrome.exe /T /FI "STATUS eq RUNNING"