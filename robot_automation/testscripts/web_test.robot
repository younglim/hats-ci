*** Settings ***
Documentation     A test suite with a single test for valid login.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          resource.robot

*** Test Cases ***
Test on Google's search page
    Open Browser To Search Page
    Search Page Should Be Open
    Take a screenshot on Google's search page
    [Teardown]    Close Browser