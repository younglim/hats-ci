# Set current path
$current_path = (Get-Item -Path ".\" -Verbose).FullName

echo "Stored current working directory at $current_path"

# Set path to hats
$path_to_hats  = split-path -parent $MyInvocation.MyCommand.Definition

$path_to_origPrefix = "$path_to_hats\robot\Lib\orig-prefix.txt";
$origPrefixContent = [IO.File]::ReadAllText($path_to_origPrefix)
$pythonDir = "$path_to_hats\Python27".ToLower();

If (!$pythonDir.equals($origPrefixContent)) {
	echo "Overwrite 'robot\Lib\orig-prefix.txt' with directory to Python"

	[System.IO.File]::WriteAllText($path_to_origPrefix,$pythonDir,[System.Text.Encoding]::ASCII)
}

echo "Set path to Python27"
$env:Path = "$env:Path;$path_to_hats\Python27;$path_to_hats\Python27\Scripts";

echo "Set path to JDK for this session"
$env:Path = "$env:windir;$env:windir\system32"
$env:JAVA_HOME = "$path_to_hats\jdk"
$env:Path = "$env:Path;$env:JAVA_HOME\bin";

echo "Set path to browser drivers for this session"
$env:Path = "$env:Path;$path_to_hats\drivers";

echo "Set path to androidSDK tools for this session"
$env:Path = "$env:Path;$path_to_hats\androidSDK\tools;$path_to_hats\androidSDK\tools\bin";

echo "Set path to node for this session"
$env:Path = "$env:Path;$path_to_hats\nodejs";

echo "Set path to node_modules for this session"
$env:Path = "$env:Path;$path_to_hats\node_modules\.bin";

echo "Activate robot virtual environment"
cd "$path_to_hats"
robot\Scripts\activate

cd "$current_path"

echo ""
$allArgs = $PsBoundParameters.Values + $args + ""

if ($allArgs)
{
	echo "Running: $allArgs"
	iex "& $allArgs"
} else
{

}
