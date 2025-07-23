*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}         https://www.saucedemo.com/v1/
${BROWSER}     chrome
${USERNAME}    standard_user
${PASSWORD}    secret_sauce
${WRONG_USER}  wrong_user
${WRONG_PASS}  wrong_pass

*** Test Cases ***
Login With Valid Credentials
    Open Browser    ${URL}    ${BROWSER}
    Input Text    id:user-name    ${USERNAME}
    Input Text    id:password     ${PASSWORD}
    Click Button  id:login-button
    Wait Until Page Contains Element    xpath://div[text()='Products']    timeout=5s
    Capture Page Screenshot
    Close Browser

Login With Invalid Credentials
    Open Browser    ${URL}    ${BROWSER}
    Input Text    id:user-name    ${WRONG_USER}
    Input Text    id:password     ${WRONG_PASS}
    Click Button  id:login-button
    Wait Until Page Contains Element    xpath://h3[contains(text(),'Epic sadface')]    timeout=5s
    Capture Page Screenshot
    Close Browser

Login With Correct Username But Wrong Password
    Open Browser    ${URL}    ${BROWSER}
    Input Text    id:user-name    ${USERNAME}
    Input Text    id:password     ${WRONG_PASS}
    Click Button  id:login-button
    Wait Until Page Contains Element    xpath://h3[contains(text(),'Epic sadface')]    timeout=5s
    Capture Page Screenshot
    Close Browser

Login With Wrong Username But Correct Password
    Open Browser    ${URL}    ${BROWSER}
    Input Text    id:user-name    ${WRONG_USER}
    Input Text    id:password     ${PASSWORD}
    Click Button  id:login-button
    Wait Until Page Contains Element    xpath://h3[contains(text(),'Epic sadface')]    timeout=5s
    Capture Page Screenshot
    Close Browser

Login With Empty Username And Password
    Open Browser    ${URL}    ${BROWSER}
    Click Button  id:login-button
    Wait Until Page Contains Element    xpath://h3[contains(text(),'Epic sadface')]    timeout=5s
    Capture Page Screenshot
    Close Browser
