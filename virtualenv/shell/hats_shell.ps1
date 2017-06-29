# Set current path
$current_path = (Get-Item -Path ".\" -Verbose).FullName
echo "Stored current working directory at $current_path"

# Set path to hats
$path_to_hats = "$current_path"

echo "Overwrite 'robot\Lib\orig-prefix.txt' with directory to Python"
[System.IO.File]::WriteAllText("$path_to_hats\robot\Lib\orig-prefix.txt","$path_to_hats\Python27".ToLower(),[System.Text.Encoding]::ASCII)

echo "Set path to Python27"
$env:Path = "$env:Path;$path_to_hats\Python27;$path_to_hats\Python27\Scripts";

echo "Set path to JRE for this session"
$env:Path = "$env:windir;$env:windir\system32"
$env:Path = "$env:Path;$path_to_hats\jre\bin";

echo "Set path to browser drivers for this session"
$env:Path = "$env:Path;$path_to_hats\drivers";

echo "Activate robot virtual environment"
cd "$path_to_hats"
robot\Scripts\activate

cd "$current_path"

echo ""
$allArgs = $PsBoundParameters.Values + $args

if ($allArgs) 
{ 
	echo "Running: $allArgs"
	iex $allArgs 
} else 
{

}
