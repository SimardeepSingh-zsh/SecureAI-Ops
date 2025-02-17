#!/bin/bash
# Generates compliance status report

az policy state summarize \
  --filter "complianceState eq 'NonCompliant'" \
  --query "results[?contains(resourceType, 'CognitiveServices')].{Resource:resourceId, Issue:description}" \
  --output table > compliance-report.md

echo "📋 Report saved to compliance-report.md"