#!/bin/bash

# Scan Docker image for vulnerabilities
az acr build --registry <acr-name> --image chatbot-scan --file Dockerfile .
az acr task run --registry <acr-name> --name scan-task --context .

# Check results
echo "Vulnerability Report:"
az acr repository show -n <acr-name> --repository chatbot-scan --query "lastScanResult"

