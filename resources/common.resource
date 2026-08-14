*** Settings ***
Documentation    Shared Browser Library setup, teardown, and authentication keywords.
Resource         ../variables/dev.robot
Library          Browser    enable_presenter_mode=${PRESENTER_MODE}
Resource         pages/login_page.resource

*** Keywords ***
Open STPB Browser
    Open STPB Browser At    ${STPB_LOGIN_URL}
    Login Page Should Be Displayed

Open STPB Browser At
    [Arguments]    ${url}
    Set Browser Timeout    ${DEFAULT_TIMEOUT}
    New Browser    ${BROWSER}    headless=${HEADLESS}
    New Context    viewport={'width': 1440, 'height': 1000}
    New Page    ${url}

Close STPB Browser
    Run Keyword If Test Failed    Take Screenshot
    Close Browser

Login As Demo User
    Login With Credentials    ${DEMO_EMAIL}    ${DEMO_PASSWORD}
