echo "Downloading Python 2.7"
$client = new-object System.Net.WebClient;
$client.DownloadFile("https://www.python.org/ftp/python/2.7.13/python-2.7.13.msi","$env:TEMP\python27.msi");

echo "Installing Python 2.7"
Start-Process msiexec.exe -ArgumentList "/i $env:TEMP\python27.msi /qn" -NoNewWindow -Wait;

echo "Completed installing Python 2.7"

echo "Install VirtualEnv"
pip install virtualenv

echo "Create robot folder in %APPDATA%"
$path_to_robot = "$env:APPDATA\robot"

If(!(test-path $path_to_robot))
{
	New-Item -ItemType Directory -Force -Path $path_to_robot
}


echo "Create and Activate VirtualEnv robot"
cd $path_to_robot
virtualenv --no-site-packages robot 
& robot\Scripts\activate

echo "Install pip modules"
$client.DownloadFile("https://raw.githubusercontent.com/GovTechSG/hats-installer/master/src/lib/install-lists/pip-install-list.txt","$path_to_robot\pip-install-list.txt");

pip install -r .\pip-install-list.txt
