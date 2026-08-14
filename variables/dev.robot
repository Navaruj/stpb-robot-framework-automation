*** Variables ***
${STPB_BASE_URL}        https://automate-test.stpb-digital.com
${STPB_LOGIN_URL}       ${STPB_BASE_URL}/login/
${STPB_REGISTER_URL}    ${STPB_BASE_URL}/register/
${BROWSER}              chromium
${HEADLESS}             ${False}
${PRESENTER_MODE}       ${False}
${DEFAULT_TIMEOUT}      15 seconds

# Public demo account displayed on the STPB practice login page.
${DEMO_EMAIL}           user.test@krupbeam.com
${DEMO_PASSWORD}        jKNsrapwLNV7eBN
