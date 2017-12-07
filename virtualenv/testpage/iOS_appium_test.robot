*** Settings ***
Documentation     An iOS Test Suite for Mobile Web Testing
...               Obtained online from a kind Japanese
Library           Selenium2Library    timeout=10

# Suite Setup
Test Teardown    close browser

*** Keywords ***
Go to google page
    # Insert iOS Desired Capabilities Settings as Dictionary
    # Set platformVersion DeviceName Xcode
    ${caps}=  create dictionary  browserName=safari  platformName=iOS  platformVersion=11.1
    ...                          deviceName=iPhone Simulator

    # Use WebDriver Remote command_executor to Appium's URL
    # desired_capabilities for appium input 
    create webdriver  Remote  command_executor=http://localhost:4723/wd/hub  desired_capabilities=${caps}

    # Open Google webpage
    go to  https://www.google.co.jp/

    # Capture Screenshot of Google Page
    capture page screenshot  filename=result_google_top.png

Google Python and log its links to the console
    ${caps}=  create dictionary  browserName=safari  platformName=iOS  platformVersion=11.1
    ...                          deviceName=iPhone Simulator
    create webdriver  Remote  command_executor=http://localhost:4723/wd/hub  desired_capabilities=${caps}
    go to  https://www.google.co.jp/

    # Check page title if we are at the correct page
    ${page_title} =  get title
    should contain  ${page_title}  Google

    # Input search term Python and hit enter
    input text  name=q  Python
    # Robot Framework Enter Key 
    # https://github.com/robotframework/Selenium2Library/issues/4
    press key  name=q  \\13

    # Sleeps two seconds for async AJAX request/response to happen
    sleep  2sec

    # Check the search results page for its title is Python
    ${result_title} =  get title
    should contain  ${result_title}  Python

    # Capture screen shot for google search results for python
    capture page screenshot  filename=result_google_python.png

    # Start logging to consile
    log to console  ${SPACE}

    # Log search results to console
    @{web_elements} =  get webelements  css=div._a5r > div > div > a
    :for  ${web_element}  in  @{web_elements}
    \  ${text} =  get text  ${web_element}
    \  log to console  ${text}
    \  ${href} =  call method  ${web_element}  get_attribute  href
    \  log to console  ${href}

*** TestCases ***

Use Google for Robotframework testing
    [Tags]  signin
    Go to google page
    Google Python and log its links to the console


