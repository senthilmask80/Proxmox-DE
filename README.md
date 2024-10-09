# Proxmox-DE (Desktop Environment) (updated Oct 09, 2024)

## X11 Window Managers
Assuming you have already installed a Proxmox VE 8.0.2 install. (or)
Assuming you have already installed a minimal Debian 12 install.
The series of shell scripts are intended to facilitate installing popular window managers.

Within the install.sh file, you can choose to install the following window managers:

* openbox


**User can select between vanilla(non-customized) and completely customized (my personal customization)** 

# Installation

``` 
wget -qO -https://github.com/senthilmask80/Proxmox-DE/blob/main/install.sh /tmp/install.sh

cd /tmp/

chmod +x install.sh

./install.sh

rm install.sh

```
## HELP keybinding:  Super + h
If you installed a custom script above (ex. openbox), a new directory will be located at ~/scripts

# Credits goes to

https://github.com/drewgrif/bookworm-scripts

author: drewgrif


https://github.com/Demonstrandum/Saluto

author: S. F. D. Knutsen
