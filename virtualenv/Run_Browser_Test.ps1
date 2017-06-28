# Set path to hats
$path_to_hats = "$env:APPDATA\hats"
echo "Path to hats at $path_to_hats"

# Set current path
$current_path = (Get-Item -Path ".\" -Verbose).FullName
echo "Stored current working directory at $current_path"

echo "Set path to JDK for this session"
$env:Path = "$env:Path;$path_to_hats\jre\bin";

echo "Set path to browser drivers for this session"
$env:Path = "$env:Path;$path_to_hats\drivers";

echo "Activate robot virtual environment"
cd "$path_to_hats"
robot\Scripts\activate

echo "Running Robot on testpage"
cd "$current_path"
cd testpage
.\test.cmd

	