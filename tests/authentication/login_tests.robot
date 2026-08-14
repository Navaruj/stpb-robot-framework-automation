*** Settings ***
Documentation       Authentication tests for the STPB practice application.
Resource            ../../resources/common.resource
Resource            ../../resources/pages/registration_page.resource
Resource            ../../resources/pages/user_list_page.resource
Test Setup          Open STPB Browser
Test Teardown       Close STPB Browser
Test Tags           authentication    regression

*** Test Cases ***
Login Page Displays Expected Controls
    [Documentation]    Verify the login heading, credential fields, button, and registration link.
    [Tags]    smoke    positive    TC-LOGIN-01
    Login Page Should Be Displayed
    Wait For Elements State    ${CREATE_ACCOUNT_LINK}    visible

Login Rejects Invalid Email Format
    [Documentation]    Verify that an invalid email format is rejected before authentication.
    [Tags]    negative    validation    TC-LOGIN-04
    Login With Credentials    invalid-email    valid-password
    Invalid Login Email Format Message Should Be Displayed

Login Rejects Password Shorter Than Five Characters
    [Documentation]    Verify that a password shorter than five characters is rejected.
    [Tags]    negative    validation    TC-LOGIN-06
    Login With Credentials    qa@example.com    123
    Short Login Password Message Should Be Displayed

User Can Login With Valid Credentials
    [Documentation]    Verify that the public demo user can reach the user list page.
    [Tags]    smoke    positive    TC-LOGIN-07
    Login As Demo User
    User List Page Should Be Displayed

Login Fails With Invalid Credentials
    [Documentation]    Verify that invalid credentials are rejected with an error message.
    [Tags]    negative    TC-LOGIN-08
    Login With Credentials    invalid.user@example.com    wrong-password
    Invalid Credentials Message Should Be Displayed

Required Validation Is Displayed For Empty Credentials
    [Documentation]    Verify required-field validation without submitting credentials.
    [Tags]    negative    validation    TC-LOGIN-09
    Submit Empty Login Form
    Required Login Messages Should Be Displayed

Create Account Link Opens Registration Page
    [Documentation]    Verify that the Create an account link opens the public registration page.
    [Tags]    positive    navigation    TC-LOGIN-10
    Open Registration Page From Login
    Registration Page Should Be Displayed
