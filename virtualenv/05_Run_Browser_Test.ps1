# Set path to hats
$path_to_hats = "$env:PROGRAMFILES\hats"
echo "Path to hats at $path_to_hats"

# Set current path
$current_path = (Get-Item -Path ".\" -Verbose).FullName
echo "Stored current working directory at $current_path"

echo "Set path to JRE for this session"
$env:Path = "$env:windir;$env:windir\system32;"
$env:Path = "$env:Path;$path_to_hats;";

cd "$current_path"

echo "Running Robot on testpage"
hats_shell .\test.cmd

	