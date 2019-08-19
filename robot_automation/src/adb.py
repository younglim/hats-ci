import commandRunner as cr
import re

def get_udids_of_all_android_phones():
    cmd='adb devices'
    out = cr.getOutputFromCommand(cmd)
    udids=[]
    for o in out.decode().split('\n'):
        for id in o.split('\t'):
            if((id.find("device") == -1) and id.strip()):
                id=id.replace('\n','')
                id=id.replace('\r','')
                udids.append(id)
    return udids

def get_model_of_android_phone(udid):
    cmd = 'adb -s '+str(udid)+'  shell getprop  ro.product.model'
    model = cr.getStatusOutput(cmd)
    model = model[1].replace(" ", "_")
    return model

def get_platform_version_of_android_phone(udid):
    cmd = 'adb -s '+str(udid)+'  shell getprop  ro.build.version.release'
    platform_version = cr.getStatusOutput(cmd)
    return platform_version[1]

def get_chrome_version(udid):
    cmd = 'adb -s '+udid+'  shell dumpsys package com.android.chrome | grep versionName'
    out = cr.getStatusOutput(cmd)
    o = out[1].split('\n')[0]
    if (o.strip()):
        o=o.replace('\n','')
        o=o.replace('\r','')
        return ''.join(re.findall ('\d+\.\d+\.\d+', o))
