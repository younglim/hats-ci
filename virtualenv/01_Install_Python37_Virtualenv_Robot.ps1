# Set path to hats
$path_to_hats = "$env:PROGRAMFILES\hats"

echo "Create robot folder in $path_to_hats"
If(!(test-path $path_to_hats))
{
	New-Item -ItemType Directory -Force -Path "$env:PROGRAMFILES\hats"
}

. .\Get-IniContent.ps1
$iniContent = Get-IniContent "config.ini"
 
echo "Set webclient connection to TLS/1.2"
[System.Net.ServicePointManager]::SecurityProtocol =  [Enum]::ToObject([Net.SecurityProtocolType], 3072);

echo "Downloading Microsoft Visual C++ Compiler for Python 3.7"
$client = new-object System.Net.WebClient;
$client.DownloadFile($iniContent["Misc"]["VCForPython37"],"$path_to_hats\VCForPython37.exe");

echo "Installing Microsoft Visual C++ Compiler for Python 3.7"
#Start-Process msiexec.exe -ArgumentList "/i `"$path_to_hats\VCForPython27.msi`" /qn" -NoNewWindow -Wait;
Start-Process -FilePath "$path_to_hats\VCForPython37.exe" -ArgumentList "/S /v/qn" -NoNewWindow -Wait;

$env:Path = "$path_to_hats\Python37;$path_to_hats\Python37\Scripts";
echo $env:Path

echo "Downloading Python 3.7"

if ([System.IntPtr]::Size -eq 4)
{
	echo "Your system is 32-bit - Downloading..."
	$client.DownloadFile($iniContent["Python"]["Python37-32"],"$path_to_hats\python37.exe");

}
else
{
	echo "Your system is 64-bit - Downloading..."
	$client.DownloadFile($iniContent["Python"]["Python37-64"],"$path_to_hats\python37.exe");

}

echo "Installing Python 3.7"
#Start-Process msiexec.exe -ArgumentList "/a `"$path_to_hats\python27.msi`" /qn TargetDir=`"$path_to_hats\Python27`" PrependPath=0 Include_test=0 DefaultFeature=1" -NoNewWindow -Wait;
Start-Process -FilePath "$path_to_hats\python37.exe" -ArgumentList "/S /v/qn TargetDir=`"$path_to_hats\Python37`" PrependPath=0 Include_test=0 DefaultFeature=1" -NoNewWindow -Wait;


echo "Completed installing Python 3.7"

echo "Set path to Python for this session"
$env:Path = "$env:windir;$env:windir\system32;"
$env:Path = "$path_to_hats\Python37;$path_to_hats\Python37\Scripts";

echo "Installing pip"
$client.DownloadFile("https://bootstrap.pypa.io/get-pip.py","$path_to_hats\get-pip.py");
cd $path_to_hats
python get-pip.py

echo "Install VirtualEnv"
pip install virtualenv

echo "Create and Activate VirtualEnv robot"
virtualenv hats
& hats\Scripts\activate

echo "Install pip modules"

New-Item -ItemType Directory -Force -Path "$path_to_hats\utils"
$url = $iniContent["hats"]["RobotPipInstallList"]
$url > "$path_to_hats\utils\pip-install-list.url"
$client.DownloadFile($url,"$path_to_hats\utils\pip-install-list.txt");

pip install -r .\utils\pip-install-list.txt
virtualenv --relocatable hats
