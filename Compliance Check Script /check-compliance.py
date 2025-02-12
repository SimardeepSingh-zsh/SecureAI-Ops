from azure.mgmt.security import SecurityCenter
from azure.identity import DefaultAzureCredential

credential = DefaultAzureCredential()
client = SecurityCenter(credential, "subscription-id")

def main():
    score = client.secure_scores.get("subscription-id").current_score
    print(f"📊 Security Score: {score}/100")
    
    if score < 80:
        print("🔴 Alert: Below security standard!")
    else:
        print("🟢 All clear!")

if __name__ == "__main__":
    main()