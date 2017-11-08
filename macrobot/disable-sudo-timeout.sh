#!/bin/bash

echo -e "\n=========================="
echo -e "Disable sudo timeout"
echo -e "==========================\n"

echo -e "\n===================================="
echo -e "Password is your login password"
echo -e "====================================\n"

sudo echo ""

echo -e "Install brew if currently not installed"
if [ ! -f /usr/local/bin/brew ]; then
	echo -e "	Installing Brew..."
	
	ruby \
  	-e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \
  	</dev/null
  	
  	brew update
fi

echo -e "Install Ansible if currenty not installed"
if [ ! -f /usr/local/bin/ansible-playbook ]; then
	echo -e "	Installing Ansible..."
	brew install ansible
fi

echo -e "Running Playbooks"

ansible-playbook -i "localhost," -c local "ansible-playbook-disable-sudo-timeout.yml"
