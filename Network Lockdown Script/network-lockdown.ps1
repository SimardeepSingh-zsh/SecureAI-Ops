# Restricts AI service access to approved locations
$serviceName = "company-ai-service"
$allowedIPs = @("192.168.1.0/24", "10.0.1.0/28")

az cognitiveservices account update `
  --name $serviceName `
  --resource-group ai-security `
  --default-action Deny `
  --ip-rules $allowedIPs

Write-Host "🔒 AI Service now only accessible from office locations"