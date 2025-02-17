# Verify encryption and access controls for PHI
$aiService = Get-AzCognitiveServicesAccount -Name "health-ai"
$logs = Get-AzDiagnosticSetting -ResourceId $aiService.Id

# Check encryption
if ($aiService.Encryption.KeySource -ne "Microsoft.KeyVault") {
    Write-Output "❌ Encryption Not Compliant - Enable Key Vault"
}

# Check audit logging
if (-not $logs.LogsEnabled) {
    Write-Output "❌ Audit Logging Disabled"
}

# Check access policies
$excessiveAccess = Get-AzRoleAssignment -Scope $aiService.Id | 
    Where-Object { $_.RoleDefinitionName -eq "Owner" -and $_.ObjectType -eq "User" }

if ($excessiveAccess) {
    Write-Output "❌ Excessive User Access Found"
}