---
# About Robot Framework
---

**You will learn how to:**
* Write robot scripts using robot framework

## Why Robot Framework?
[Robot Framework](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html) is a Python-based, keyword-driven automation framework for testing. 

- Easy to use syntax to create test cases

- Reusable high-level keywords

- Provides easy-to-read result reports and logs in HTML format

## Components of a Robot File
|    Section    |                             Used for                        | 
| :-----------: |-------------------------------------------------------------|
|   Settings    |  Import test libraries, resource files and variable files   |
|   Variables   |  Variables that can be used elsewhere in the data           |
|   Test Cases  |  Variables that can be used elsewhere in the data           |
|   Keywords    |  Create user keywords for existing lower-level keywords     |
|   Comments    |  Ignored by Robot Framework                                 |

## How To Create Settings
   ```robotframework
   *** Settings ***
   Library           SeleniumLibrary
   Suite Teardown    Close Browser
   ```

## How To Create Variables
   ```robotframework
   *** Variables ***
   ${APPIUM_PORT}         4723
   ${APPIUM_SERVER1}      http://localhost:${APPIUM_PORT}/wd/hub
   ${PLATFORM_VERSION}    8.0
   ${DEVICE_NAME}         Pixel_2_API_26
   ${DEVICE_UDID}         e12345678
   ${DRIVER_PATH}         null
   ```

## How To Use Selenium Keywords
**Tip: Leave at least 2 spacing between each words**

Click here to find out more about [Selenium](http://robotframework.org/SeleniumLibrary/SeleniumLibrary.html) keywords

1. Create Webdriver
   ```robotframework
   ${caps}=    create dictionary    platformName=Android    platformVersion=${PLATFORM_VERSION}     udid=${DEVICE_UDID}    deviceName=${DEVICE_NAME}   browserName=chrome  executable_path=${DRIVER_PATH}
   create webdriver    Remote    command_executor=${APPIUM_SERVER1}    desired_capabilities=${caps}  
   ```

2. Go To
   ```robotframework
   Go to    https://www.google.com/
   ```

3. Input Text
   ```robotframework
   Input Text    name=q    Python
   ```

4. Click Element
   ```robotframework
   Click Element    //*[@id="tsf"]/div[2]/div[1]/div[1]/button[2]
   ``` 

5. Sleep
   ```robotframework
   Sleep    5sec
   ```

6. Should Contain
   ```robotframework
   ${result_title} =  get title
   should contain  ${result_title}  Python
   ```

7. Capture Page Screenshot
   ```robotframework
   ${filename} =  Catenate  ${DEVICE_UDID}google_search_android.png
   capture page screenshot  filename=${filename}
   ```

## How To Create Custom Keywords
After learning how to use selenium keywords, let us put these keywords together to create custom keywords.

**Select your IDE**

1. [Eclipse IDE](https://eclipse.org/)  with [RED plugin](https://github.com/nokia/RED). 
   - Open command prompt/terminal and type `red` in hats_shell to begin
2. [Visual Studio Code](https://code.visualstudio.com/)
   - Enable Robot Framework Intellisense Extension
3. [Pycharm IDE](https://www.jetbrains.com/pycharm/) with [IntelliBot plugin](https://plugins.jetbrains.com/plugin/7386-intellibot)

4. [Notepad++](https://notepad-plus-plus.org/)


**Get ready to write your robot script**
1. Open up your IDE (E.g. Visual Studio,Eclipse IDE)

2. Prepare the environment to run the robot script by copying the following codes to your IDE. 
   Add in at least four spacing between each element.

   ```robotframework
   *** Settings ***
   Library           SeleniumLibrary
   Suite Teardown    Close Browser
   
   *** Variables ***
   #These are placeholders. HATS will detect all the devices connected and automatically create appium ports
   ${APPIUM_PORT}         4723
   ${APPIUM_SERVER1}      http://localhost:${APPIUM_PORT}/wd/hub
   ${PLATFORM_VERSION}    8.0
   ${DEVICE_NAME}         Pixel_2_API_26
   ${DEVICE_UDID}         e12345678
   ${DRIVER_PATH}         null
   ```
3. Add in keywords to set up the android phone. 

   ```robotframework
   *** Keywords ***
   Setup and open android phone
       ${caps}=    create dictionary    platformName=Android    platformVersion=${PLATFORM_VERSION}     udid=${DEVICE_UDID}    deviceName=${DEVICE_NAME}    browserName=chrome  executable_path=${DRIVER_PATH}    
       create webdriver    Remote  command_executor=${APPIUM_SERVER1}    desired_capabilities=${caps}  
    ```


4. After adding in `Setup and open android phone` keyword, add in the keyword `Take a screenshot on Google's search page` to run the test and take a screenshot of Google's search page
    
   ```robotframework
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
    ```

## How To Create Test Cases
Now to use the keywords created, let us create two test cases namely `Open android phone` and `Test on Google's search page`. 

These test cases will use the custom keywords - `Setup and open android phone` and `Take a screenshot on Google's search page` created in the previous section. 

   ```robotframework
   *** Test cases ***
   Open android phone
       Setup and open android phone
   Test on Google's search page 
       Take a screenshot on Google's search page

   ```

Congrats! You have completed our quick start guide on Robot Framework. 

To execute your test script check out this [section](prerequisites.md).