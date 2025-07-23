*** Settings ***
Library    SeleniumLibrary
Suite Setup     Open Browser To Login Page
Suite Teardown  Close Browser

*** Variables ***
${URL}         https://www.saucedemo.com/v1/
${BROWSER}     chrome
${USERNAME}    standard_user
${PASSWORD}    secret_sauce

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Login With Valid Credentials
    Input Text    id:user-name    ${USERNAME}
    Input Text    id:password     ${PASSWORD}
    Click Button  id:login-button
    Wait Until Page Contains    Products    timeout=5s

Add First Item To Cart
    Click Button    xpath:(//button[contains(text(),'ADD TO CART')])[1]
    Click Link      class=shopping_cart_link
    Wait Until Element Is Visible    xpath://a[text()='CHECKOUT']    timeout=5s
    Click Element                    xpath://a[text()='CHECKOUT']

Proceed To Checkout
    Click Element   xpath://a[text()='CHECKOUT']
    Input Text      id=first-name     Test
    Input Text      id=last-name      User
    Input Text      id=postal-code    12345
    Click Button    id=continue
    Wait Until Page Contains    Checkout: Overview
    Click Button    id=finish
    Wait Until Page Contains    THANK YOU FOR YOUR ORDER

Logout From App
    Click Button    id=react-burger-menu-btn
    Capture Page Screenshot
    Sleep    1s
    Click Button    xpath://button[text()='CHECKOUT']
    Click Link      id=logout_sidebar_link
    Wait Until Page Contains    Login

*** Test Cases ***
Full Purchase Flow With Logout
    Login With Valid Credentials
    Add First Item To Cart
    Proceed To Checkout
    Logout From App
