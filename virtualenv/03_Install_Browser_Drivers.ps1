# Set path to hats
$path_to_hats = "$env:PROGRAMFILES\hats"

echo "Create drivers folder in $path_to_hats"
If(!(test-path $path_to_hats))
{
	New-Item -ItemType Directory -Force -Path "$path_to_hats"
}

If(!(test-path "$path_to_hats\drivers"))
{
	New-Item -ItemType Directory -Force -Path "$path_to_hats\drivers"
}

. .\Get-IniContent.ps1

$iniContent = Get-IniContent "config.ini"

echo "Download Chrome driver"
$client = new-object System.Net.WebClient;
$cookie = "oraclelicense=accept-securebackup-cookie"
$client.DownloadFile($iniContent["BrowserDrivers"]["Chrome"],"$path_to_hats\chromedriver.zip");

echo "Download IE driver"
$client.DownloadFile($iniContent["BrowserDrivers"]["IE"],"$path_to_hats\IEDriverServer.zip");

echo "Download Firefox driver"
$client.DownloadFile($iniContent["BrowserDrivers"]["Firefox"],"$path_to_hats\geckodriver.zip");

echo "Unzipping Chrome driver"
Start-Process -FilePath "$path_to_hats\7-Zip\Files\7-Zip\7z.exe" -ArgumentList 'e', '"chromedriver.zip"', '-o"drivers"', '-aoa' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats"

echo "Unzipping IE driver"
Start-Process -FilePath "$path_to_hats\7-Zip\Files\7-Zip\7z.exe" -ArgumentList 'e', '"IEDriverServer.zip"', '-o"drivers"', '-aoa' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats"

echo "Unzipping Firefox driver"
Start-Process -FilePath "$path_to_hats\7-Zip\Files\7-Zip\7z.exe" -ArgumentList 'e', '"geckodriver.zip"', '-o"drivers"', '-aoa' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats"
