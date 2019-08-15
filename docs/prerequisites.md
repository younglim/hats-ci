---
# Run robot scripts using hats-ci 
---

**Objectives:**
* Get started with Hats-ci

* Run robot scripts using Hats-ci

* View logs and recordings generated

## Step 0. Pre-requisites
* Ensure that you have already downloaded the latest version of [hats-ci](https://github.com/younglim/hats-ci)

* Downloaded [Scrcpy](https://github.com/Genymobile/scrcpy) - For screen mirroring and recording (Optional)

* Downloaded the web browsers (E.g. Google Chrome, Microsoft Edge) that you want to test on 

* Have a basic understanding of [robot framework](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html) 


## Step 1. Check out the folder structure

After downloading the latest version of hats-ci, you will see hats folder.

Navigate to the robot_automation folder as shown below to explore the folder structure

    hats
    ├── robot_automation        
    │   ├── browserlogs              # Logs for web browsers (E.g. Chrome, Firefox)
    │   ├── drivers                  # Chrome Drivers for Windows, Mac and Linux
    |   ├── hatslib.robot            # Main Robot Script
    |   ├── logs                     # Logs for mobile devices (E.g. Android)
    |   ├── src                      # Python Source files
    │   └── testscripts              # Sample Robot Test Scripts
    |       ├── web_test.robot       # For browser automation
    |       ├── resource.robot
    |       ├── android.robot        # For android google chrome
    |       └── android_app.robot    # For android mobile applications
    └── ...

Congrats! You are now ready to execute your test scripts

To execute your test script check out the next [section](executing.md).