# Signup Automation

This project automates the agency signup process on the platform — completing each step (personal details, OTP verification, agency information, professional experience, and business details) using **Robot Framework** and **Selenium**.

The signup flow requires email OTP verification. Rather than entering this manually, the script reads the OTP directly from Gmail using the Gmail API, so the verification step runs without any manual input.

## Tech Stack

- **Robot Framework** – test execution framework
- **SeleniumLibrary** – browser automation (Chrome)
- **Python** – required to run the project and power the OTP-reading script
- **Gmail API** – used to retrieve the OTP email automatically

## Prerequisites

Before running the tests, make sure you have:
- Python 3.9 or newer installed
- Google Chrome installed
- A Gmail account to receive the signup OTP emails

## Setup Instructions

1. **Open a terminal in the project root folder.**

2. **Create a virtual environment.** This keeps the project's dependencies isolated from other Python projects on your machine.
   ```bash
   python -m venv .venv
   ```

3. **Activate the virtual environment.**
   ```bash
   .venv\Scripts\activate
   ```
   On macOS/Linux, use `source .venv/bin/activate` instead.

4. **Install the required dependencies.**
   ```bash
   pip install -r requirements.txt
   ```

5. **Set up Gmail API access (one-time setup).**
   - Open Google Cloud Console and enable the Gmail API for a project.
   - Create an OAuth Client ID and select "Desktop app" as the application type.
   - Download the credentials file and save it as `Helper/credentials.json`.
   - On the first test run, a browser window will open asking you to log in and authorize access to the Gmail account. Approve this once — the authorization is saved afterward, so it won't ask again on future runs.

## Running the Tests

Once setup is complete, run the test suite with:
```bash
robot --outputdir Results Tests/SignUpAutomation.robot
```

This launches Chrome, completes the signup form from start to finish, retrieves the OTP from Gmail automatically, and verifies that the profile page loads successfully at the end.

## Viewing the Results

After execution, the `Results` folder will contain:
- **report.html** – a summary of which steps passed or failed
- **log.html** – a detailed, step-by-step execution log with screenshots if a step fails

Open either file in a browser to review the run.

## Test Data Used

All form data used during signup is defined in `Resources/Variables/SignUpVariables.robot`. This is dummy/test data and does not represent real personal or business information.

**Email account used for testing**

The OTP must be received by a real Gmail inbox, since the script reads it directly from that account. This project was tested using:

```
alisontest6769@gmail.com
```

If you are running this project yourself, use an email alias under the same inbox so the OTP still reaches an account you control, while keeping each test run's email unique. Gmail supports this using the `+` alias format — for example:

```
alisontest6769+test123@gmail.com
```

Replace `123` with any number of your choosing. Emails sent to this alias still land in the same `alisontest6769@gmail.com` inbox, so OTP retrieval will continue to work without any extra configuration.

**Phone number**

The phone number field in `SignUpVariables.robot` should be updated to your own phone number before running the tests, since the platform may validate or use this field during signup.

**Other test data fields**

The remaining values (agency name, agency details, professional experience, business registration number, etc.) are placeholder values and can be left as-is or customized as needed.

## Notes

- `credentials.json` and `token.json` are private Gmail authorization files. Do not share or upload these publicly.
- The certificate file used during the upload step is a sample PDF located in `Resources/Certificate/`.
- If running this project on a different machine, confirm that the certificate file path in `SignUpVariables.robot` still points to a valid location.
