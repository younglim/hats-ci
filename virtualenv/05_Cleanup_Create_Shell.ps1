# Set path to hats
$path_to_hats = "$env:APPDATA\hats"

echo "Create drivers folder in $path_to_hats"
If(!(test-path $path_to_hats))
{
	New-Item -ItemType Directory -Force -Path $path_to_hats
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

echo "Copy shell scripts to $path_to_hats"
Copy-Item "shell\*" "$path_to_hats"