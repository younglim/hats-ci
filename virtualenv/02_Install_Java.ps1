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

echo "Your system is 32-bit - Downloading..."
$client.DownloadFile($iniContent["Java"]["JRE-32"],"$path_to_hats\jre32.exe");

echo "Downloaded JRE 8"

echo "Downloading 7-Zip"
$client.DownloadFile($iniContent["7-Zip"]["7-Zip"],"$path_to_hats\7z.msi");

echo "Installing 7-Zip"
Start-Process msiexec.exe -ArgumentList "/a `"$path_to_hats\7z.msi`" /qn TargetDir=`"$path_to_hats\7-Zip`" PrependPath=0 Include_test=0 DefaultFeature=1" -NoNewWindow -Wait;

echo "Unzipping JRE 8"
Start-Process -FilePath "$path_to_hats\7-Zip\Files\7-Zip\7z.exe" -ArgumentList 'x', '"jre32.exe"', '-o"jre32"', '-aoa' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats"

echo "Completed unzipping JRE 8"

# echo "Set path to JRE for this session"
# $env:Path = "$env:Path;$path_to_hats\jre32\bin;$path_to_hats\jre32\lib"
# echo $env:Path
