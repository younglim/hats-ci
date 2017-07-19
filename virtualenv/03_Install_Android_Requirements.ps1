# Set path to hats
$path_to_hats = "$env:PROGRAMFILES\hats"

. .\Get-IniContent.ps1
$iniContent = Get-IniContent "config.ini"
$client = new-object System.Net.WebClient;

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
#npm init -y

echo "Download package.json"
$client.DownloadFile($iniContent["hats"]["NpmPackageJson"],"$path_to_hats\package.json");

echo "Installing Appian and Windows Build Tools through npm"
npm install
npm config set msvs_version 2015
$env:Path = "$env:Path;${env:ProgramFiles(x86)}\MSBUILD";

echo "Pop and check location"
Pop-Location
Get-Location
