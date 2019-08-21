*** Settings ***
Library         ./src/hats.py

*** Keywords ***
Start Appium Server and Tests for Android Web
    [Arguments]     ${robotFile}
    startAndroidWeb           ${robotFile}

Start Appium Server and Tests for Android App
    [Arguments]     ${robotFile}
    startAndroidApp     ${robotFile}

Start Appium Server and Tests for Web
    [Arguments]     ${robotFile}
    startWeb        ${robotFile}

Clear All Logs
    clearLogs
    clearLogsBrowser

*** Test Cases ***
Setup Appium Server
    Clear All Logs
    #Start Appium Server and Tests for Android Web    ./testscripts/android.robot
    Start Appium Server and Tests for Web    ./testscripts/web_test.robot
    #Start Appium Server and Tests for Android App    ./testscripts/android_app.robot

