#!/bin/bash

echo -e "\n=========================="
echo -e "hats for Mac Web Installer"
echo -e "==========================\n"

original_directory=`pwd`

if [ -d "hats-for-mac" ]; then
	rm -rf hats-for-mac
fi

echo "" > ~/.bash_profile
mkdir hats-for-mac
cd hats-for-mac

svn checkout https://github.com/younglim/hats-ci/trunk/macrobot
cd macrobot

installer_directory=`pwd`

./install-hats.sh

cd $original_directory
rm -rf $installer_directory

. ~/.bash_profile
