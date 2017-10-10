# Set current path
$current_path = (Get-Item -Path ".\" -Verbose).FullName

echo "Stored current working directory at $current_path"

# Set path to hats
$path_to_hats  = split-path -parent $MyInvocation.MyCommand.Definition

$path_to_origPrefix = "$path_to_hats\hats\Lib\orig-prefix.txt";
$origPrefixContent = [IO.File]::ReadAllText($path_to_origPrefix)
$pythonDir = "$path_to_hats\Python27".ToLower();

If (!$pythonDir.equals($origPrefixContent)) {
	echo "Overwrite 'hats\Lib\orig-prefix.txt' with directory to Python"

	[System.IO.File]::WriteAllText($path_to_origPrefix,$pythonDir,[System.Text.Encoding]::ASCII)
}

$env:Path = "$env:windir;$env:windir\system32;$env:windir\system32\WindowsPowerShell\v1.0"

echo "Set path to Python27"
$env:Path = "$env:Path;$path_to_hats\Python27;$path_to_hats\Python27\Scripts";

if ([System.IntPtr]::Size -eq 4)
{
	echo "Set path to JDK32 for this session"
	$env:JAVA_HOME = "$path_to_hats\jdk32"
	$env:Path = "$env:Path;$env:JAVA_HOME\bin";
}
else
{
	echo "Set path to JDK for this session"
	$env:JAVA_HOME = "$path_to_hats\jdk"
	$env:Path = "$env:Path;$env:JAVA_HOME\bin";
}

echo "Set path to browser drivers for this session"

$path_to_programfiles_x86 = "C:\Program Files (x86)"
if (-Not (Test-Path $path_to_programfiles_x86))
{
	$path_to_programfiles_x86 = "C:\Program Files"
}

$chrome_path = "$path_to_programfiles_x86\Google\Chrome\Application\chrome.exe";

if (Test-Path $chrome_path) 
{
	$chrome_version = (Get-Item $chrome_path).VersionInfo.FileVersion

	if ($chrome_version -match "5[6-8].*") 
	{
		echo "Support for Chrome v58 enabled"
		$env:Path = "$env:Path;$path_to_hats\drivers\win64\chrome-58";
	}
}

$firefox_path = "C:\Program Files\Mozilla Firefox\firefox.exe";

if (Test-Path $firefox_path) 
{
	$firefox_version = (Get-Item $firefox_path).VersionInfo.FileVersion

	if ($firefox_version -match "[0-5][0-4].*") 
	{
		echo "Support for Firefox <= v54 enabled"

		if ([System.IntPtr]::Size -eq 4)
			$env:Path = "$env:Path;$path_to_hats\drivers\win32\firefox-54";
		}
		else 
		{ 
			$env:Path = "$env:Path;$path_to_hats\drivers\win64\firefox-54";
		}
		
	}
}


if ([System.IntPtr]::Size -eq 4)
{
	$env:Path = "$env:Path;$path_to_hats\drivers\win32";
}
else
{
	$env:Path = "$env:Path;$path_to_hats\drivers\win64";
}

echo "Set path to utils for this session"
$env:Path = "$env:Path;$path_to_hats\utils";

echo "Set path to node for this session"
$env:Path = "$env:Path;$path_to_hats\nodejs";

echo "Set path to node_modules for this session"
$env:Path = "$env:Path;$path_to_hats\node_modules\.bin;./node_modules/.bin";

echo "Set path to npm-global for this session"
$env:Path = "$env:Path;$path_to_hats\npm-global;$path_to_hats\npm-global\bin";

echo "Set path to androidSDK tools for this session"
$env:Path = "$env:Path;$path_to_hats\androidSDK\emulator;$path_to_hats\androidSDK\tools;$path_to_hats\androidSDK\tools\bin\;$path_to_hats\androidSDK\platform-tools";

$env:ANDROID_HOME = "$path_to_hats\androidSDK"
$env:ANDROID_SDK_HOME = "$path_to_hats\androidSDK"
$env:ANDROID_SDK_ROOT = "$path_to_hats\androidSDK"

echo "Set path to Git for this session"
$env:Path = "$env:Path;$path_to_hats\Git\cmd;$path_to_hats\Git\mingw32\bin;$path_to_hats\Git\usr\bin"

echo "Set path to Gatling for this session"
$env:Path = "$env:Path;$path_to_hats\Gatling\bin"
$env:GATLING_HOME = "$path_to_hats\Gatling"

echo "Set path to JMeter for this session"
$env:Path = "$env:Path;$path_to_hats\JMeter\bin"

echo "Set path to RED for this session"
$env:Path = "$env:Path;$path_to_hats\RED"

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
