$path_to_hats = "C:\Program Files\hats"

$ieVersion = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Internet Explorer').SvcVersion;
$isIe11PatchRequired = $ieVersion -And $ieVersion -match "11.";

if ((gwmi win32_operatingsystem | select osarchitecture).osarchitecture -eq "64-bit")
{
	echo "Your system is 32-bit..." 
	
	if ($isIe11PatchRequired) {
		echo "Applying IE11 FEATURE_BFCACHE patch..."
		REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\MAIN\FeatureControl\FEATURE_BFCACHE" /v iexplore.exe /t REG_DWORD /d 0 /f
    }
}	
else 
{
	echo "Your system is 64-bit..."
	if ($isIe11PatchRequired) {
		echo "Applying IE11 FEATURE_BFCACHE patch..."
		REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Internet Explorer\MAIN\FeatureControl\FEATURE_BFCACHE" /v iexplore.exe /t REG_DWORD /d 0 /f
    }
}

echo "Disabling IE enhanced protected mode..."
# script from https://gallery.technet.microsoft.com/scriptcenter/Enable-or-disable-Internet-ab7dd2c6

#Registry key path
$Keypath = "HKCU:\Software\Microsoft\Internet Explorer\Main"
#Get registry key value named "Isolation"
$value = Get-ItemProperty -Path $Keypath -Name "Isolation"  -ErrorAction SilentlyContinue
if ($value) {
	if ($value.Isolation -eq "PMEM") {
		Set-ItemProperty -Path $Keypath -Name "Isolation" -Value "PMIL"
		Write-Host "Disable Enhanced Protected Mode successfully, please close all instances of Internet Explorer for it to take  effect."
	} else {
		echo "Enhanced protected mode is already disabled."
	}
} else {
	New-ItemProperty -Name "Isolation" -Path $Keypath -Value "PMIL" -PropertyType String | Out-Null
	Write-Host "Disable Enhanced Protected Mode successfully, please close all instances of Internet Explorer for it to take  effect."
}

# see https://superuser.com/questions/1031225/what-is-the-registry-setting-to-enable-protected-mode-in-a-specific-zone
echo "Enabling protected mode for all zones..."
for ($zone=1; $zone -lt 5; $zone++) {

	REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\$zone" /v 2500 /t REG_DWORD /d 0 /f

	REG ADD "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\$zone" /v 2500 /t REG_DWORD /d 0 /f

	REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\$zone" /v 2500 /t REG_DWORD /d 0 /f
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

echo "Add 127.0.0.1 as hostname to hosts file"
$file = "$env:windir\System32\drivers\etc\hosts"
"127.0.0.1	127.0.0.1" | Add-Content -PassThru $file

echo "Install Windows Build Tools"
cd "$path_to_hats\utils"
Start-Process BuildTools_Full.exe -ArgumentList "/Full /Silent" -NoNewWindow -Wait;

