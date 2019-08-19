*** Settings ***
Library          SeleniumLibrary
Suite Teardown   Close Browser

*** Variables ***
${APPIUM_PORT}   4723
${APPIUM_SERVER1}    http://localhost:${APPIUM_PORT}/wd/hub
${PLATFORM_VERSION}     8.0
${DEVICE_NAME}  Pixel_2_API_26
${DEVICE_UDID}  e12345678
${DRIVER_PATH}  null

*** Test cases ***
Open android phone
    Setup and open android phone

Test on Google's search page 
    Init
    Take a screenshot on Google's search page

*** Keywords ***
Setup and open android phone
    ${caps}=    create dictionary    platformName=Android    platformVersion=${PLATFORM_VERSION}     udid=${DEVICE_UDID}    deviceName=${DEVICE_NAME}   browserName=chrome  executable_path=${DRIVER_PATH}
    create webdriver    Remote    command_executor=${APPIUM_SERVER1}    desired_capabilities=${caps}  

Init
    Register Keyword To Run On Failure    Capture Page Screenshot With Unique Name

Capture Page Screenshot With Unique Name
    ${filename} =  Catenate  ${DEVICE_UDID}Screenshot.png
    capture page screenshot  filename=${filename}

Take a screenshot on Google's search page
    go to  https://www.google.com/

    input text  name=q  Python

    click element  //*[@id="tsf"]/div[2]/div[1]/div[1]/button[2]

    sleep  5sec

    ${result_title} =  get title
    should contain  ${result_title}  Python

    sleep  5sec

    ${filename} =  Catenate  ${DEVICE_UDID}google_search_android.png
    capture page screenshot  filename=${filename}
    