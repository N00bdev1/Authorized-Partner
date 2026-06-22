import os
import re
import time

from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build

SCOPES = ["https://www.googleapis.com/auth/gmail.readonly"]
#
# TOKEN_FILE = "token.json"
# CREDENTIALS_FILE = "credentials.json"
#
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

TOKEN_FILE = os.path.join(BASE_DIR, "token.json")
CREDENTIALS_FILE = os.path.join(BASE_DIR, "credentials.json")
def get_service():
    creds = None

    if os.path.exists(TOKEN_FILE):
        creds = Credentials.from_authorized_user_file(
            TOKEN_FILE,
            SCOPES
        )

    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(
                CREDENTIALS_FILE,
                SCOPES
            )
            creds = flow.run_local_server(port=0)

        with open(TOKEN_FILE, "w") as token:
            token.write(creds.to_json())

    return build("gmail", "v1", credentials=creds)


def extract_otp(text):
    match = re.search(r"\b\d{6}\b", text)
    return match.group(0) if match else None


def get_latest_otp(timeout=60):
    service = get_service()

    end_time = time.time() + int(timeout)

    while time.time() < end_time:

        results = service.users().messages().list(
            userId="me",
            maxResults=10
        ).execute()

        messages = results.get("messages", [])

        for msg in messages:

            email = service.users().messages().get(
                userId="me",
                id=msg["id"],
                format="full"
            ).execute()

            snippet = email.get("snippet", "")

            otp = extract_otp(snippet)

            if otp:
                return otp

        time.sleep(3)

    raise Exception("OTP not found within timeout")


if __name__ == "__main__":
    otp = get_latest_otp(60)
    print(f"OTP: {otp}")