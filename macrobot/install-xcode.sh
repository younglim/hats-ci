#!/bin/bash

echo -e "\n=========================="
echo -e "Xcode Download for Mac"
echo -e "==========================\n"

echo -e "\n===================================="
echo -e "Password is your login password"
echo -e "====================================\n"

sudo echo ""

echo "Install Xcode if currenty not installed"
if [ ! -d /Applications/Xcode.app ]; then
    echo "	Installing Xcode..."
	ansible-playbook -i "localhost," -c local "ansible-playbook-install-xcode-mas.yml"
	echo "Please install Xcode components if requested."
	open /Applications/Xcode.app -W
	osascript -e 'quit app "Xcode"'
else 
	echo "	Xcode installed"
fi

. ~/.bash_profile

echo -e "\n===================================="
echo -e "Install complete. Please re-open your terminal."
echo -e "====================================\n"
