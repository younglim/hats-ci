# Set path to hats
$path_to_hats = "$env:APPDATA\hats"

echo "Create drivers folder in $path_to_hats"
If(!(test-path $path_to_hats))
{
	New-Item -ItemType Directory -Force -Path $path_to_hats
}

echo "Removing  temporary files that are no longer needed"
Get-ChildItem "$path_to_hats" -recurse -include *.msi -force | remove-item
Get-ChildItem "$path_to_hats" -recurse -include *.zip -force | remove-item
Get-ChildItem "$path_to_hats" -recurse -include *.exe -force | remove-item
$fso = New-Object -ComObject scripting.filesystemobject
$fso.DeleteFolder("$path_to_hats\7-Zip")

echo "Copy shell scripts to $path_to_hats"
Copy-Item "shell\*" "$path_to_hats"