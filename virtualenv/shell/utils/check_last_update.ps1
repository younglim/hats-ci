$scriptpath = $MyInvocation.MyCommand.Path
$path_to_utils = Split-Path $scriptpath

$last_update_string = Get-Content "$path_to_utils\last-check.txt"
$last_update_split = $last_update_string -split '\n'
$last_update_date = Get-Date $last_update_string[1]

$curr_date = Get-Date
$days = ($curr_date - $last_update_date).Days

if ($days -ge 7) {
  echo "It's been $days days since you last checked for updates. Use command 'update' to check for updates again"
}
