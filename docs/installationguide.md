---
# Installation Guide
---
Operating Systems
- Windows 7, 8.1, 10 (64-bit)

- Mac OS X El-Capitan, macOS Sierra, High Sierra, Mojave

- Linux CentOS, Fedora, Ubuntu

Steps recommended for quickly getting started on automated testing based on your operating system

## Windows
1. Download the [latest release](https://github.com/GovTechSG/hats-ci/releases)

2. Run hats_for_Windows_xx.exe
   - Administrator rights is required for first install

   - Changes will be made to your PATH variable and registry to allow hats to run

3. After installation, restart your computer

4. Open your command prompt/power shell and run `hats_shell` to load the virtual environment

## Mac OS
1. Ensure that you have Xcode installed before installing hats

2. Open Xcode for the first time and click agree. (Skip this step if Xcode was previously used)

3. Make sure Google Chrome and Firefox have been installed prior (and at least opened once to overcome Apple's security popup)

4. Open your terminal and run the following command
   
   `bash <(curl -s https://raw.githubusercontent.com/GovTechSG/hats-ci/master/assets/mac-installer.sh)`

5. Enter your login password when prompted

6. Installation will take about 20-30mins

7. After installation, re-open your terminal and ensure that `(hats)` virtual environment has loaded

## Linux 
For Ubuntu, run `bash <(curl -s https://raw.githubusercontent.com/younglim/hats-linux/master/assets/ubuntu-installer.sh)`

For CentOS/7 and Fedora, navigate to (link here) for more details


## After Installation
Once you have completed the installation, you have two options
1. [Click here](prerequisites.md) execute the sample test scripts provided to see how HATS works

2. [Click here](robotframework.md) to learn how to create your own robot test script and execute them