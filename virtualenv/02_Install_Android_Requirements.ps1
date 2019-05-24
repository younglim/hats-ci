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

echo "Set path to JDK for this session"

if ([System.IntPtr]::Size -eq 4)
{
	$env:JAVA_HOME = "$path_to_hats\jdk32"
}
else 
{
	$env:JAVA_HOME = "$path_to_hats\jdk"
}
echo $env:JAVA_HOME
$env:Path = "$env:Path;$env:JAVA_HOME\bin"

echo "Preparing to download Android SDK"
$client.DownloadFile($iniContent["AndroidSDK"]["AndroidSDK"],"$path_to_hats\androidSDK.zip");

echo "Downloaded Android SDK"

echo "Unzipping Android SDK"
Start-Process -FilePath "$path_to_hats\7-Zip\Files\7-Zip\7z.exe" -ArgumentList 'x', '"androidSDK.zip"', '-o"androidSDK"','-aoa' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats"

echo "Set PATH, ANDROID_SDK_ROOT, ANDROID_SDK_HOME for androidSDK"
$env:Path = "$env:Path;$path_to_hats\androidSDK\tools;$path_to_hats\androidSDK\tools\bin\;$path_to_hats\androidSDK\platform-tools";
$env:ANDROID_SDK_ROOT ="$path_to_hats\androidSDK";
$env:ANDROID_SDK_HOME ="$path_to_hats\androidSDK";

echo "Testing android list command"
android list

echo "Testing avdmanager command"
avdmanager

cd "$path_to_hats"

echo "Accept license agreement for Android SDK"
for($i=0;$i -lt 30;$i++) { $response += "y`n"}; $response | sdkmanager --licenses

echo "Download platform-tools using sdkmanager"
echo "y" | sdkmanager "platform-tools" --sdk_root="androidSDK"
cd "$scriptpath"

echo 'Testing adb command'
adb

echo $null >> "$path_to_hats\androidSDK\.android\repositories.cfg"

echo "Install android emulator"
sdkmanager "emulator"

echo "Create platforms directory in androidSDK"
New-Item -ItemType Directory -Force -Path "$path_to_hats\androidSDK\platforms"

echo "Install sdkmanager system-images, build-tools, platform-tools"
sdkmanager 'system-images;android-28;google_apis;x86' 'build-tools;28.0.2' 'platform-tools' 'platforms;android-28'

echo "Create AVDPBIG with Chrome"
# echo no | avdmanager create avd -n testAVD -k 'system-images;android-27;google_apis;x86' -g 'google_apis'
# avdmanager create avd --package 'system-images;android-28;google_apis_playstore;x86_64' --name AVDPBIG --device 'pixel_xl'
avdmanager create avd --package 'system-images;android-28;google_apis;x86'  --name AVDPBIG --device 'pixel_xl'
Add-Content "$path_to_hats\androidSDK\.android\avd\AVDPBIG.avd\config.ini" "hw.keyboard=yes"

echo "Download Intel HAXM"
$client.DownloadFile($iniContent["Intel"]["HAXM"],"$path_to_hats\haxm.zip");
Start-Process -FilePath "$path_to_hats\7-Zip\Files\7-Zip\7z.exe" -ArgumentList 'x', '"haxm.zip"','-o"androidSDK\haxm"','-aoa' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats"

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

# echo "Run emulator testavd"
# emulator -avd testAVD

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


echo "Download Visual C++ Build Tools"
$client.DownloadFile($iniContent["Microsoft"]["Windows-Build-Tools"],"$path_to_hats\utils\visualcppbuildtools_full.exe");

echo "Unpack Visual C++ Build Tools"
New-Item -ItemType Directory -Force -Path "$path_to_hats\utils\visualcppbuildtools"

Start-Process "$path_to_hats\utils\visualcppbuildtools_full.exe" -ArgumentList '/Layout "visualcppbuildtools"','/Passive' -NoNewWindow -Wait  -WorkingDirectory "$path_to_hats\utils";

echo "Install Visual C++ Build Tools"
Start-Process "$path_to_hats\utils\visualcppbuildtools\VisualCppBuildTools_Full.exe" -ArgumentList "/Full /Passive" -NoNewWindow -Wait;

echo "Installing Appium through npm"
# npm --vcc-build-tools-parameters='[""/CustomInstallPath"", ""$path_to_hats\MSBUILD""]' install -g -production windows-build-tools 

$env:Path = "$env:Path;$path_to_hats\Python37;$path_to_hats\Python37\Scripts";
npm install -g appium@1.12.0
npm install -g phantomjs

npm config set msvs_version 2015

echo "Pop and check location"
Pop-Location
Get-Location

