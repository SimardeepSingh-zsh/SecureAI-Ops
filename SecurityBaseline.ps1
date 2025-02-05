# Requires Azure Powershell module: Install-Module Az

# Login to Azure 
Connect-AzAccount

# Enable Azure Defender for Cloud 
Set-AzSecurityPricing -Name "VirtualMachines" -PricingTier "Standard"
Set-AzSecuirtyPricing -Name "ContainerRegistry" -PricingTier "Standard"

# Enable Diagnostic Logging for AI Services 
$workspace = Get-AzOperationalInsightsWorkspace -ResourceGroupName "Your-RG"
Set-AzDiagnosticSetting -ResourceId (Get-AzCognitiveServicesAccount -Name "Your-AI-Service").Id -WorkspaceId $workspace.ResourceId
     -WorkspaceId $workspace.ResourceId -Enabled $true

# Auto-rotate keys for Azure AI Services
Update-AzCognitiveServicesAccount -Name "Your-AI-Service" -ResourceGroupName "Your-RG" -AutoRotateKey

# Set Network Restrictions 
Add-AzCognitiveServicesAccountNetworkRule -ResourceGroupName "Your-RG" -Name "Your-AI-Service"
    -IPAddressOrRange "192.168.1.0/24"

# Enable Private Endpoints 
New-AzPrivateEndpoint -Name "AI-Service-PrivateEndpoint" -ResourceGroupName "Your-RG"
    -Location "westus" -Subnet $subnet -PriavteLinkServiceConnection $connection
    
