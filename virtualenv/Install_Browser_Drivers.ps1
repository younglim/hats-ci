# Set path to hats
$path_to_hats = "$env:APPDATA\hats"

echo "Create drivers folder in $path_to_hats"
If(!(test-path $path_to_hats))
{
	New-Item -ItemType Directory -Force -Path $path_to_hats
}

If(!(test-path "$path_to_hats\drivers"))
{
	New-Item -ItemType Directory -Force -Path "$path_to_hats\drivers"
}

echo "Download Chrome driver"
$client = new-object System.Net.WebClient;
$cookie = "oraclelicense=accept-securebackup-cookie"
$client.DownloadFile("https://chromedriver.storage.googleapis.com/2.29/chromedriver_win32.zip","$path_to_hats\chromedriver.zip");

echo "Download IE driver"
$client.DownloadFile("http://selenium-release.storage.googleapis.com/3.4/IEDriverServer_Win32_3.4.0.zip","$path_to_hats\IEDriverServer.zip");

echo "Download Firefox driver"
$client.DownloadFile("https://github.com/mozilla/geckodriver/releases/download/v0.16.1/geckodriver-v0.16.1-win32.zip","$path_to_hats\geckodriver.zip");

echo "Unzipping Chrome driver"
Start-Process -FilePath "$path_to_hats\7-Zip\Files\7-Zip\7z.exe" -ArgumentList 'e', '"chromedriver.zip"', '-o"drivers"', '-aoa' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats"

echo "Unzipping IE driver"
Start-Process -FilePath "$path_to_hats\7-Zip\Files\7-Zip\7z.exe" -ArgumentList 'e', '"IEDriverServer.zip"', '-o"drivers"', '-aoa' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats"

echo "Unzipping Firefox driver"
Start-Process -FilePath "$path_to_hats\7-Zip\Files\7-Zip\7z.exe" -ArgumentList 'e', '"geckodriver.zip"', '-o"drivers"', '-aoa' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats"
