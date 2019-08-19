import subprocess,os

def run_commands(cmd_array,os_name='posix'):
    process = [subprocess.Popen(cmd,shell=True,cwd=os.getcwd()) for cmd in cmd_array]
        
def run_command(cmd_array,os_name='posix'):
    p = subprocess.Popen(cmd_array,shell=True,cwd=os.getcwd())
    output,err = p.communicate()
    print('output=%s'%output)
    print('err=%s'%err)
    return output

def getOutputFromCommand(cmd):
    out = subprocess.check_output(cmd.split())
    return out

def getStatusOutput(cmd):
    out = subprocess.getstatusoutput(cmd)
    return out