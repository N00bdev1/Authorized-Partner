*** Settings ***
Resource   ../Pages/SignUpPage.robot

*** Test Cases ***
Signup with valid Credentials
    open website
    click login link
    click signup link
    agree to terms and conditions
    fill personal details form
    fill otp
    click verify code button
    fill agency details
    fill professional experience details
    fill business and set preferences details
    verify profile page loads