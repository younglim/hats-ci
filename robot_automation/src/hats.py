import subprocess, platform, random, os, threading
from time import sleep
from instanceManager import InstanceManager
import adb
import portsManager as pm
import recordings as recorder
import logs
import commandRunner as cr
import testRunner

udid=[]
im = InstanceManager()

def startAndroidWeb(robotFile):
    udid = adb.get_udids_of_all_android_phones()
    # Start appium server for each of the phone
    im.start_appium_instances(udid)
    sleep(10)

    recorder.start_screenrecording(im,udid)
    testRunner.run_tests_on_devices(im, udid,robotFile)
    recorder.stop_screenrecordings(im,udid)
    recorder.convert_screenrecordings(udid)

    logs.combine_logs(udid)
    sleep(5)
    logs.zip_logs()
    cleanup()

def startAndroidApp(robotFile):
    udid = adb.get_udids_of_all_android_phones()
    # Start appium server for each of the phone
    im.start_appium_instances(udid)
    sleep(10)

    recorder.start_screenrecording(im,udid)
    testRunner.run_tests_on_devices(im, udid,robotFile)
    recorder.stop_screenrecordings(im,udid)
    recorder.convert_screenrecordings(udid)
    
    sleep(5)

    logs.combine_logs(udid)
    logs.zip_logs()
    cleanup()

def startWeb(robotFile):
    udid = testRunner.getBrowserToTestOn()
    # # Start appium server for each of the browser
    im.start_appium_instances(udid)
    sleep(10)
    #recorder.start_desktoprecording()
    testRunner.run_tests_on_browsers(udid,robotFile)
    #recorder.stop_desktoprecording()

    sleep(3)
    logs.combine_browsers_logs(udid)
    logs.zip_browsers_logs()
    cleanup()

def clearLogs():
    logs.delete_previous_logs()

def clearLogsBrowser():
    logs.delete_previous_logs_browser()
    
def cleanup():
    if platform.system() == "Linux" or platform.system() == "Darwin":
        for o in im.getAppiumInstances():
            #cmd = "kill -9 $(lsof -t -i tcp:" + str(o) + ")"
            cmd = "lsof -ti:" + str(o) + " | xargs kill"
            #cmd = "npx kill-port " + str(o)
            sleep(3)
            cr.run_command(cmd)

        for b in im.getBootstrapInstances():
            cmd = "lsof -ti:" + str(b) + " | xargs kill"
            #cmd = "npx kill-port " + str(b)
            cr.run_command(cmd)

    elif platform.system() == "Windows":
        for o in im.getAppiumInstances():    
            #Get only PID
            cmd = "for /f \"tokens=5\" %a in ('netstat -aon ^| find \":"
            cmd += str(o)
            cmd += "\" ^| find \"LISTENING\"\') do taskkill /f /pid %a"
            cr.run_command(cmd)

        for b in im.getBootstrapInstances():    
            cmd = "for /f \"tokens=5\" %a in ('netstat -aon ^| find \":"
            cmd += str(b)
            cmd += "\" ^| find \"LISTENING\"\') do taskkill /f /pid %a"
            cr.run_command(cmd)

if __name__ == "__main__":
    #startWeb('web_test.robot')
    startAndroidWeb('android.robot')
    pass






