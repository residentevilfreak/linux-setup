#!/bin/bash

exec < /dev/tty

echo "=== debian 13 setup script ==="

sudo dpkg --add-architecture i386
sudo apt update

APT_PKGS=(
flatpak
filezilla
qbittorrent
steam-installer
lutris
wine
mangohud
goverlay
gamemode
ntfs-3g
)

sudo apt install "${APT_PKGS[@]}"

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.bitwarden.desktop com.obsproject.Studio com.discordapp.Discord com.spotify.Client app.zen_browser.zen com.usebottles.bottles com.protonvpn.www

sudo sed -i \
-e 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=-1/' \
/etc/default/grub
sudo update-grub

echo "=== setup complete! ==="
