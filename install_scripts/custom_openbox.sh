#!/bin/bash

# Main list of packages
packages=(
	"openbox"
	"tint2"
    "terminator"
    "firefox-esr"
    "xfce4-appfinder"
)

# Function to read common packages from a file
read_common_packages() {
    local common_file="$1"
    if [ -f "$common_file" ]; then
        packages+=( $(< "$common_file") )
    else
        echo "Common packages file not found: $common_file"
        exit 1
    fi
}

# Read common packages from file
read_common_packages /tmp/Proxmox-DE/install_scripts/common_packages.txt

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

sudo systemctl enable avahi-daemon
sudo systemctl enable acpid

xdg-user-dirs-update
mkdir -p ~/Screenshots/
mkdir -p ~/.themes/

SCRIPT_DIR=/tmp/Proxmox-DE

bash /tmp/Proxmox-DE/install_scripts/obmenu.sh

bash /tmp/Proxmox-DE/install_packages/vue-cli.sh

bash /tmp/Proxmox-DE/webkit-lightdm/Saluto/install.sh

# check FT-Labs picom and nerdfonts are installed
bash /tmp/Proxmox-DE/install_scripts/picom.sh
bash /tmp/Proxmox-DE/install_scripts/nerdfonts.sh

# adding gtk theme and icon theme
bash /tmp/Proxmox-DE/colorschemes/blue.sh
mv ~/.config/openbox/Simply_Circles_Dark ~/.themes
git clone https://github.com/addy-dclxvi/openbox-theme-collections ~/.themes

# moving custom config
\cp -r /tmp/Proxmox-DE/Prox-Dots/.config/openbox/ ~/.config/
\cp -r /tmp/Proxmox-DE/Prox-Dots/.config/tint2/ ~/.config/
\cp -r /tmp/Proxmox-DE/Prox-Dots/.config/dunst/ ~/.config/
\cp -r /tmp/Proxmox-DE/Prox-Dots/.config/picom/ ~/.config/
\cp -r /tmp/Proxmox-DE/Prox-Dots/.config/kitty/ ~/.config/
\cp -r /tmp/Proxmox-DE/Prox-Dots/.config/backgrounds/ ~/.config/
