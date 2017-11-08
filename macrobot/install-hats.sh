#!/bin/bash

echo -e "\n=========================="
echo -e "hats for Mac installer."
echo -e "==========================\n"

echo -e "\n===================================="
echo -e "Password is your login password"
echo -e "====================================\n"

sudo echo -e ""

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

sudo ansible-playbook -i "localhost," -c local "ansible-playbook-install-hats.yml"

echo -e "\n============================================================================================================"
echo -e "Install complete. Please re-open your terminal. In future, run 'hats_shell' to start the testing environment."
echo -e "============================================================================================================\n"
