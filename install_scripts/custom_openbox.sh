#!/bin/bash

# Main list of packages
packages=("openbox" "tint2" "terminator" "firefox-esr" "xfce4-appfinder" "xorg" "xinit" "dialog" "menu" "obconf" "xfce4-power-manager")
x11_packages=("xserver-xorg" "xbacklight" "xbindkeys" "xvkbd" "xinput" "xdotool" "xcompmgr" "lxappearance" "lxappearance-obconf" "feh" "redshift")
basic_packages=("build-essential" "aptitude" "apt-transport-https" "software-properties-common" "gnupg" "ca-certificates")
dbus_packages=("policykit-1-gnome" "network-manager" "network-manager-gnome" "avahi-daemon" "acpi" "acpid" "gvfs-backends" "libgtk-3-dev" "binutils" "dnsutils")
zip_packages=("unzip" "p7zip" "zip")
utils_packages=("thunar" "thunar-archive-plugin" "thunar-volman" "mtools" "dosfstools" "rofi" "dunst" "libnotify-bin" "htop" "xscreensaver-gl-extra" "xscreensaver-data-extra" "autoconf" "dnsutils")
extra_packages=("file-roller" "exa" "scrot" "libnotify-dev" "micro" "xclip" "nitrogen" "simplescreenrecorder" "ristretto" "gmrun" "numlockx" "conky" "slick-greeter" "cairo-dock" "dbus-x11" "hsetroot" "qt5-style-plugins")
audio_packages=("pulseaudio" "pavucontrol" "volumeicon-alsa" "pamixer" "pulsemixer")
themes_packages=("papirus-icon-theme" "arc-theme" "moka-icon-theme" "imagemagick")
geany_packages=("geany" "geany-plugin-addons" "geany-plugin-git-changebar" "geany-plugin-spellcheck" "geany-plugin-treebrowser" "geany-plugin-markdown" "geany-plugin-insertnum" "geany-plugin-lineoperations" "geany-plugin-automark")
fonts_packages=("fonts-recommended" "fonts-font-awesome" "fonts-terminus" "fonts-noto")


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
        sudo apt update -y;
        sudo apt upgrade -y;
        sudo apt install -y "${missing_pkgs[@]}"
        sudo apt clean;
        sudo apt autoclean;
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
install_packages "${dbus_packages[@]}";
echo "The dbus-x11 packages is installation"
clear
install_packages "${zip_packages[@]}";
echo "The zip packages is installation"
clear
install_packages "${utils_packages[@]}";
echo "The utils packages is installation"
clear
install_packages "${extra_packages[@]}";
echo "The extra packages is installation"
clear
install_packages "${audio_packages[@]}";
echo "The audio packages is installation"
clear
install_packages "${themes_packages[@]}";
echo "The themes packages is installation"
clear
install_packages "${geany_packages[@]}";
echo "The geany packages is installation"
clear
install_packages "${fonts_packages[@]}";
echo "The fonts packages is installation"
clear
sudo systemctl enable avahi-daemon
sudo systemctl enable acpid

xdg-user-dirs-update

mkdir -p ~/Screenshots/
mkdir -p ~/.themes/

SCRIPT_DIR=/tmp/Proxmox-DE
clear
echo "The obmenu packages is installation"
bash /tmp/Proxmox-DE/install_scripts/obmenu.sh

clear
echo "The vue-cli packages is installation"
bash /tmp/Proxmox-DE/install_scripts/vue-cli.sh

clear
echo "The webkit-lightdm packages is installation"
bash /tmp/Proxmox-DE/webkit-lightdm/Saluto/install.sh

# check FT-Labs picom and nerdfonts are installed
clear
echo "The picom packages is installation"
bash /tmp/Proxmox-DE/install_scripts/picom.sh
clear
echo "The nerdfonts packages is installation"
bash /tmp/Proxmox-DE/install_scripts/nerdfonts.sh

# adding gtk theme and icon theme
bash /tmp/Proxmox-DE/colorschemes/blue.sh
mv ~/.config/openbox/Simply_Circles_Dark ~/.themes
git clone https://github.com/addy-dclxvi/openbox-theme-collections ~/.themes

# moving custom config
\ncp -r /tmp/Proxmox-DE/dataconfig/openbox/ ~/.config/
\ncp -r /tmp/Proxmox-DE/dataconfig/tint2/ ~/.config/
\ncp -r /tmp/Proxmox-DE/dataconfig/dunst/ ~/.config/
\ncp -r /tmp/Proxmox-DE/dataconfig/picom/ ~/.config/
\ncp -r /tmp/Proxmox-DE/dataconfig/kitty/ ~/.config/
\ncp -r /tmp/Proxmox-DE/dataconfig/backgrounds/ ~/.config/
#\ncp -r /tmp/Proxmox-DE/datalocal/local/bin ~/.local/bin/
