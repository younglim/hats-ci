import commandRunner as cr
import portsManager as pm

class InstanceManager:
    
    def __init__(self):
        self.udids=[]
        self.appiumInstances=[]
        self.bootstrapInstances=[]
        self.scrcpyInstances=[]

    def getAppiumInstances(self):
        return self.appiumInstances

    def getAppiumInstanceByIndex(self,idx):
        return self.appiumInstances[idx]

    def getBootstrapInstances(self):
        return self.bootstrapInstances

    def getScrcpyInstances(self):
        return self.scrcpyInstances

    def getUdids(self):
        return self.udids

    def setUdids(self, udids):
        self.udids = udids

    def addAppiumInstance(self,instance):
        self.appiumInstances.append(instance)

    def addBootstrapInstance(self,instance):
        self.bootstrapInstances.append(instance)

    def addScrcpyInstance(self,instance):
        self.scrcpyInstances.append(instance)

    def start_appium_instances(self,udid):
        cmds=[]
        for o in udid:
            # Get the port
            port = pm.get_appium_port(self)
            bport = pm.get_bootstrap_port(self)

            print("Running appium on port " + str(port))
            cmd = "appium --address 127.0.0.1 --port " + str(port) +  " --bootstrap-port " + str(bport) + " --command-timeout 3000 " 

            cmds.append(cmd)
            self.addAppiumInstance(port)
            self.addBootstrapInstance(bport)

        cr.run_commands(cmds)
