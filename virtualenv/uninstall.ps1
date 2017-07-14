echo "Uninstalling hats"

$path_to_hats = "$env:PROGRAMFILES\hats"

echo "Terminating any running instances of web drivers"
Stop-Process -processname chromedriver, geckodriver, IEDriverServer -ErrorAction silentlycontinue

echo "Deleting installed files..."
Remove-Item -Recurse -Force -ErrorAction silentlycontinue "$path_to_hats"

echo "Removing system path entry"
$path = [System.Environment]::GetEnvironmentVariable('PATH', 'Machine');
$path = ($path.Split(';') | Where-Object { $_ -ne "$path_to_hats" }) -join ';'
[System.Environment]::SetEnvironmentVariable('PATH', $path, 'Machine');