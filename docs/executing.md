## Step 2. Execute hats.lib

**Windows**
1. Load hats virtual environment on your command prompt by running `hats_shell`

2. Navigate to the robot_automation folder by running the following command on your command prompt
   ```
   cd C:\Program Files\hats\robot_automation
   ```

**Mac**
1. Open a terminal and ensure that `(hats)` virtual environment has loaded

2. Navigate to the robot_automation folder

**Execute hats.lib**
3. Run the main robot script to execute the other robot test scripts
   ```
   robot hatslib.robot
   ```
   The sample robot test scripts that can be executed by hatslib.robot are shown below
   
   <img src="https://imgur.com/mEFPTll.png" width="500">
   
4. Review our snippet of hatslib.robot (Main robot script)
   
   <img src="https://imgur.com/jV2GJQ1.png" width="600">
   
   *Note: You may also add in our sample Android_app.robot test script to see how android automation works on mobile applications


## Step 3. Android automation in session

1. Ensure that you are connected to at least one android device by running `adb devices`on your command prompt/terminal

2. If you are connected to this device for the first time using [adb](https://developer.android.com/studio/command-line/adb), allow [usb debugging](https://developer.android.com/studio/debug/dev-options#debugging)

   <img src="https://imgur.com/6xls19Q.png" width="200">

3. Once you run hatslib.robot (main robot script), the robot test scripts located within the test scripts folder are executed

4. It will run the first robot test script - android.robot

5. If Scrcpy is downloaded, Scrcpy will launch the display of the connected android device 

6. You should see the test being executed when the google chrome mobile application is launched


## Step 4. Browser automation in session

1. Once android.robot has completed running, it will move on to the second robot test script - web_test.robot

2. The test will be executed and multiple web browser will launch at the same time