    function create-7zip([String] $aDirectory, [String] $aZipfile){
        [string]$pathToZipExe = "$($Env:ProgramFiles)\7-Zip\7z.exe";
        [Array]$arguments = "a", "-tzip", "$aZipfile", "$aDirectory", "-r";
        & $pathToZipExe $arguments;
    }

    # Remove-Item -Recurse -Force -ErrorAction silentlycontinue 'hats_shell.zip'
    # create-7zip "C:\Program Files\hats\*" "hats_shell.zip"

    Start-Process "C:\Program Files (x86)\Inno Setup 5\iscc.exe" -ArgumentList '/O"..\..\" "..\virtualenv\hats_for_windows.iss"' -NoNewWindow -Wait;

    & taskkill /F /IM iexplore.exe /T /FI "STATUS eq RUNNING"
    & taskkill /F /IM firefox.exe /T /FI "STATUS eq RUNNING"
    & taskkill /F /IM chrome.exe /T /FI "STATUS eq RUNNING"