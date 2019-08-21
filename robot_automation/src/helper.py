import commandRunner as cr

def hasScrcpy():
    cmd='scrcpy --v'
    try:
        out = cr.getOutputFromCommand(cmd)
        return True
    except:
        return False
