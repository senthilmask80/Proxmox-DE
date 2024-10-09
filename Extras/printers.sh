#!/bin/bash

# Making sure you have unarchiver

sudo apt install unzip

# Retrieve discord tar.gz file 

cd ~/Downloads/

wget "https://download.brother.com/welcome/dlf006893/linux-brprinter-installer-2.2.3-1.gz"

gunzip linux-brprinter-installer-*.*.*-*.gz

sudo bash linux-brprinter-installer-2.2.3-1 mfc7440n
clear

echo "Would you like to install printing services? (y/n)"
read response

if [[ "$response" =~ ^[Yy]$ ]]; then
    echo "Installing printing services..."
		sudo apt install -y cups system-config-printer simple-scan
		sudo systemctl enable cups.service
    echo "Printing services installed."
elif [[ "$response" =~ ^[Nn]$ ]]; then
    echo "Printing services will not be installed."
else
    echo "Invalid input. Please enter 'y' or 'n'."
fi
