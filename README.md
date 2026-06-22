# Authorized Partner Signup Automation Test Suite — Execution Guide

Automated end-to-end test for the Agency Signup flow, built with **Robot Framework** + **SeleniumLibrary**, with automatic OTP retrieval via the **Gmail API**.

---

## 1. Project Structure

```
Authorized Partner/
├── .venv/                          # Python virtual environment
├── Helper/
│   ├── credentials.json            # Gmail API OAuth client credentials
│   ├── gmail_reader.py             # Python module — fetches the latest OTP email via Gmail API
│   └── token.json                  # Auto-generated Gmail API auth token (created on first run)
├── Pages/
│   └── SignUpPage.robot            # Keyword definitions for each signup step (page object layer)
├── Resources/
│   ├── Certificate/
│   │   └── XYZ_Company_Registration.pdf   # Sample file uploaded during the "Business & Preferences" step
│   ├── Locators/
│   │   └── SignUpLocators.robot    # All element locators used by SignUpPage.robot
│   └── Variables/
│       ├── Common.robot            # Shared variables (base URL, browser, login credentials, etc.)
│       └── SignUpVariables.robot    # Test data for the signup form (name, email, agency details, etc.)
├── Results/                         # Robot Framework output (log.html, report.html, output.xml) — generated after each run
├── Tests/
│   └── SignUpAutomation.robot       # Test case(s) — the actual automation flow
├── requirements.txt
└── Signup automation.mp4            # Demo video recording of a full run
```

---

## 2. Tech Stack

| Component          | Details                                                         |
| ------------------ | --------------------------------------------------------------- |
| Test framework     | Robot Framework                                                 |
| Browser automation | SeleniumLibrary                                                 |
| Language           | Python 3                                                        |
| OTP retrieval      | Google Gmail API (`gmail_reader.py`)                            |
| Browser            | Chrome (via Selenium WebDriver)                                 |
| Report/Log output  | Robot Framework native HTML reports (`log.html`, `report.html`) |

---

## 3. Prerequisites

- Python 3.9+ installed and on PATH
- Google Chrome installed
- ChromeDriver matching your installed Chrome version (or use Selenium Manager / `webdriver-manager`, which resolves this automatically if configured)
- A Gmail account used to receive the OTP emails during signup, with Gmail API access enabled (see setup below)

---

## 4. Environment Setup

1. **Clone/copy the project** and open a terminal in the project root (`Authorized Partner/`).

2. **Create and activate a virtual environment**

   ```bash
   python -m venv .venv
   # Windows
   .venv\Scripts\activate
   # macOS/Linux
   source .venv/bin/activate
   ```

3. **Install dependencies**

   ```bash
   pip install -r requirements.txt
   ```

   This installs Robot Framework, SeleniumLibrary, and the Google API client libraries used by `gmail_reader.py`.

4. **Gmail API setup (one-time)**
   - In Google Cloud Console, enable the **Gmail API** for a project and create an **OAuth 2.0 Client ID** (Desktop app).
   - Download the OAuth client file and save it as `Helper/credentials.json`.
   - On the first test run, `gmail_reader.py` will open a browser window to authorize access to the test Gmail inbox and will save the resulting session as `Helper/token.json`. Subsequent runs reuse this token automatically (no need to re-authorize unless it expires or is revoked).

---

## 5. Test Data / Accounts Used

All test data lives in `Resources/Variables/SignUpVariables.robot`. These are dummy/test values (no real personal or business data):

**Personal information**

| Field      | Value                          |
| ---------- | ------------------------------ |
| First name | Alison                         |
| Last name  | Maharjan                       |
| Email      | alisontest6769+test001@gmail.com |
| Phone      | 9847309490                     |
| Password   | I12bre@k4e                     |
| Country    | Nepal                          |

**Agency details**

| Field          | Value           |
| -------------- | --------------- |
| Agency name    | XYX company     |
| Role           | QA engineer     |
| Agency email   | xyz10@gmail.com |
| Agency website | www.xyz.com     |
| Agency address | Kathmandu       |
| Region         | Nepal           |

**Professional experience**

| Field               | Value      |
| ------------------- | ---------- |
| Years of experience | 2 years    |
| Student numbers     | 200        |
| Success metrics     | 80         |
| Focus area          | IT courses |

**Business & preferences**

| Field                        | Value                                                                      |
| ---------------------------- | -------------------------------------------------------------------------- |
| Business registration number | 20011                                                                      |
| Certification details        | ICEF Certified Education Agent                                             |
| Registration certificate     | `D:/Authorized Partner/Resources/Certificate/XYZ_Company_Registration.pdf` |

- **OTP verification account**: the Gmail inbox connected via `credentials.json` / `token.json` (the `+test1` alias on the personal email above) — must be the same inbox that receives the signup OTP email for the `${email}` used during signup.
- **Login account**: defined in `Resources/Variables/Common.robot` (`${email}`, `${password}`) — used to log in before starting signup.

> Note: `${registration_certificate}` is currently an absolute local path (`D:/Authorized Partner/...`). If running on another machine, update this path or switch to a relative path under `Resources/Certificate/`.

---

## 6. How to Run

From the project root, with the virtual environment activated:

```bash
robot --outputdir Results Tests/SignUpAutomation.robot
```

This will:

1. Launch the browser and open the site (`Open Website`)
2. Walk through Login → Signup → Personal Details → OTP Verification → Agency Details → Professional Experience → Business & Preferences
3. Verify the **My Profile** page loads on success
4. Write `log.html`, `report.html`, and `output.xml` to the `Results/` folder



---

## 7. Viewing Results

After execution, open the following from the `Results/` folder:

- `report.html` — high-level pass/fail summary
- `log.html` — detailed step-by-step execution log, including screenshots on failure

---

## 8. Notes

- `gmail_reader.py`'s `Get Latest Otp` keyword polls the inbox for the most recent OTP email within a 60-second timeout; ensure the Gmail account has no stale/old OTP emails that could be picked up by mistake.
- The suite includes a `Sleep` before reading the OTP to allow email delivery time — adjust this value if OTP emails arrive slower/faster in your environment.
- A demo recording of a full run is included as `Signup automation.mp4`.
