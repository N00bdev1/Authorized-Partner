*** Variables ***
${login_link}   xpath=//a[.//p[text()='Login']]
${login_button}     xpath=//button[@type='submit' and text()='Log In']
${signup_link}  xpath=//a[text()='Sign Up']
${terms_checkbox}   xpath=//button[@id='remember']
${terms_continue}   xpath=//button[contains(text(),'Continue')]
#Personal Details Locators
${first_name_field}   xpath=//input[@name='firstName']
${last_name_field}   xpath=//input[@name='lastName']
${email_field}    xpath=//input[@name='email']
${phone_field}    xpath=//input[@name='phoneNumber']
${country_code_field}     xpath=//button[@role='combobox']
${nepal_country_code}   xpath=//*[@role='option' and contains(.,'+977')]
${password_field}     xpath=//input[@name='password']
${confirm_password_field}     xpath=//input[@name='confirmPassword']
${next_button}      xpath=//button[@type='submit' and normalize-space()='Next']
#OTP Locators
${OTP_field}  xpath=//input[@autocomplete='one-time-code']
${OTP_verify_button}    xpath=//button[normalize-space()='Verify Code']
#Agency Details Locators
${agency_name_field}  xpath=//input[@name='agency_name']
${agency_role_field}  xpath=//input[@name='role_in_agency']
${agency_email_field}  xpath=//input[@name='agency_email']
${agency_website_field}   xpath=//input[@name='agency_website']
${agency_address_field}   xpath=//input[@name='agency_address']
${agency_region}    xpath=//button[@role='combobox' and contains(.,'Region')]
${nepal_region}     xpath=//div[contains(@class,'cursor-pointer') and .//span[normalize-space()='Nepal']]
#Experience Locators
${experience_year}  xpath=//label[text()='Years of Experience']/following-sibling::button
${student_numbers_field}  xpath=//input[@name='number_of_students_recruited_annually']
${focus_area_field}   xpath=//input[@name='focus_area']
${sucess_metrics_field}   xpath=//input[@name='success_metrics']
${career_counseling}    xpath=//label[text()='Career Counseling']/preceding-sibling::button
${two_years_experience}     xpath=//span[normalize-space()='2 years']
#Business Details and Preferences Locators
${Business_Registration_Number_field}     xpath=//input[@name='business_registration_number']
${prefered_country_field}     xpath=//label[text()='Preferred Countries']/following-sibling::button
${university_choice_field}    xpath=//label[text()='Universities']/preceding-sibling::button
${certification_details_field}    xpath=//input[@name='certification_details']
${certificate_file_1}       xpath=//input[@type='file'][1]
${submit_button}   xpath=//button[normalize-space()='Submit']
${profile_page}     xpath=//h2[normalize-space()='My Profile']