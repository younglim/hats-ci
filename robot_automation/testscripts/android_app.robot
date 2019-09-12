*** Settings ***
Library           AppiumLibrary
Suite Teardown   Close Application

*** Variables ***
${APPIUM_PORT}   4723
${APPIUM_SERVER}    http://localhost:${APPIUM_PORT}/wd/hub
${PLATFORM_VERSION}     8.0
${DEVICE_NAME}  Pixel_2_API_26

*** Test cases ***
Open android phone
    setup and open android phone

*** Keywords ***
setup and open android phone
    Open Application  ${APPIUM_SERVER}  platformName=Android  platformVersion=${PLATFORM_VERSION}  deviceName=${DEVICE_NAME}  app=./apks/OneMap_v2.0.13.apk  appPackage=sg.onemap.android.onemap2  appActivity=sg.onemap.android.onemap2.activities.OneMap2
    #Click Element     xpath=//*[@id='sg.onemap.android.onemap2:id/tv_skip']

    Click Element      xpath=//android.widget.TextView[@text='Skip']
