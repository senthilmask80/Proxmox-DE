#!/bin/bash

# Main list of packages
packages=("openbox" "tint2" "terminator" "firefox-esr" "xfce4-appfinder" "xorg" "xinit" "dialog" "menu" "obconf" "xfce4-power-manager")
x11_packages=("xserver-xorg" "xbacklight" "xbindkeys" "xvkbd" "xinput" "xdotool" "xcompmgr" "lxappearance" "lxappearance-obconf" "feh" "redshift")
basic_packages=("build-essential" "aptitude" "apt-transport-https" "software-properties-common" "gnupg" "ca-certificates")
zip_packages=("unzip" "p7zip" "zip")
fonts_packages=("fonts-recommended" "fonts-font-awesome" "fonts-terminus" "fonts-noto")

# Function to read common packages from a file
#read_base_packages() {
#    local base_file="$1"
#    if [ -f "$base_file" ]; then
#        packages+=( $(< "$base_file") )
#    else
#        echo "Base packages file not found: $common_file"
#        exit 1
#    fi
#}

# Read common packages from file
#read_base_packages "/tmp/Proxmox-DE/install_scripts/base_packages.txt"

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
install_packages "${packages[@]}";
echo "The default packages is installation"
clear
install_packages "${x11_packages[@]}";
echo "The x11 packages is installation"
clear
install_packages "${basic_packages[@]}";
echo "The basic packages is installation"
clear
install_packages "${zip_packages[@]}";
echo "The zip packages is installation"
clear
install_packages "${fonts_packages[@]}";
echo "The fonts packages is installation"
clear

mkdir -p ~/.themes/

SCRIPT_DIR=/tmp/Proxmox-DE

echo "The obmenu packages is installation"
bash /tmp/Proxmox-DE/install_scripts/obmenu.sh

clear
echo "The vue-cli packages is installation"
bash /tmp/Proxmox-DE/install_scripts/vue-cli.sh

clear
echo "The webkit-lightdm packages is installation"
bash /tmp/Proxmox-DE/webkit-lightdm/Saluto/install.sh

git clone https://github.com/addy-dclxvi/openbox-theme-collections ~/.themes

# moving custom config
\ncp -r /tmp/Proxmox-DE/dataconfig/openbox/ ~/.config/
\ncp -r /tmp/Proxmox-DE/dataconfig/tint2/ ~/.config/
\ncp -r /tmp/Proxmox-DE/dataconfig/backgrounds/ ~/.config/
#\ncp -r /tmp/Proxmox-DE/datalocal/local/bin ~/.local/bin/
