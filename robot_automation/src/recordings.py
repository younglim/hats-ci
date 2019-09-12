import os, threading, platform
import commandRunner as cr
import portsManager as pm
import helper

def start_desktoprecording():
    cmd = 'ffmpeg -f avfoundation -i "1" -pix_fmt yuv420p -r 60  -preset ultrafast  -loglevel quiet ' + os.getcwd() + "/browserlogs/" + "browser_VR.mp4 -vf mpdecimate "    
    t = threading.Thread(target=cr.run_command, args = (cmd,))
    t.daemon = True
    t.start()

def stop_desktoprecording():
    cmd = "pkill ffmpeg"
    t = threading.Thread(target=cr.run_command, args = (cmd,))
    t.daemon = True
    t.start()

def convert_screenrecordings(udid):
    for o in udid: 
        if platform.system() == "Linux":
            cmd = "ffmpeg -i " + os.getcwd() + "/logs/" + o + ".mp4" + " -c:v copy " + os.getcwd() + "/logs/" + o + "_VR.mp4"
            cr.run_command(cmd)
            os.remove(os.getcwd() + "/logs/" + o + ".mp4")
            # Convert using ffmpeg and remove old files with encoding issues on linux 

def stop_screenrecordings(im,udid):
    if helper.hasScrcpy():
        if platform.system() == "Linux" or platform.system() == "Darwin":
            for s in im.getScrcpyInstances():
                cmd = "lsof -ti:" + str(s) + " | xargs kill"
                #cmd = "npx kill-port " + str(s)
                cr.run_command(cmd)
        
        elif platform.system() == "Windows":
            for s in im.getScrcpyInstances():    
                cmd = "for /f \"tokens=5\" %a in ('netstat -aon ^| find \":"
                cmd += str(s)
                cmd += "\" ^| find \"LISTENING\"\') do taskkill /f /pid %a"
                cr.run_command(cmd)

def start_screenrecording(im,udid):
    if helper.hasScrcpy():
        for o in udid: 
            sport = pm.get_scrcpy_port(im)
            print("Starting scrcpy screen recording") 
            #cmd = "scrcpy --no-display " + "--serial " + o + " --record " + "logs/" + o + ".mp4 -p " + str(sport) 

            if platform.system() == "Windows":
                cmd = "scrcpy -b 1M -m 800 --serial " + o + " --record " + "logs\\" + o + ".mp4 -p " + str(sport)     
            else:
                cmd = "scrcpy -b 1M -m 800 --serial " + o + " --record " + "logs/" + o + ".mp4 -p " + str(sport) 

            im.addScrcpyInstance(sport)
            t = threading.Thread(target=cr.run_command, args = (cmd,))
            t.daemon = True
            t.start()