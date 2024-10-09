#!/bin/bash

# Main list of packages
packages=(
	"openbox"
	"tint2"
	"terminator"
    "firefox-esr"
)

# Function to read common packages from a file
read_base_packages() {
    local base_file="$1"
    if [ -f "$base_file" ]; then
        packages+=( $(< "$base_file") )
    else
        echo "Base packages file not found: $common_file"
        exit 1
    fi
}

# Read common packages from file
read_base_packages "/tmp/Proxmox-DE/install_scripts/base_packages.txt"

# Function to install packages if they are not already installed
install_packages() {
    local pkgs=("$@")
    local missing_pkgs=()

    # Check if each package is installed
    for pkg in "${pkgs[@]}"; do
        if ! dpkg -l | grep -q " $pkg "; then
            missing_pkgs+=("$pkg")
        fi
    done

    # Install missing packages
    if [ ${#missing_pkgs[@]} -gt 0 ]; then
        echo "Installing missing packages: ${missing_pkgs[@]}"
        sudo apt update
        sudo apt install -y "${missing_pkgs[@]}"
        if [ $? -ne 0 ]; then
            echo "Failed to install some packages. Exiting."
            exit 1
        fi
    else
        echo "All required packages are already installed."
    fi
}

# Call function to install packages
install_packages "${packages[@]}"

mkdir -p ~/.themes/

SCRIPT_DIR=/tmp/Proxmox-DE

bash /tmp/Proxmox-DE/install_scripts/obmenu.sh

bash /tmp/Proxmox-DE/install_packages/vue-cli.sh

bash /tmp/Proxmox-DE/webkit-lightdm/Saluto/install.sh

git clone https://github.com/addy-dclxvi/openbox-theme-collections ~/.themes

# moving custom config
\cp -r /tmp/Proxmox-DE/Prox-Dots/.config/openbox/ ~/.config/
\cp -r /tmp/Proxmox-DE/Prox-Dots/.config/tint2/ ~/.config/
\cp -r /tmp/Proxmox-DE/Prox-Dots/.config/backgrounds/ ~/.config/
