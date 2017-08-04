$path_to_hats = "C:\Program Files\hats"

echo "Patch Internet Explorer Protected Mode: On (Group Policy)"
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1" /v 2500 /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v 2500 /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v 2500 /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" /v 2500 /t REG_DWORD /d 0 /f

echo "Patch Internet Explorer Protected Mode: On (Registry)"

REG ADD "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1" /v 2500 /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v 2500 /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v 2500 /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" /v 2500 /t REG_DWORD /d 0 /f

REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1" /v 2500 /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v 2500 /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v 2500 /t REG_DWORD /d 0 /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" /v 2500 /t REG_DWORD /d 0 /f

if ((gwmi win32_operatingsystem | select osarchitecture).osarchitecture -eq "64-bit")
{
    #64 bit logic here
	echo "Patch Internet Explorer FEATURE_BFCACHE"
	
	REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Internet Explorer\MAIN\FeatureControl\FEATURE_BFCACHE" /v iexplore.exe /t REG_DWORD /d 0 /f
}
else
{
    #32 bit logic here
    echo "Patch Internet Explorer FEATURE_BFCACHE"

    REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\MAIN\FeatureControl\FEATURE_BFCACHE" /v iexplore.exe /t REG_DWORD /d 0 /f

}

echo "Set environment variables"
[Environment]::SetEnvironmentVariable("HATS", $path_to_hats, [System.EnvironmentVariableTarget]::Machine)

$key = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey('SYSTEM\CurrentControlSet\Control\Session Manager\Environment', $true)
$path = $key.GetValue('Path',$null,'DoNotExpandEnvironmentNames')
$path = ($path.Split(';') | Where-Object { $_ -ne "%HATS%" }) -join ';'
$path = "%HATS%;" + $path;
$path
$key.SetValue('Path', $path, 'ExpandString')
$key.Dispose()
