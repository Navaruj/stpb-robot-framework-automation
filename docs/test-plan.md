# STPB Robot Framework Test Plan

## Objective

Validate the core login and public registration UI of the STPB practice application with browser tests derived from the supplied practice test-case sheet.

## Scope

- Login page controls, client-side validation, valid login, invalid login, and registration navigation
- Registration page controls, Reset, validation, radio button, checkbox, dropdown, and registration confirmation modal

## Out of scope

- Performance, security, and accessibility testing
- Validation of third-party services
- Clicking OK on the registration confirmation modal or verifying post-registration navigation

## Test cases

| ID | Test case | Expected result |
| --- | --- | --- |
| LOGIN-01 | Login page controls | Heading, Email, Password, Login, and Create an account are visible |
| LOGIN-04 | Invalid email format | `email must be a valid email` is shown |
| LOGIN-06 | Short password | `password must be at least 5 characters` is shown |
| LOGIN-07 | Valid login | User is redirected to `/user/list/` |
| LOGIN-08 | Invalid credentials | Error is shown and user remains on login page |
| LOGIN-09 | Empty login submission | Required-field messages are shown |
| LOGIN-10 | Create an account link | User is taken to `/register/` |
| REGISTER-01 | Registration page controls | Main form controls and Sign up are visible |
| REGISTER-03 | Reset | Entered Firstname is cleared |
| REGISTER-05 | Missing Firstname | The required-field message is shown |
| REGISTER-09 | Invalid registration email | `Invalid email address` is shown |
| REGISTER-15 | Gender choice | Selecting Male replaces Female |
| REGISTER-16-19 | Skill checkboxes | SQL, Manual, Automate Test, and Automate Test2 can be selected |
| REGISTER-21-23 | Dropdowns | Thai, Admin, and Basic are selected |
| REGISTER-24 | Successful registration | A unique user is submitted and the `Register Success` popup is shown; OK is not clicked |
| REGISTER-25 | Empty registration submission | Required-field messages are shown across the form |

## Test-data policy

- Login uses the public demo credentials displayed by the practice website.
- The successful-registration test generates an email such as `robot.qa.<timestamp>@example.com` at runtime. It creates one practice user record per execution.
- The successful-registration test is tagged `data-creates` so it is identifiable in reports and can be excluded deliberately when needed.

## Execution

```bash
robot --outputdir results tests
```

Headless execution:

```bash
robot --variable HEADLESS:true --outputdir results tests
```
