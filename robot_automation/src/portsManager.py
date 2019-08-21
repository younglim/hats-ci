import random

def get_scrcpy_port(instance):
    sport = random.randint(47183,47500)
    if sport in instance.getScrcpyInstances():
        get_scrcpy_port()
        print(sport + " port is in use.")
        print("Finding a new scrcpy port")
    return sport

def get_appium_port(instance):
    port = random.randint(4723,4999)
    if port in instance.getAppiumInstances():
        instance.get_appium_port()
        print(port + " port is in use.")
        print("Finding a new appium port")
    return port

def get_bootstrap_port(instance):
    bport = random.randint(2251,2999)
    if bport in instance.getBootstrapInstances():
       instance.get_bootstrap_port(instance)
       print(bport + " port is in use.")
       print("Finding a new bootstrap port")
    return bport

