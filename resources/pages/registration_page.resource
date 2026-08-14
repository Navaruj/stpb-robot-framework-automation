*** Settings ***
Documentation    Locators and reusable Browser Library keywords for the public STPB registration page.
Library          DateTime
Resource         ../common.resource

*** Variables ***
${REGISTER_PATH}                 /register/
${REGISTER_HEADING}              xpath=//h6[normalize-space(.)="Kru P' Beam"]
${RESET_LINK}                    css=#reset
${REG_FIRSTNAME_INPUT}           css=#firstname
${REG_LASTNAME_INPUT}            css=#lastname
${REG_EMAIL_INPUT}               css=#email
${REG_PASSWORD_INPUT}            css=#password
${REG_MOBILE_INPUT}              css=#mobile-phone
${FEMALE_RADIO}                  css=input[name="validation-basic-radio"][value="female"]
${MALE_RADIO}                    css=input[name="validation-basic-radio"][value="male"]
${SQL_CHECKBOX}                  css=input[name="courses.SQL"]
${MANUAL_CHECKBOX}               css=input[name="courses.Test Manual"]
${AUTOMATE_TEST_CHECKBOX}        css=input[name="courses.Automate Test"]
${AUTOMATE_TEST_2_CHECKBOX}      css=input[name="courses.Automate Test2"]
${NATIONALITY_SELECT}            css=#nationality
${ROLE_SELECT}                   css=#select-role
${PLAN_SELECT}                   css=#select-plan
${SIGN_UP_BUTTON}                css=#btn-sign-up
${REQUIRED_FIELD_MESSAGE}        xpath=(//p[normalize-space(.)="This field is required"])[1]
${REQUIRED_FIELD_MESSAGES}       xpath=//p[normalize-space(.)="This field is required"]
${INVALID_EMAIL_MESSAGE}         xpath=//p[normalize-space(.)="Invalid email address"]
${REGISTRATION_SUCCESS_MESSAGE}  xpath=//p[normalize-space(.)="Register Success"]

*** Keywords ***
Open STPB Registration Browser
    Open STPB Browser At    ${STPB_REGISTER_URL}
    Registration Page Should Be Displayed

Registration Page Should Be Displayed
    Wait For Elements State    ${REGISTER_HEADING}    visible
    Wait For Elements State    ${REG_FIRSTNAME_INPUT}    visible
    Wait For Elements State    ${REG_LASTNAME_INPUT}    visible
    Wait For Elements State    ${REG_EMAIL_INPUT}    visible
    Wait For Elements State    ${REG_PASSWORD_INPUT}    visible
    Wait For Elements State    ${REG_MOBILE_INPUT}    visible
    Wait For Elements State    ${FEMALE_RADIO}    visible
    Wait For Elements State    ${SQL_CHECKBOX}    visible
    Wait For Elements State    ${NATIONALITY_SELECT}    visible
    Wait For Elements State    ${ROLE_SELECT}    visible
    Wait For Elements State    ${PLAN_SELECT}    visible
    Wait For Elements State    ${SIGN_UP_BUTTON}    visible
    ${url}=    Get Url
    Should Contain    ${url}    ${REGISTER_PATH}

Submit Empty Registration Form
    Click    ${SIGN_UP_BUTTON}

First Name Required Message Should Be Displayed
    Wait For Elements State    xpath=//input[@id="firstname"]/ancestor::div[contains(@class,"MuiFormControl-root")]//p[normalize-space(.)="This field is required"]    visible

Registration Required Messages Should Be Displayed
    Wait For Elements State    ${REQUIRED_FIELD_MESSAGE}    visible
    ${message_count}=    Get Element Count    ${REQUIRED_FIELD_MESSAGES}
    Should Be True    ${message_count} >= 10

Invalid Registration Email Message Should Be Displayed
    Wait For Elements State    ${INVALID_EMAIL_MESSAGE}    visible

Reset Registration Form
    Click    ${RESET_LINK}

Registration First Name Should Be Empty
    ${value}=    Get Property    ${REG_FIRSTNAME_INPUT}    value
    Should Be Empty    ${value}

Select Registration Dropdown Option
    [Arguments]    ${dropdown}    ${option}
    Click    ${dropdown}
    Wait For Elements State    xpath=//*[@role="option" and normalize-space(.)="${option}"]    visible
    Click    xpath=//*[@role="option" and normalize-space(.)="${option}"]

Registration Dropdowns Should Be Selected
    ${nationality}=    Get Text    ${NATIONALITY_SELECT}
    ${role}=    Get Text    ${ROLE_SELECT}
    ${plan}=    Get Text    ${PLAN_SELECT}
    Should Be Equal    ${nationality}    Thai
    Should Be Equal    ${role}    Admin
    Should Be Equal    ${plan}    Basic

Generate Unique Registration Email
    ${timestamp}=    Get Current Date    result_format=%Y%m%d%H%M%S%f
    ${email}=    Set Variable    robot.qa.${timestamp}@example.com
    RETURN    ${email}

Fill Required Registration Details
    [Arguments]    ${email}
    Fill Text    ${REG_FIRSTNAME_INPUT}    Robot
    Fill Text    ${REG_LASTNAME_INPUT}    Portfolio
    Fill Text    ${REG_EMAIL_INPUT}    ${email}
    Fill Text    ${REG_PASSWORD_INPUT}    Robot12345
    Fill Text    ${REG_MOBILE_INPUT}    0812345678
    Click    ${FEMALE_RADIO}
    Click    ${SQL_CHECKBOX}
    Select Registration Dropdown Option    ${NATIONALITY_SELECT}    Thai
    Select Registration Dropdown Option    ${ROLE_SELECT}    Admin
    Select Registration Dropdown Option    ${PLAN_SELECT}    Basic

Registration Success Modal Should Be Displayed
    Wait For Elements State    ${REGISTRATION_SUCCESS_MESSAGE}    visible
