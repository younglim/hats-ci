# hats-ci
An installer that consists of a series of PowerShell scripts which downloads and installs relevant dependencies and packages.
A virtual environment will be set up and configured in your local machine as well which will be ready for Robot Framework testing.

## Getting started
### For Windows
1. Navigate to `virtualenv` directory 
2. Run `00_Install_and_Run_Robot.bat` to download and install the packages - a demo Robot test will run at the end as well to verify that the installation has been successful 
3. Navigate to `virtualenv/shell` directory
4. Run `hats_shell.cmd` and you are ready to run any pybot commands and start testing with your Robot scripts!
5. You can also run `hats_shell` from Command Prompt or Powershell.

#### Uninstall
1. From Command Prompt or Powershell, run `hats_shell uninstall` .

### For Mac
1. Navigate to `macrobot`
2. Run `install-robot.sh`
3. Start testing!
