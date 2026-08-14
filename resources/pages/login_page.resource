*** Settings ***
Documentation    Locators and reusable Browser Library keywords for the STPB login page.

*** Variables ***
${LOGIN_PATH}                 /login/
${LOGIN_HEADING}              xpath=//h5[contains(normalize-space(.),"Welcome to Kru P' Beam")]
${LOGIN_EMAIL_INPUT}          css=#email
${LOGIN_PASSWORD_INPUT}       css=input[name="password"]
${LOGIN_BUTTON}               css=#btn-login
${CREATE_ACCOUNT_LINK}        css=a[href="/register/"]
${LOGIN_ERROR_MESSAGE}        xpath=//p[normalize-space(.)="Email or Password is invalid"]
${EMAIL_FORMAT_MESSAGE}       xpath=//p[normalize-space(.)="email must be a valid email"]
${EMAIL_REQUIRED_MESSAGE}     xpath=//p[normalize-space(.)="email is a required field"]
${PASSWORD_REQUIRED_MESSAGE}  xpath=//p[normalize-space(.)="password must be at least 5 characters"]

*** Keywords ***
Login Page Should Be Displayed
    Wait For Elements State    ${LOGIN_HEADING}    visible
    Wait For Elements State    ${LOGIN_EMAIL_INPUT}    visible
    Wait For Elements State    ${LOGIN_PASSWORD_INPUT}    visible
    Wait For Elements State    ${LOGIN_BUTTON}    visible
    ${url}=    Get Url
    Should Contain    ${url}    ${LOGIN_PATH}

Login With Credentials
    [Arguments]    ${email}    ${password}
    Fill Text    ${LOGIN_EMAIL_INPUT}    ${email}
    Fill Text    ${LOGIN_PASSWORD_INPUT}    ${password}
    Click    ${LOGIN_BUTTON}

Open Registration Page From Login
    Click    ${CREATE_ACCOUNT_LINK}

Submit Empty Login Form
    Click    ${LOGIN_BUTTON}

Invalid Credentials Message Should Be Displayed
    Wait For Elements State    ${LOGIN_ERROR_MESSAGE}    visible
    ${url}=    Get Url
    Should Contain    ${url}    ${LOGIN_PATH}

Invalid Login Email Format Message Should Be Displayed
    Wait For Elements State    ${EMAIL_FORMAT_MESSAGE}    visible

Short Login Password Message Should Be Displayed
    Wait For Elements State    ${PASSWORD_REQUIRED_MESSAGE}    visible

Required Login Messages Should Be Displayed
    Wait For Elements State    ${EMAIL_REQUIRED_MESSAGE}    visible
    Wait For Elements State    ${PASSWORD_REQUIRED_MESSAGE}    visible
    ${url}=    Get Url
    Should Contain    ${url}    ${LOGIN_PATH}
