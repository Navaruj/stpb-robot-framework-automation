*** Settings ***
Documentation    Minimal landing-page assertion used by the valid-login test.

*** Variables ***
${USER_LIST_PATH}       /user/list/
${USER_LIST_SEARCH}     css=#btn-search

*** Keywords ***
User List Page Should Be Displayed
    Wait For Elements State    ${USER_LIST_SEARCH}    visible
    ${url}=    Get Url
    Should Contain    ${url}    ${USER_LIST_PATH}
