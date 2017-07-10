# Set path to hats
$path_to_hats = "$env:PROGRAMFILES\hats"

echo "Create robot folder in $path_to_hats"
If(!(test-path $path_to_hats))
{
	New-Item -ItemType Directory -Force -Path "$env:PROGRAMFILES\hats"
}

echo "Downloading Microsoft Visual C++ Compiler for Python 2.7"
$client = new-object System.Net.WebClient;
$client.DownloadFile("http://download.microsoft.com/download/7/9/6/796EF2E4-801B-4FC4-AB28-B59FBF6D907B/VCForPython27.msi","$path_to_hats\VCForPython27.msi");

echo "Installing Microsoft Visual C++ Compiler for Python 2.7"
Start-Process msiexec.exe -ArgumentList "/i `"$path_to_hats\VCForPython27.msi`" /qn" -NoNewWindow -Wait;

echo "Downloading Python 2.7"
$client.DownloadFile("https://www.python.org/ftp/python/2.7.13/python-2.7.13.msi","$path_to_hats\python27.msi");

echo "Installing Python 2.7"
Start-Process msiexec.exe -ArgumentList "/a `"$path_to_hats\python27.msi`" /qn TargetDir=`"$path_to_hats\Python27`" PrependPath=0 Include_test=0 DefaultFeature=1" -NoNewWindow -Wait;

echo "Completed installing Python 2.7"

echo "Set path to Python for this session"
$env:Path = "$env:Path:$path_to_hats\Python27;$path_to_hats\Python27\Scripts";

echo "Installing pip"
$client.DownloadFile("https://bootstrap.pypa.io/get-pip.py","$path_to_hats\get-pip.py");
cd $path_to_hats
python get-pip.py

echo "Install VirtualEnv"
pip install virtualenv

echo "Create and Activate VirtualEnv robot"
virtualenv robot 
& robot\Scripts\activate

echo "Install pip modules"
$client.DownloadFile("https://raw.githubusercontent.com/GovTechSG/hats-installer/master/src/lib/install-lists/pip-install-list.txt","$path_to_hats\pip-install-list.txt");

pip install -r .\pip-install-list.txt
pip install functools
virtualenv --relocatable robot 
