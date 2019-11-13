#!/bin/bash

echo -e "\n=========================="
echo -e "hats for Mac Web Installer"
echo -e "==========================\n"

original_directory=`pwd`

if [ -d "hats-for-mac" ]; then
	rm -rf hats-for-mac
fi

mkdir hats-for-mac
cd hats-for-mac

# Uncomment below and comment `svn` during dev
#cp -R ../../macrobot . 

# Check if xcode is configured
xcode-select -p &> /dev/null
if [ $? -ne 0 ];
then
	echo "Switching Xcode to $(find /Applications/Xcode*.app -maxdepth 0 -type d)"
	xcode-select -s $(find /Applications/Xcode*.app -maxdepth 0 -type d) 
fi

svn checkout https://github.com/younglim/hats-ci/trunk/macrobot
cd macrobot

installer_directory=`pwd`

./install-hats.sh

cd $original_directory
rm -rf $installer_directory

. ~/.bash_profile
