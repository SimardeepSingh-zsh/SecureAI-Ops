import smtplib
from datetime import datetime

def notify_authorities():
    message = f"""Subject: GDPR Breach Notification
To: dpo@authority.eu
From: security@company.com

Nature of breach: Unauthorized AI model access
Date: {datetime.now().strftime("%Y-%m-%d")} 
Affected individuals: 1500
Measures taken: Model isolation & key rotation"""

    with smtplib.SMTP("smtp.office365.com", 587) as server:
        server.starttls()
        server.login("alerts@company.com", os.getenv("SMTP_PASS"))
        server.sendmail("alerts@company.com", "dpo@authority.eu", message)
