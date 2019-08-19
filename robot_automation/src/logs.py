import commandRunner as cr
import subprocess
import glob, os, platform, shutil, adb
from pathlib import Path


def combine_browsers_logs(udid):
    cmd = 'rebot -N Combined --outputdir browserlogs/ '

    for idx, device in enumerate(udid):
        #Get all the output.xml files for the devices    
        if platform.system() == "Windows":
            cmd += os.getcwd() + "\\browserlogs\\" + device + "\output.xml "
        else:
            cmd += os.getcwd() + "/browserlogs/" + device + "/output.xml "
    
    cr.run_command(cmd)
    pngs = []

    #For screenshot images
    if platform.system() == "Windows":
        for idx, device in enumerate(udid):
            pngs += glob.glob(os.getcwd() + "\\browserlogs\\" + device + "\\" + "*.png")

            for p in pngs:
                shutil.copy(p, p.replace(device + "\\", ""))
                #remove those that have been moved/copied
                pngs = [p for p in pngs if not p]

    else:    
        for idx, device in enumerate(udid):
            pngs += glob.glob(os.getcwd() + "/browserlogs/" + device + "/" + "*.png")

            for p in pngs:
                shutil.copy(p, p.replace(device + "/", ""))
                #remove those that have been moved/copied
                pngs = [p for p in pngs if not p]

def combine_logs(udid):
    cmd = 'rebot -N Combined --outputdir logs/ '

    for idx, device in enumerate(udid):
        #Get all the output.xml files for the devices    
        if platform.system() == "Windows":
            cmd += os.getcwd() + "\logs\\" + device + "_" + "*\output.xml "
        else:
            cmd += os.getcwd() + "/logs/" + device + "_" + "*/output.xml "
    
    cr.run_command(cmd)
    pngs = []

    #For screenshot images
    if platform.system() == "Windows":
        pngs = glob.glob(os.getcwd() + "\logs\**\*.png")
        for idx, device in enumerate(udid):
            for p in pngs:
                if Path(p).is_file(): #If image exist
                    imgname = p[p.rindex('\\')+1:]
                    k = p.rfind("\logs\\")
                    path = p[:k]
                    newPath = path + "\logs\\" + imgname
                    shutil.move(p,newPath)

    else:    
        pngs = glob.glob(os.getcwd() + "/logs/**/*.png")
        for idx, device in enumerate(udid):
            for p in pngs:
                if Path(p).is_file(): #If image exist
                    imgname = p[p.rindex('/')+1:]
                    k = p.rfind("/logs/")
                    path = p[:k]
                    newPath = path + "/logs/" + imgname
                    shutil.move(p,newPath)

def zip_logs():
    if platform.system() == "Windows":
        cmd = "Compress-Archive logs logs-$(date +%Y-%m-%d-%H%M).zip"
        subprocess.call(["powershell.exe", cmd])

    elif platform.system() == "Linux" or platform.system() == "Darwin":
        cmd = "zip -vr logs-$(date +%Y-%m-%d-%H%M).zip" + " logs/"
        cr.run_command(cmd)  

def zip_browsers_logs():
    if platform.system() == "Windows":
        cmd = "Compress-Archive browserlogs browserlogs-$(date +%Y-%m-%d-%H%M).zip"
        subprocess.call(["powershell.exe", cmd])
    
    elif platform.system() == "Linux" or platform.system() == "Darwin":
        cmd = "zip -vr browserlogs-$(date +%Y-%m-%d-%H%M).zip" + " browserlogs/"
        cr.run_command(cmd)  

def delete_previous_logs():
    cmd = 'rm -rf logs/*'
    cr.run_command(cmd)

def delete_previous_logs_browser():
    cmd = 'rm -rf browserlogs/*'
    cr.run_command(cmd)