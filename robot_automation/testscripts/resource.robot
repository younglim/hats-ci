*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${BROWSER}        Safari
${DELAY}          0
${SEARCH URL}     https://www.google.com/

*** Keywords ***
Open Browser To Search Page
    Open Browser    ${SEARCH URL}    ${BROWSER}
    Set Selenium Speed    ${DELAY}
    Search Page Should Be Open

Search Page Should Be Open
    ${page_title} =  get title
    should contain  ${page_title}  Google

Take a screenshot on Google's search page
    input text  name=q  Python
    Press Key    name=q    \\13

    sleep  5sec

    ${result_title} =  get title
    should contain  ${result_title}  Python

    capture page screenshot  filename=google_search_${BROWSER}.png