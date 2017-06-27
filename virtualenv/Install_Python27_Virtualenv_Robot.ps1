# Set path to hats
$path_to_hats = "$env:APPDATA\hats"

echo "Create robot folder in $path_to_hats"
If(!(test-path $path_to_hats))
{
	New-Item -ItemType Directory -Force -Path $path_to_hats
}

echo "Downloading Python 2.7"
$client = new-object System.Net.WebClient;
$client.DownloadFile("https://www.python.org/ftp/python/2.7.13/python-2.7.13.msi","$path_to_hats\python27.msi");

echo "Installing Python 2.7"
Start-Process msiexec.exe -ArgumentList "/a $path_to_hats\python27.msi /qn TargetDir=$path_to_hats\Python27 PrependPath=0 Include_test=0 DefaultFeature=1" -NoNewWindow -Wait;

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
virtualenv --no-site-packages robot 
& robot\Scripts\activate

echo "Install pip modules"
$client.DownloadFile("https://raw.githubusercontent.com/GovTechSG/hats-installer/master/src/lib/install-lists/pip-install-list.txt","$path_to_hats\pip-install-list.txt");

pip install -r .\pip-install-list.txt
