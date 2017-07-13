# Set path to hats
$path_to_hats = "$env:PROGRAMFILES\hats"

$path_to_hats_esc = [regex]::Escape($path_to_hats)
$regex_path = "$path_to_hats_esc$|$path_to_hats_esc;"
If ($Env:Path -match $regex_path) {
	echo "Path already exists"
} Else {
	[Environment]::SetEnvironmentVariable("PATH", $Env:Path + ";$path_to_hats", "Machine")
	echo "Permanently adding path of hats to system environment variable"
}

echo "Create robot folder in $path_to_hats"
If(!(test-path $path_to_hats))
{
	New-Item -ItemType Directory -Force -Path "$env:PROGRAMFILES\hats"
}

$user = "$env:UserDomain\$env:UserName"
echo "Setting permisions for user $user"

$Folders = Get-childItem $path_to_hats -attributes D
$InheritanceFlag = [System.Security.AccessControl.InheritanceFlags]::ContainerInherit -bor [System.Security.AccessControl.InheritanceFlags]::ObjectInherit
$PropagationFlag = [System.Security.AccessControl.PropagationFlags]::None
$objType = [System.Security.AccessControl.AccessControlType]::Allow

$acl = Get-Acl "$path_to_hats"
$permission = $user,"Modify", $InheritanceFlag, $PropagationFlag, $objType
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
$acl.SetAccessRule($accessRule)
Set-Acl -Path "$path_to_hats" -AclObject $acl
