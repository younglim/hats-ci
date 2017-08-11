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

$env:Path = "$env:windir;$env:windir\system32;$env:windir\system32\WindowsPowerShell\v1.0"

echo "Set path to Python27"
$env:Path = "$env:Path;$path_to_hats\Python27;$path_to_hats\Python27\Scripts";

echo "Set path to JDK for this session"
$env:JAVA_HOME = "$path_to_hats\jdk"
$env:Path = "$env:Path;$env:JAVA_HOME\bin";

echo "Set path to browser drivers for this session"
$env:Path = "$env:Path;$path_to_hats\drivers";

echo "Set path to utils for this session"
$env:Path = "$env:Path;$path_to_hats\utils";

echo "Set path to node for this session"
$env:Path = "$env:Path;$path_to_hats\nodejs";

echo "Set path to node_modules for this session"
$env:Path = "$env:Path;$path_to_hats\node_modules\.bin";

echo "Set path to npm-global for this session"
$env:Path = "$env:Path;$path_to_hats\npm-global;$path_to_hats\npm-global\bin";

echo "Set path to androidSDK tools for this session"
$env:Path = "$env:Path;$path_to_hats\androidSDK;$path_to_hats\androidSDK\bin;$path_to_hats\androidSDK\platform-tools";

echo "Activate hats virtual environment"
cd "$path_to_hats"
hats\Scripts\activate

cd "$current_path"

. $path_to_hats\utils\check_last_update.ps1

echo ""
$allArgs = $PsBoundParameters.Values + $args + ""

if ($allArgs)
{
	echo "Running: $allArgs"
	iex "& $allArgs"
} else
{

}
