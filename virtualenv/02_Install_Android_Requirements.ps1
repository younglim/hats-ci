# Set path to hats
$path_to_hats = "$env:PROGRAMFILES\hats"
$scriptpath = Split-Path $MyInvocation.MyCommand.Path

. .\Get-IniContent.ps1
$iniContent = Get-IniContent "config.ini"
$client = new-object System.Net.WebClient;

echo "Downloading 7-Zip"
$client.DownloadFile($iniContent["7-Zip"]["7-Zip"],"$path_to_hats\7z.msi");

echo "Installing 7-Zip"
Start-Process msiexec.exe -ArgumentList "/a `"$path_to_hats\7z.msi`" /qn TargetDir=`"$path_to_hats\7-Zip`" PrependPath=0 Include_test=0 DefaultFeature=1" -NoNewWindow -Wait;

echo "Preparing to download JDK"
if ([System.IntPtr]::Size -eq 4)
{
	echo "Your system is 32-bit - Downloading..."
	$client.DownloadFile($iniContent["Java"]["JDK-32"],"$path_to_hats\jdk.exe");
	echo "Downloaded JDK"

	echo "Unzipping JDK - first step"
	Start-Process -FilePath "$path_to_hats\7-Zip\Files\7-Zip\7z.exe" -ArgumentList 'x', '"jdk.exe"', '-o"jdk-first-extraction"', '-aoa' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats"

	echo "Unzipping JDK - final step"
	Start-Process -FilePath "$path_to_hats\7-Zip\Files\7-Zip\7z.exe" -ArgumentList 'x', '"jdk-first-extraction\tools.zip"', '-o"jdk"', '-aoa' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats"

}
else
{
	echo "Your system is 64-bit - Downloading..."
	$client.DownloadFile($iniContent["Java"]["JDK-64"],"$path_to_hats\jdk.exe");

	echo "Downloaded JDK"

	echo "Unzipping JDK - first step"
	Start-Process -FilePath "$path_to_hats\7-Zip\Files\7-Zip\7z.exe" -ArgumentList 'x', '"jdk.exe"', '-o"jdk-first-extraction"', '-aoa' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats"

	echo "Unzipping JDK - second step"
	Start-Process -FilePath "$path_to_hats\7-Zip\Files\7-Zip\7z.exe" -ArgumentList 'x', '"jdk-first-extraction\.rsrc\1033\JAVA_CAB10\111"', '-o"jdk-second-extraction"', '-aoa' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats"
	
	echo "Unzipping JDK - final step"
Start-Process -FilePath "$path_to_hats\7-Zip\Files\7-Zip\7z.exe" -ArgumentList 'x', '"jdk-second-extraction\tools.zip"', '-o"jdk"', '-aoa' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats"

}

echo "Set path to JDK for this session"
$env:JAVA_HOME = "$path_to_hats\jdk"
echo $env:JAVA_HOME
$env:Path = "$env:Path;$env:JAVA_HOME\bin"

echo "Unpack jre/lib .pack files to .jar"
$files = Get-ChildItem -Path "$path_to_hats\jdk\jre\lib" -Recurse -Include *.pack;
$libFilePath = "$path_to_hats\jdk\jre\lib";

foreach($file in $files) {
	$fileJarName = $null;
	$fileOrgName = "$($libFilePath)\$($file.name)";
	$fileJarName = "$($libFilePath)\$($file.BaseName).jar"
	. "$path_to_hats\jdk\bin\unpack200.exe" "$fileOrgName" "$fileJarName"
}

. "$path_to_hats\jdk\bin\unpack200.exe" "$($libFilePath)\ext\localedata.pack" "$($libFilePath)\ext\localedata.jar"

dir "$path_to_hats\jdk\jre\lib"
echo "Completed unpacking .pack files to jar"

echo "Preparing to download Android SDK"
$client.DownloadFile($iniContent["AndroidSDK"]["AndroidSDK"],"$path_to_hats\androidSDK.zip");

echo "Downloaded Android SDK"

echo "Unzipping Android SDK"
Start-Process -FilePath "$path_to_hats\7-Zip\Files\7-Zip\7z.exe" -ArgumentList 'x', '"androidSDK.zip"', 'tools', '-aoa' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats"
Rename-Item "$path_to_hats\tools" androidSDK

echo "Set path to androidSDK tools for this session"
$env:Path = "$env:Path;$path_to_hats\androidSDK;$path_to_hats\androidSDK\bin";

echo "Testing android list command"
android list
echo "Testing avdmanager command"
avdmanager
echo "Download platform-tools using sdkmanager"
cd "$path_to_hats"
pwd
echo "y" | sdkmanager "platform-tools" --sdk_root="androidSDK"
cd "$scriptpath"
$env:Path = "$env:Path;$path_to_hats\androidSDK\platform-tools";
echo "Add platform-tools to path"
echo 'Testing adb command'
adb

echo "Preparing to download Node"
if ([System.IntPtr]::Size -eq 4)
{
	echo "Your system is 32-bit - Downloading..."
	$client.DownloadFile($iniContent["Node"]["Node-32"],"$path_to_hats\node.zip");
}
else
{
	echo "Your system is 64-bit - Downloading..."
	$client.DownloadFile($iniContent["Node"]["Node-64"],"$path_to_hats\node.zip");
}

echo "Downloaded Node"

echo "Unzipping Node"
Start-Process -FilePath "$path_to_hats\7-Zip\Files\7-Zip\7z.exe" -ArgumentList 'x', '"node.zip"', '-aoa' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats"

cd "$path_to_hats"
Get-ChildItem node-v* | Rename-Item -NewName nodejs
cd "$scriptpath"

echo "Set path to nodejs and node_modules for this session"
$env:Path = "$env:Path;$path_to_hats\nodejs";
$env:Path = "$env:Path;$path_to_hats\node_modules\.bin";

echo "Push and set location to hats path"
Push-Location
Set-Location $path_to_hats

echo "Initializing npm"
Get-Location

If(!(test-path "$path_to_hats\npm-global"))
{
	New-Item -ItemType Directory -Force -Path "$path_to_hats\npm-global"
}

npm config set prefix $path_to_hats\npm-global
$env:Path = "$env:Path;$path_to_hats\npm-global;$path_to_hats\npm-global\bin";
npm init -y

echo "Download package.json"
$client.DownloadFile($iniContent["hats"]["NpmPackageJson"],"$path_to_hats\package.json");

echo "Install Windows Build Tools"
$client.DownloadFile($iniContent["Microsoft"]["Windows-Build-Tools"],"$path_to_hats\utils\BuildTools_Full.exe");
Start-Process "$path_to_hats\utils\BuildTools_Full.exe" -ArgumentList "/Full /Silent" -NoNewWindow -Wait;

echo "Installing Appium through npm"
# npm --vcc-build-tools-parameters='[""/CustomInstallPath"", ""$path_to_hats\MSBUILD""]' install -g -production windows-build-tools 

$env:Path = "$env:Path;C:\Program Files\MSBuild\14.0\Bin;$path_to_hats\Python27;$path_to_hats\Python27\Scripts";
npm install -g appium
pip install appium-python-client
npm config set msvs_version 2015

echo "Pop and check location"
Pop-Location
Get-Location
