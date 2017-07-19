# Set path to hats
$path_to_hats = "$env:PROGRAMFILES\hats"

echo "Create JRE folder in $path_to_hats"
If(!(test-path $path_to_hats))
{
	New-Item -ItemType Directory -Force -Path "$path_to_hats"
}

. .\Get-IniContent.ps1
$iniContent = Get-IniContent "config.ini"

echo "Preparing to download JRE 8"
$client = new-object System.Net.WebClient;
$cookie = "oraclelicense=accept-securebackup-cookie"
$client.Headers.Add([System.Net.HttpRequestHeader]::Cookie, $cookie)

if ([System.IntPtr]::Size -eq 4)
{
	echo "Your system is 32-bit - Downloading..."
	$client.DownloadFile($iniContent["Java"]["JRE-32"],"$path_to_hats\jre.exe");
}
else
{
	echo "Your system is 64-bit - Downloading..."
	$client.DownloadFile($iniContent["Java"]["JRE-64"],"$path_to_hats\jre.exe");

}

echo "Downloaded JRE 8"

echo "Downloading 7-Zip"
$client.DownloadFile($iniContent["7-Zip"]["7-Zip"],"$path_to_hats\7z.msi");

echo "Installing 7-Zip"
Start-Process msiexec.exe -ArgumentList "/a `"$path_to_hats\7z.msi`" /qn TargetDir=`"$path_to_hats\7-Zip`" PrependPath=0 Include_test=0 DefaultFeature=1" -NoNewWindow -Wait;

echo "Unzipping JRE 8"
Start-Process -FilePath "$path_to_hats\7-Zip\Files\7-Zip\7z.exe" -ArgumentList 'x', '"jre.exe"', '-o"jre"', '-aoa' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats"

echo "Completed unzipping JRE 8"

echo "Set path to JRE for this session"
$env:Path = "$env:Path;$path_to_hats\jre\bin;$path_to_hats\jre\lib"
echo $env:Path

echo "Preparing to download Node"
if ([System.IntPtr]::Size -eq 4)
{
	echo "Your system is 32-bit - Downloading..."
	$client.DownloadFile($iniContent["Node"]["Node-32"],"$path_to_hats\node.zip");
	$nodeFolderName = "node-v6.11.1-win-x86"
}
else
{
	echo "Your system is 64-bit - Downloading..."
	$client.DownloadFile($iniContent["Node"]["Node-64"],"$path_to_hats\node.zip");
	$nodeFolderName = "node-v6.11.1-win-x64"
}

echo "Downloaded Node"

echo "Unzipping Node"
# Start-Process msiexec.exe -ArgumentList "/a `"$path_to_hats\node.msi`" /qn TargetDir=`"$path_to_hats\nodejs`" " -NoNewWindow -Wait;
Start-Process -FilePath "$path_to_hats\7-Zip\Files\7-Zip\7z.exe" -ArgumentList 'x', '"node.zip"', 'node-v6.11.1-win-x64', '-aoa' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats"
Rename-Item "$path_to_hats\$nodeFolderName" nodejs

echo "Set path to nodejs and node_modules for this session"
$env:Path = "$env:Path;$path_to_hats\nodejs";
$env:Path = "$env:Path;$path_to_hats\node_modules\.bin";

echo "Push and set location to hats path"
Push-Location
Set-Location $path_to_hats

echo "Initializing npm"
Get-Location
npm init -y

echo "Installing Windows Build Tools through npm"
npm install --global --production --save windows-build-tools
npm config set msvs_version 2015
$env:Path = "$env:Path;${env:ProgramFiles(x86)}\MSBUILD";
#$client.DownloadFile($iniContent["MS-BuildTools"]["MSBUILD"],"$path_to_hats\msbuild.exe");
#echo "Unzipping MS Build Tools"
#node-gyp configure --msvs_version=2015 --loglevel=verbose
#Start-Process "$path_to_hats\msbuild.exe" -ArgumentList '/S', '/Q' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats"

echo "Installing Appium through npm"
npm install --save appium@1.6.6-beta

echo "Pop and check location"
Pop-Location
Get-Location
