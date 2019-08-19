import commandRunner as cr
import threading, adb, platform, os, sys, subprocess
import chromeDriver as cd
from time import sleep

def run_tests_on_browsers(udid, robotFile):
    threads=[]
    cmds=[]

    for idx, browser in enumerate(udid):
        cmd = "robot --variable BROWSER:" + browser +  " --outputdir browserlogs/" + browser  + " --name " + browser + " " + robotFile
        cmds.append(cmd)

        t = threading.Thread(target=cr.run_command, args = (cmd,))
        t.daemon = True
        threads.append(t)

    for x in threads:
        x.start()
        sleep(3)

    for x in threads:
        x.join()


# needs instance manager and adb
def run_tests_on_devices(im, udid, robotFile):
    threads=[]
    cmds=[]

    for idx, device in enumerate(udid):
        chromeVersion = adb.get_chrome_version(device)     
        if chromeVersion==None: #No Chrome installed. Skip running on this phone
            cmd = "adb -s " + str(device) + " install -r ./apks/com.android.chrome.apk"
            cr.run_command(cmd)
            sleep(2)

        #reset cmd
        cmd=""
        driverPath = cd.get_chromedriver_path(chromeVersion)
        cmd = "robot --variable PLATFORM_VERSION:" + str(adb.get_platform_version_of_android_phone(device)) + " --variable DEVICE_UDID:" + str(device) + " --variable APPIUM_PORT:" + str(im.getAppiumInstanceByIndex(idx)) + " --variable DRIVER_PATH:" + driverPath + " --outputdir logs/" + device + "_" + adb.get_model_of_android_phone(device) + " --name " + adb.get_model_of_android_phone(device) + " " + robotFile
        cmds.append(cmd)

        t = threading.Thread(target=cr.run_command, args = (cmd,))
        t.daemon = True
        threads.append(t)

    for x in threads:
        x.start()
        sleep(3)

    for x in threads:
        x.join()


def getBrowserToTestOn():
    if platform.system() == "Darwin": #MacOS. Append firefox, chrome and safari into udid
        udid = ["Firefox","Chrome","Safari"]
    
    elif platform.system() == "Windows":
        udid = ["Firefox","Chrome","Edge","IE"]

    else:
        print(os.environ["PATH"])

        path = "/home/ubuntu/robot_automation/drivers"
        os.environ["PATH"] += os.pathsep + path

        #os.environ["PATH"] = "/home/ubuntu/robot_automation/drivers:" + os.getenv("PATH")
        
        #os.path(path)

        print(os.environ["PATH"])
        #cmd = "export PATH=$PATH:/home/ubuntu/robot_automation/drivers"
        #cr.run_command(cmd)
        #print(cmd)
        
        #app_path = "/home/ubuntu/robot_automation/drivers"
        #print(app_path)
        #print(os.pathsep)
        #os.environ["PATH"] += os.pathsep + app_path
        udid = ["headlessfirefox","headlesschrome"]

    return udid