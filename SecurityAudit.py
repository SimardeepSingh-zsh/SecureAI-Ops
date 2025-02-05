from azure.identity import DefaultAzureCredential 
from azure.mgmt.security import SecurityCenter

credential = DefaultAzureCredential()
client = SecurityCenter(credential, "<subscription_id>")

def check_ai_security():
    # Check compliance for AI services 
    compliance = client.compliance_results.list("<scope>")
    print(f"Compliance Score: {compliance.score}%")

    # List security recommendations 
    recommendations = client.recommendations.list()
    ai_recommendations = [r for r in recommendations if "AI" in r.category]
    print("Critical AI Security Recommendations:")
    for rec in ai_recommendations[:5]:
        print(f"- {rec.description}")

if __name__ == "__main__":
    check_ai_security()
    