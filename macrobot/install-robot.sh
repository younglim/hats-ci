#!/bin/bash

# REACT_DIR=$1
# if [ -z "$1" ]; then
# 	REACT_DIR="~/bgp-react"
# fi

echo "Install brew if currently not installed"
if [ ! -f /usr/local/bin/brew ]; then
	echo "	Installing Brew..."
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew update
fi

echo "Install Ansible if currenty not installed"
if [ ! -f /usr/local/bin/ansible-playbook ]; then
	echo "	Installing Ansible..."
	brew install ansible
fi

echo "Running Playbooks"
ansible-playbook -i "localhost," -c local "ansible-playbook-install-robot-framework.yml" --ask-sudo-pass