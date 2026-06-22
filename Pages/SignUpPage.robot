*** Settings ***
Library     SeleniumLibrary
Library    ../Helper/gmail_reader.py
Resource    ../Resources/Variables/Common.robot
Resource    ../Resources/Locators/SignUpLocators.robot
Resource    ../Resources/Variables/SignUpVariables.robot

*** Keywords ***
Open Website
    open browser    ${base_url}     ${browser}
    maximize browser window
Click Login Link
    wait until element is visible    ${login_link}
    click element    ${login_link}
Click Login Button
    wait until element is visible    ${login_button}
    click element    ${login_button}
Fill login details
    wait until element is visible    ${email_field}
    input text    ${email_field}  ${email}
    input password    ${password_field}   ${password}
Click Signup Link
    wait until keyword succeeds    5x    1s
    ...     click element   ${signup_link}
Click Next button
    wait until element is visible   ${next_button}
    click element    ${next_button}
Agree to terms and conditions
    wait until element is visible    ${terms_checkbox}
    click element    ${terms_checkbox}
    click element    ${terms_continue}
#personal details page
select country code
    Click Element    ${country_code_field}
    Wait Until Page Contains Element    ${nepal_country_code}   10s
    Wait Until Keyword Succeeds    5x    1s
    ...    Click Element    ${nepal_country_code}
Fill personal details form
    wait until element is visible    ${first_name_field}
    input text    ${first_name_field}     ${first_name}
    input text    ${last_name_field}      ${last_name}
    input text    ${email_field}      ${email}
    select country code
    input text    ${phone_field}  ${phone}
    input password    ${password_field}   ${password}
    input password    ${confirm_password_field}   ${password}
    click next button

#OTP page
Fill OTP
     sleep    10s
     ${otp}=    Get Latest Otp    60
     input text   ${otp_field}    ${otp}
Click Verify Code Button
    wait until element is visible    ${otp_verify_button}
    click element    ${otp_verify_button}

#Agency Details page

Fill Agency Details
    wait until element is visible    ${agency_name_field}
    input text    ${agency_name_field}    ${agency_name}
    input text    ${agency_role_field}    ${agency_role}

    input text    ${agency_email_field}   ${agency_email}
    input text    ${agency_website_field}    ${agency_website}
    input text    ${agency_address_field}    ${agency_address}
    click element  ${agency_region}
    wait until page contains element    ${nepal_region}
    wait until keyword succeeds    5x   1s
    ...     click element    ${nepal_region}
    click next button

#professional experience page
Fill Professional Experience Details
    wait until element is visible    ${experience_year}
    click element    ${experience_year}
    wait until page contains element    ${two_years_experience}     10s
    wait until keyword succeeds    5x   1s
    ...    click element    ${two_years_experience}
    input text    ${student_numbers_field}    ${student_numbers}
    input text    ${focus_area_field}     ${focus_area}
    input text     ${sucess_metrics_field}    ${sucess_metrics}
    click element    ${career_counseling}
    click next button
#Verification and preferences page
Click Submit Button
    wait until element is visible    ${submit_button}
    click element    ${submit_button}

Fill Business and Set Preferences Details
    wait until element is visible    ${business_registration_number_field}
    input text    ${business_registration_number_field}   ${business_registration_number}
    click element    ${prefered_country_field}
    wait until page contains element    ${nepal_region}     10s
    wait until keyword succeeds    5x   1s
    ...     click element    ${nepal_region}
    click element   ${university_choice_field}
    input text    ${certification_details_field}  ${certifications_details}
    choose file    ${certificate_file_1}    ${registration_certificate}
    click submit button
verify profile page loads
    Sleep   5s
    wait until element is visible    //h2[normalize-space()='My Profile']
    page should contain    My Profile

