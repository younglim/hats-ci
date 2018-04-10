# Set current path
$current_path = (Get-Item -Path ".\" -Verbose).FullName

echo "INFO: Stored current working directory at $current_path"

# INFO: Set path to hats
$path_to_hats  = split-path -parent $MyInvocation.MyCommand.Definition

$path_to_origPrefix = "$path_to_hats\hats\Lib\orig-prefix.txt";
$origPrefixContent = [IO.File]::ReadAllText($path_to_origPrefix)
$pythonDir = "$path_to_hats\Python27".ToLower();

If (!$pythonDir.equals($origPrefixContent)) {
	echo "Overwrite 'hats\Lib\orig-prefix.txt' with directory to Python"

	[System.IO.File]::WriteAllText($path_to_origPrefix,$pythonDir,[System.Text.Encoding]::ASCII)
}

$env:Path = "$env:windir;$env:windir\system32;$env:windir\system32\WindowsPowerShell\v1.0"

echo "INFO: Set path to Python27"
$env:Path = "$env:Path;$path_to_hats\Python27;$path_to_hats\Python27\Scripts";

if ([System.IntPtr]::Size -eq 4)
{
	echo "INFO: Set path to JDK32 for this session"
	$env:JAVA_HOME = "$path_to_hats\jdk32"
	$env:Path = "$env:Path;$env:JAVA_HOME\bin";
}
else
{
	echo "INFO: Set path to JDK for this session"
	$env:JAVA_HOME = "$path_to_hats\jdk"
	$env:Path = "$env:Path;$env:JAVA_HOME\bin";
}

echo "INFO: Set path to browser drivers for this session"

. $path_to_hats\utils\Get-ExeTargetMachine.ps1

$ie_path = "C:\Program Files\Internet Explorer\iexplore.exe"

if (Test-Path env:ie_path) {
	$ie_path = $env:ie_path
}

if (Test-Path $ie_path) 
{
	$ie_version = (Get-Item $ie_path).VersionInfo.FileVersion
	
	if ((Get-ExeTargetMachine $ie_path).TargetMachine -eq "x64")
	{
		echo "INFO: Found 64-bit Microsoft Internet Explorer Version $ie_version"
		# Fallback to 32-bit IE driver for now to workaround slow page typing
		# $env:Path = "$env:Path;$path_to_hats\drivers\ie64";
		$env:Path = "$env:Path;$path_to_hats\drivers\ie32";
	}
	else
	{
		echo "INFO: Found 32-bit Microsoft Internet Explorer Version $ie_version"
		$env:Path = "$env:Path;$path_to_hats\drivers\ie32";
	}
	
}
else 
{
	echo "WARN: Could not detect Microsoft internet Explorer"
	$env:Path = "$env:Path;$path_to_hats\drivers\ie64";
}

$env:Path = "$env:Path;$path_to_hats\drivers\ie";

$path_to_programfiles_x86 = "C:\Program Files (x86)"

$chrome_path = "$path_to_programfiles_x86\Google\Chrome\Application\chrome.exe";

if (-Not (Test-Path $chrome_path))
{
	$chrome_path = "C:\Program Files\Google\Chrome\Application\chrome.exe"
}

if (Test-Path env:chrome_path) {
	$chrome_path = $env:chrome_path
}

if (Test-Path $chrome_path) 
{
	$chrome_version = (Get-Item $chrome_path).VersionInfo.FileVersion

	if ($chrome_version -eq $null)
	{
		echo "WARN: Could not detect Google Chrome"
	}
	else
	{
		echo "INFO: Found Google Chrome Version $chrome_version"
		if ($chrome_version -match "5[6-8].*") 
		{
			echo "INFO: Support for Chrome v58 enabled"
			$env:Path = "$env:Path;$path_to_hats\drivers\chrome-58";
		}
		elseif ($chrome_version -match "(59|6[0-3]).*") 
		{
			echo "INFO: Support for Chrome v59-63 enabled"
			$env:Path = "$env:Path;$path_to_hats\drivers\chrome-63";
		}
		else {
			$env:Path = "$env:Path;$path_to_hats\drivers\chrome";
		}
	}
	
}
else
{
	echo "WARN: Could not detect Google Chrome"
	$env:Path = "$env:Path;$path_to_hats\drivers\chrome";
}


$firefox_path = "$path_to_programfiles_x86\Mozilla Firefox\firefox.exe";

if (-Not (Test-Path $firefox_path))
{
	$firefox_path = "C:\Program Files\Mozilla Firefox\firefox.exe"
}

if (Test-Path env:firefox_path) {
	$firefox_path = $env:firefox_path
}

if (Test-Path $firefox_path)
{	
	$firefox_version = (Get-Item $firefox_path).VersionInfo.FileVersion

	if ((Get-ExeTargetMachine $firefox_path).TargetMachine -eq "x64")
	{
		echo "INFO: Found 64-bit Mozilla Firefox Version $firefox_version"
		
		if ($firefox_version -match "[0-5][0-4].*") 
		{
			echo "INFO: Support for Mozilla Firefox <= v54 enabled"
			$env:Path = "$env:Path;$path_to_hats\drivers\firefox64-firefox-54";
		}
		else
		{
			$env:Path = "$env:Path;$path_to_hats\drivers\firefox64";
		}
		
	} 
	else 
	{
		if ($firefox_version -match "[0-5][0-4].*") 
		{
			echo "INFO: Support for Mozilla Firefox <= v54 enabled"
			$env:Path = "$env:Path;$path_to_hats\drivers\firefox32-firefox-54";
		}
		else
		{
			echo "INFO: Found 32-bit Mozilla Firefox Version $firefox_version"
			$env:Path = "$env:Path;$path_to_hats\drivers\firefox32";
		}
	}

}
else
{
	echo "WARN: Could not detect Mozilla Firefox"
	$env:Path = "$env:Path;$path_to_hats\drivers\firefox64";
}

$env:ie_version = $ie_version;
$env:chrome_version = $chrome_version;
$env:firefox_version = $firefox_version;

echo "INFO: Set path to utils for this session"
$env:Path = "$env:Path;$path_to_hats\utils";

echo "INFO: Set path to node for this session"
$env:Path = "$env:Path;$path_to_hats\nodejs";

echo "INFO: Set path to node_modules for this session"
$env:Path = "$env:Path;$path_to_hats\node_modules\.bin;./node_modules/.bin";

echo "INFO: Set path to npm-global for this session"
$env:Path = "$env:Path;$path_to_hats\npm-global;$path_to_hats\npm-global\bin";

echo "INFO: Set path to androidSDK tools for this session"
$env:Path = "$env:Path;$path_to_hats\androidSDK\emulator;$path_to_hats\androidSDK\tools;$path_to_hats\androidSDK\tools\bin\;$path_to_hats\androidSDK\platform-tools";

$env:ANDROID_HOME = "$path_to_hats\androidSDK"
$env:ANDROID_SDK_HOME = "$path_to_hats\androidSDK"
$env:ANDROID_SDK_ROOT = "$path_to_hats\androidSDK"

echo "INFO: Set path to Git for this session"
$env:Path = "$env:Path;$path_to_hats\Git\cmd;$path_to_hats\Git\mingw32\bin;$path_to_hats\Git\usr\bin"

echo "INFO: Set path to Gatling for this session"
$env:Path = "$env:Path;$path_to_hats\Gatling\bin"
$env:GATLING_HOME = "$path_to_hats\Gatling"

echo "INFO: Set path to JMeter for this session"
$env:Path = "$env:Path;$path_to_hats\JMeter\bin"

echo "INFO: Set path to RED for this session"
$env:Path = "$env:Path;$path_to_hats\RED"

echo "INFO: Activate hats virtual environment"
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
	echo "Run 'commands' to get a list of useful commands."
	echo ""
}
