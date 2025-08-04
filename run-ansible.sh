#!/bin/bash

#TODO: add ssh keys
#TODO: verify zsh is default shell and there's no zshrc

set -e

# Optional: Update system packages
sudo apt update && sudo apt upgrade -y

# Install software-properties-common (if missing)
sudo apt install -y software-properties-common

# Add Ansible PPA
sudo add-apt-repository --yes --update ppa:ansible/ansible

# Install Ansible
sudo apt install -y ansible

# Verify installation
ansible --version

# Pull play
ansible-pull -U https://github.com/coffemugtester/dotfiles playbook.yml
