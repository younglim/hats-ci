#!/bin/bash

echo -e "\n============================"
echo -e "Install Robot Framework and Browser Drivers"
echo -e "============================\n"

echo -e "\n===================================="
echo -e "Password is your login password"
echo -e "====================================\n"

sudo echo ""

echo -e "Install brew if currently not installed"
if [ ! -f /usr/local/bin/brew ]; then
	echo -e "	Installing Brew..."
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew update
fi

echo -e "Install Ansible if currenty not installed"
if [ ! -f /usr/local/bin/ansible-playbook ]; then
	echo -e "	Installing Ansible..."
	brew install ansible
else
	brew upgrade ansible
fi

echo -e "Running Playbooks"

ansible-playbook -i "localhost," -c local "ansible-playbook-install-robot-framework.yml"

echo -e "Source bash_profile"
source ~/.bash_profile

echo -e "\n===================================="
echo -e "Install complete. Please re-open your terminal. "
echo -e "====================================\n"
