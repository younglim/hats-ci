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

echo "Preparing to download JDK32"
$client.DownloadFile($iniContent["Java"]["JDK-32"],"$path_to_hats\jdk32.exe");
echo "Downloaded JDK"

echo "Unzipping JDK - first step"
Start-Process -FilePath "$path_to_hats\7-Zip\Files\7-Zip\7z.exe" -ArgumentList 'x', '"jdk32.exe"', '-o"jdk32-first-extraction"', '-aoa' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats"

echo "Unzipping JDK - final step"
Start-Process -FilePath "$path_to_hats\7-Zip\Files\7-Zip\7z.exe" -ArgumentList 'x', '"jdk32-first-extraction\tools.zip"', '-o"jdk32"', '-aoa' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats"

echo "Unpack jre/lib .pack files to .jar"
$files = Get-ChildItem -Path "$path_to_hats\jdk32\jre\lib" -Recurse -Include *.pack;
$libFilePath = "$path_to_hats\jdk32\jre\lib";

foreach($file in $files) {
	$fileJarName = $null;
	$fileOrgName = "$($libFilePath)\$($file.name)";
	$fileJarName = "$($libFilePath)\$($file.BaseName).jar"
	. "$path_to_hats\jdk32\bin\unpack200.exe" "$fileOrgName" "$fileJarName"
}

. "$path_to_hats\jdk32\bin\unpack200.exe" "$($libFilePath)\ext\localedata.pack" "$($libFilePath)\ext\localedata.jar"

dir "$path_to_hats\jdk32\jre\lib"
echo "Completed unpacking .pack files to jar"

echo "Preparing to download JDK64"
$client.DownloadFile($iniContent["Java"]["JDK-64"],"$path_to_hats\jdk.exe");

echo "Downloaded JDK"

echo "Unzipping JDK - first step"
Start-Process -FilePath "$path_to_hats\7-Zip\Files\7-Zip\7z.exe" -ArgumentList 'x', '"jdk.exe"', '-o"jdk-first-extraction"', '-aoa' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats"

echo "Unzipping JDK - second step"
Start-Process -FilePath "$path_to_hats\7-Zip\Files\7-Zip\7z.exe" -ArgumentList 'x', '"jdk-first-extraction\.rsrc\1033\JAVA_CAB10\111"', '-o"jdk-second-extraction"', '-aoa' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats"

echo "Unzipping JDK - final step"
Start-Process -FilePath "$path_to_hats\7-Zip\Files\7-Zip\7z.exe" -ArgumentList 'x', '"jdk-second-extraction\tools.zip"', '-o"jdk"', '-aoa' -NoNewWindow -Wait -WorkingDirectory "$path_to_hats"

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
