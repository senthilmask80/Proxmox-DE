#!/bin/sh
sudo apt clean
sudo apt autoclean
sudo apt -y autoremove 
sudo apt install -y perl
#sudo apt install -y perl-doc
sudo apt install -y libgtk3-perl
sudo apt install -y libmodule-build-perl

## install LinuxDesktopFile
cd ~/Downloads
git clone https://github.com/trizen/Linux-DesktopFiles.git
cd Linux-DesktopFiles
perl Build.PL
     ./Build
     ./Build test
sudo   ./Build install

mkdir -p ~/.local/bin/
mkdir -p ~/.config/obmenu-generator
export PATH="$HOME/.local/bin:$PATH"

cd ~/Downloads
git clone https://github.com/trizen/obmenu-generator.git
cd obmenu-generator
cpan -i DATA::DUMP
cp obmenu-generator ~/.local/bin/
cp schema.pl ~/.config/obmenu-generator

sudo rm -r ~/Downloads/Linux-DesktopFiles
sudo rm -rf ~/Downloads/obmenu-generator

obmenu-generator -p -i     # dynamic menu with icons
