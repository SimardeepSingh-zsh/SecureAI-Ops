#!/bin/bash
# Enables encryption for AI service data

az cognitiveservices account update \
  --name "company-ai" \
  --resource-group ai-security \
  --encryption key-source="Microsoft.KeyVault" \
  --key-vault "https://company-vault.vault.azure.net/" \
  --key-name "ai-encryption-key"