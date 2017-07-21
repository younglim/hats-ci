echo "Installing hats"

$path_to_hats = (Get-Item -Path ".\" -Verbose).Parent.Parent.FullName

echo "Add system path entry for HATS"
$key = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey('SYSTEM\CurrentControlSet\Control\Session Manager\Environment', $true)
$path = $key.GetValue('Path',$null,'DoNotExpandEnvironmentNames')
$path = ($path.Split(';') | Where-Object { $_ -ne "%HATS%" }) -join ';'
$path = "%HATS%;" + $path;
$key.SetValue('Path', $path, 'ExpandString')
$key.Dispose()

[Environment]::SetEnvironmentVariable("HATS", $path_to_hats, [System.EnvironmentVariableTarget]::Machine)

pause