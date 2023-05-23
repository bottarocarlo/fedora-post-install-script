#! /bin/bash

# First, optimize the dnf package manager
sudo cp /etc/dnf/dnf.conf /etc/dnf/dnf.conf.bak
sudo cp dotfiles/dnf.conf /etc/dnf/dnf.conf
sudo cp dotfiles/.zshrc /home/$USER

# Check for updates
sudo dnf upgrade --refresh -y
sudo dnf autoremove -y


# Enabling RPMFusion and Flathub
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm -y
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm -y
sudo dnf upgrade --refresh -y
sudo dnf groupupdate core -y
sudo dnf install rpmfusion-free-release-tainted -y
sudo dnf install dnf-plugins-core -y
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo -y

# ffmpeg
sudo dnf install ffmpeg --allowerasing -y

# Installing my extensions, includes Pop Shell, AppIndicator and SoundOutputDeviceChooser
sudo dnf install gnome-shell-extension-pop-shell gnome-shell-extension-dash-to-dock -y

# Docker 
curl -fsSL https://get.docker.com/ | sh

# Postman Spotify Telegram Discord
flatpak install flathub com.getpostman.Postman -y
flatpak install flathub com.spotify.Client -y
flatpak install flathub org.telegram.desktop -y
flatpak install flathub com.discordapp.Discord -y

# Optimize boot time
sudo systemctl disable iscsi
sudo systemctl disable NetworkManager-wait-online.service

# code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install code -y

#install node
sudo dnf install nodejs -y

# github ssh
echo ; echo ; echo | ssh-keygen -t ed25519 -C "bottarocarloo@gmail.com"   
git config --global user.name "bottarocarlo" 
git config --global user.email "bottarocarloo@gmail.com" 

# remove unitils
sudo dnf remove gnome-contacts gnome-maps gnome-photos gnome-tour gnome-weather 

# tailscale
curl -fsSL https://tailscale.com/install.sh | sh

# oh my zsh
sudo dnf install zsh curl util-linux-user -y
# chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

