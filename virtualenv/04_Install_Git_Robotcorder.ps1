# Set path to hats
$path_to_hats = "$env:PROGRAMFILES\hats"

echo "Create drivers folder in $path_to_hats"
If(!(test-path $path_to_hats))
{
	New-Item -ItemType Directory -Force -Path "$path_to_hats"
}

If(!(test-path "$path_to_hats\drivers"))
{
	New-Item -ItemType Directory -Force -Path "$path_to_hats\Git"
}

. .\Get-IniContent.ps1

$iniContent = Get-IniContent "config.ini"

echo "Download Git"
$client = new-object System.Net.WebClient;
$cookie = "oraclelicense=accept-securebackup-cookie"
$client.DownloadFile($iniContent["Git"]["Git"],"$path_to_hats\PortableGit.exe");

echo "Unzipping Git"
Start-Process -FilePath "$path_to_hats\7-Zip\Files\7-Zip\7z.exe" -ArgumentList 'x', '"PortableGit.exe"', '-o"Git"', '-aoa' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats"

echo "Download Robotcorder"
$client = new-object System.Net.WebClient;
$cookie = "oraclelicense=accept-securebackup-cookie"
$client.DownloadFile($iniContent["hats"]["Robotcorder"],"$path_to_hats\drivers\Robotcorder.crx");

echo "Unzipping Robotcorder"
Start-Process -FilePath "$path_to_hats\7-Zip\Files\7-Zip\7z.exe" -ArgumentList 'x', '"drivers\Robotcorder.crx"', '-o"Git"', '-aoa' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats\Robotcorder"
