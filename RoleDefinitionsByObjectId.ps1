$AppObjectId = Read-Host -Prompt "Enter the ObjectId: "

#output file path
$filename = "output.txt"

$roles = Get-AzRoleAssignment -ObjectId $AppObjectId
Write-Host "Collecting role definitions:"

ForEach ($role in $roles) {
	$role | ConvertTo-Json | Out-File -width 300 $filename
	$defs = Get-AzRoleDefinition -Id $role.RoleDefinitionId 
	ForEach ($def in $defs) {
		$def.Name
		$def | ConvertTo-Json | Out-File -width 300 $filename
	}
}

Write-Host "Role Definitions are collected to the file: $filename"
