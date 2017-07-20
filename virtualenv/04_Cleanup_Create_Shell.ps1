# Set path to hats
$path_to_hats = "$env:PROGRAMFILES\hats"
echo "path_to_hats: $path_to_hats"

If(!(test-path $path_to_hats))
{
	New-Item -ItemType Directory -Force -Path "$path_to_hats"
}

echo "Removing  temporary files that are no longer needed"
$fso = New-Object -ComObject scripting.filesystemobject
$fso.DeleteFolder("$path_to_hats\7-Zip")
$fso.DeleteFile("$path_to_hats\chromedriver.zip")
$fso.DeleteFile("$path_to_hats\geckodriver.zip")
$fso.DeleteFile("$path_to_hats\IEDriverServer.zip")
$fso.DeleteFile("$path_to_hats\VCForPython27.msi")
$fso.DeleteFile("$path_to_hats\python27.msi")
$fso.DeleteFile("$path_to_hats\7z.msi")
$fso.DeleteFile("$path_to_hats\jre.exe")
$fso.DeleteFile("$path_to_hats\get-pip.py")

echo "Copy shell scripts to $path_to_hats"
Copy-Item "shell\*" "$path_to_hats" -recurse

echo "Set environment variables"
[Environment]::SetEnvironmentVariable( "HATS", $path_to_hats, [System.EnvironmentVariableTarget]::Machine )

$path = [System.Environment]::GetEnvironmentVariable('PATH', 'Machine');
$path = ($path.Split(';') | Where-Object { $_ -ne "%HATS%" }) -join ';'
$path = $path + ";%HATS%" ;
[Environment]::SetEnvironmentVariable( "Path", $path, [System.EnvironmentVariableTarget]::Machine )

echo "Prepare installation list for future updates"
echo $path_to_hats
$fso.MoveFile("$path_to_hats\pip-install-list.txt", "$path_to_hats\utils\pip-install-list.txt")
$fso.MoveFile("$path_to_hats\pip-install-list.url", "$path_to_hats\utils\pip-install-list.url")
Get-Date > "$path_to_hats\utils\last-check.txt"
