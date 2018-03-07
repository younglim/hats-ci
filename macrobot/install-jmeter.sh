#!/bin/bash

echo -e "\n=========================="
echo -e "JMeter for Mac installer."
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
else
	brew upgrade ansible
fi

echo -e "Running Playbooks"

ansible-playbook -i "localhost," -c local "ansible-playbook-install-jmeter.yml"

. ~/.bash_profile

echo -e "\n===================================="
echo -e "Install complete. Please re-open your terminal. In future, run 'jmeter' to start."
echo -e "====================================\n"
