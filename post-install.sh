#! /bin/bash

# # Networks
# sudo cp /backup/* /etc/NetworkManager/system-connections/

# First, optimize the dnf package manager
sudo cp /etc/dnf/dnf.conf /etc/dnf/dnf.conf.bak
sudo cp dotfiles/dnf.conf /etc/dnf/dnf.conf
sudo cp dotfiles/.zshrc /home/$USER

# Check for updates
sudo dnf upgrade --refresh -y
sudo dnf autoremove -y

# # Enabling dnf-automatic(Automatic updates)
# sudo dnf install dnf-automatic -y
# sudo cp dotfiles/dnf/automatic.conf /etc/dnf/automatic.conf
# sudo systemctl enable --now dnf-automatic.timer

# Enabling RPMFusion and Flathub
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm -y
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm -y
sudo dnf upgrade --refresh -y
sudo dnf groupupdate core -y
sudo dnf install rpmfusion-free-release-tainted -y
sudo dnf install dnf-plugins-core -y
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo -y


# ffmpeg
sudo dnf install ffmpeg -y

# Installing media codecs
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
sudo dnf install lame\* --exclude=lame-devel -y
sudo dnf group upgrade --with-optional Multimedia -y

# Installing my extensions, includes Pop Shell, AppIndicator and SoundOutputDeviceChooser
sudo dnf install gnome-shell-extension-pop-shell gnome-shell-extension-dash-to-dock -y
gsettings set org.gnome.shell.extensions.pop-shell tile-by-default true
gsettings set org.gnome.shell.extensions.pop-shell gap-outer 2
gsettings set org.gnome.shell.extensions.pop-shell gap-inner 2

# # Installing Google Noto Sans fonts, Microsoft Cascadia Code fonts and apply it to system fonts
# sudo dnf install google-noto-sans-fonts -y
# axel -n 20 https://github.com/microsoft/cascadia-code/releases/download/v2111.01/CascadiaCode-2111.01.zip
# unzip ./CascadiaCode-2110.01.zip -d ./CascadiaCode-2110.01
# sudo mv ./CascadiaCode-2110.01/ttf/static/* /usr/share/fonts/
# fc-cache -f -v
# gsettings set org.gnome.desktop.interface font-name 'Noto Sans Medium 11'
# gsettings set org.gnome.desktop.interface document-font-name 'Noto Sans Regular 11'
# gsettings set org.gnome.desktop.interface monospace-font-name 'Cascadia Code PL 13'
# gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Noto Sans Bold 11'

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
rpm --import https://packages.microsoft.com/keys/microsoft.asc
sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install code -y

#install node
sudo dnf install nodejs

# github ssh
echo ; echo ; echo | ssh-keygen -t ed25519 -C "bottarocarloo@gmail.com"   
git config --global user.name "bottarocarlo" 
git config --global user.email "bottarocarloo@gmail.com" 


# tailscale
curl -fsSL https://tailscale.com/install.sh | sh

# oh my zsh
sudo dnf install zsh curl util-linux-user -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

