*** Settings ***
Documentation       Registration tests based on the STPB practice test-case sheet.
Resource            ../../resources/common.resource
Resource            ../../resources/pages/registration_page.resource
Test Setup          Open STPB Registration Browser
Test Teardown       Close STPB Browser
Test Tags           registration    regression

*** Test Cases ***
Registration Page Displays Expected Controls
    [Documentation]    Verify all primary inputs, choices, dropdowns, and Sign up are visible.
    [Tags]    smoke    positive    TC-REGISTER-01
    Registration Page Should Be Displayed

Reset Clears Registration Form
    [Documentation]    Verify that Reset clears entered registration data.
    [Tags]    positive    TC-REGISTER-03
    Fill Text    ${REG_FIRSTNAME_INPUT}    Robot
    Reset Registration Form
    Registration First Name Should Be Empty

Registration Requires First Name
    [Documentation]    Verify the required-field message for Firstname.
    [Tags]    negative    validation    TC-REGISTER-05
    Submit Empty Registration Form
    First Name Required Message Should Be Displayed

Registration Rejects Invalid Email
    [Documentation]    Verify that a malformed email address is rejected.
    [Tags]    negative    validation    TC-REGISTER-09
    Fill Text    ${REG_EMAIL_INPUT}    invalid-email
    Submit Empty Registration Form
    Invalid Registration Email Message Should Be Displayed

Only One Registration Gender Can Be Selected
    [Documentation]    Verify that selecting Male replaces the prior Female choice.
    [Tags]    positive    TC-REGISTER-15
    Click    ${FEMALE_RADIO}
    Click    ${MALE_RADIO}
    ${female_selected}=    Get Property    ${FEMALE_RADIO}    checked
    ${male_selected}=    Get Property    ${MALE_RADIO}    checked
    Should Be True    not ${female_selected}
    Should Be True    ${male_selected}

Registration Skill Checkboxes Can Be Selected
    [Documentation]    Verify the four skill checkboxes accept selections.
    [Tags]    positive    TC-REGISTER-16-19
    Click    ${SQL_CHECKBOX}
    Click    ${MANUAL_CHECKBOX}
    Click    ${AUTOMATE_TEST_CHECKBOX}
    Click    ${AUTOMATE_TEST_2_CHECKBOX}
    ${sql_selected}=    Get Property    ${SQL_CHECKBOX}    checked
    ${manual_selected}=    Get Property    ${MANUAL_CHECKBOX}    checked
    ${automate_selected}=    Get Property    ${AUTOMATE_TEST_CHECKBOX}    checked
    ${automate_2_selected}=    Get Property    ${AUTOMATE_TEST_2_CHECKBOX}    checked
    Should Be True    ${sql_selected}
    Should Be True    ${manual_selected}
    Should Be True    ${automate_selected}
    Should Be True    ${automate_2_selected}

Registration Dropdowns Can Be Selected
    [Documentation]    Verify Nationality, Role, and Plan accept intended selections.
    [Tags]    positive    TC-REGISTER-21-23
    Select Registration Dropdown Option    ${NATIONALITY_SELECT}    Thai
    Select Registration Dropdown Option    ${ROLE_SELECT}    Admin
    Select Registration Dropdown Option    ${PLAN_SELECT}    Basic
    Registration Dropdowns Should Be Selected

Successful Registration Displays Confirmation Modal
    [Documentation]    Register with a unique email and verify the Register Success popup without pressing OK.
    [Tags]    positive    smoke    data-creates    TC-REGISTER-24
    ${email}=    Generate Unique Registration Email
    Fill Required Registration Details    ${email}
    Click    ${SIGN_UP_BUTTON}
    Registration Success Modal Should Be Displayed

Registration Requires All Mandatory Fields
    [Documentation]    Verify required-field messages when the complete form is submitted empty.
    [Tags]    negative    validation    TC-REGISTER-25
    Submit Empty Registration Form
    Registration Required Messages Should Be Displayed
