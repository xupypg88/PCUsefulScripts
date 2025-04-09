Connect-AzureAD 
# app data by object id 
$principal = Get-AzureADServicePrincipal -Filter "ObjectId eq '671ea22b-034d-412a-bb96-0b279279eb4c'"

$AppObjectId = $principal.ObjectId

#output file path
$filename = "output.txt"
$principal | ConvertTo-Json | Out-File -width 300 $filename

#getting roles for the app
$roles = Get-AzRoleAssignment -ObjectId $AppObjectId

#getting each role data
ForEach ($role in $roles) {
	$role | ConvertTo-Json | Out-File -append -width 300 $filename
	$defs = Get-AzRoleDefinition -Id $role.RoleDefinitionId 
	ForEach ($def in $defs) {
		$def.Name
		$def | ConvertTo-Json | Out-File -append -width 300 $filename
	}
}
Write-Host "Role Definitions are collected to the file: $filename"
