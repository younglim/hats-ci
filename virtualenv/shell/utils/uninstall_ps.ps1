echo "Uninstalling hats"

$path_to_hats = "$env:HATS"

echo "Terminating any running instances of web drivers"
Stop-Process -processname chromedriver, geckodriver, IEDriverServer -ErrorAction silentlycontinue

echo "Removing system path entry"
$key = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey('SYSTEM\CurrentControlSet\Control\Session Manager\Environment', $true)
$path = $key.GetValue('Path',$null,'DoNotExpandEnvironmentNames')
$path
$path = ($path.Split(';') | Where-Object { $_ -ne "%HATS%" }) -join ';'
$key.SetValue('Path', $path, 'ExpandString')
$key.Dispose()

[Environment]::SetEnvironmentVariable("HATS",$null, [System.EnvironmentVariableTarget]::Machine)

echo "Removing all hats files"
Get-ChildItem -Path $path_to_hats -Recurse| Foreach-object {Remove-item -Recurse -Force -ErrorAction silentlycontinue -path $_.FullName }
Remove-Item -Recurse -Force -ErrorAction silentlycontinue $path_to_hats
