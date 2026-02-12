#!/bin/bash

exec < /dev/tty

echo "=== opensuse setup script ==="

PACMAN_PKGS=(
flatpak
filezilla
qbittorrent
steam
lutris
wine
mangohud
goverlay
gamemode
vlc
ntfs-3g
)

sudo pacman -Syu --needed "${PACMAN_PKGS[@]}"

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.bitwarden.desktop com.surfshark.Surfshark com.obsproject.Studio com.discordapp.Discord com.spotify.Client

paru -S music-presence-bin

sudo sed -i \
-e 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=-1/' \
/etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "=== setup complete! ==="
