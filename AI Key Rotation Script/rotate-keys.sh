#!/bin/bash
# Rotates keys for Azure AI services every 90 days

SERVICE_NAME="my-ai-service"
RESOURCE_GROUP="ai-resources"

# Get current keys
OLD_KEY=$(az cognitiveservices account keys list \
          --name $SERVICE_NAME \
          --resource-group $RESOURCE_GROUP \
          --query key1 -o tsv)

# Regenerate keys
az cognitiveservices account keys regenerate \
  --name $SERVICE_NAME \
  --resource-group $RESOURCE_GROUP \
  --key-name key1

echo "🔑 Old Key: $OLD_KEY (Disable this in all applications)"
echo "🆕 New Key: Check Azure Portal -> Your AI Service -> Keys"
