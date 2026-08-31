# STPB Robot Framework Test Automation

[![Robot Framework Tests](https://github.com/Navaruj/stpb-robot-framework-automation/actions/workflows/robot-tests.yml/badge.svg)](https://github.com/Navaruj/stpb-robot-framework-automation/actions/workflows/robot-tests.yml)

Portfolio project for web UI test automation using Robot Framework and Browser Library against the [STPB practice application](https://automate-test.stpb-digital.com/login/).

## Highlights

- Sixteen tests covering login and registration UI flows from the supplied practice test-case sheet
- Page-oriented reusable keywords and centralized locators
- Explicit waits instead of fixed sleeps
- Automatic screenshots when a test fails
- Headless execution for GitHub Actions
- One explicitly tagged success test creates a unique practice user and verifies the Register Success popup

## Test coverage

- Seven Login cases: page controls, validation, valid/invalid authentication, and registration navigation
- Nine Register cases: page controls, reset, validation, gender, skills, dropdowns, and success confirmation

See [the test plan](docs/test-plan.md) for expected results and scope.

## Project structure

```text
tests/                  Business-readable test cases
resources/common.resource
                        Shared browser setup and teardown
resources/pages/        Page locators and reusable keywords
variables/dev.robot     Environment and public demo account variables
docs/test-plan.md       Test scope and expected results
results/                Generated Robot reports (ignored by Git)
```

## Requirements

- Python 3.10 or newer
- Node.js 20 or newer

## Setup

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
rfbrowser init
```

## Run all tests

Visible Chromium:

```bash
robot --outputdir results tests
```

Headless Chromium:

```bash
robot --variable HEADLESS:true --outputdir results tests
```

The full local command includes the one `data-creates` registration test. GitHub Actions excludes that tag to avoid adding a practice user on every push or pull request.

Run only smoke tests:

```bash
robot --include smoke --outputdir results tests
```

## Watch the browser steps

Use Presenter Mode when learning or demonstrating a test. It highlights the active element, shows the Robot keyword being executed, and pauses briefly between actions.

```bash
robot --variable PRESENTER_MODE:true --outputdir results --test "User Can Login With Valid Credentials" tests/authentication/login_tests.robot
```

Leave `PRESENTER_MODE` as `False` for normal fast execution and CI.

After execution, open `results/report.html` for the summary and `results/log.html` for keyword-level details.

## Test data note

The login credentials in `variables/dev.robot` are the public demo credentials displayed by the STPB practice website. Do not use personal credentials in this project.

The `Successful Registration Displays Confirmation Modal` test generates a unique `@example.com` email and creates a practice record. It is tagged `data-creates`; it verifies the popup but does not click OK.

## Disclaimer

This is an independent learning portfolio project and is not affiliated with the STPB website owner.
