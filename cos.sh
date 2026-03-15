#!/bin/bash

exec < /dev/tty

echo "=== cachyOS setup script ==="

PACMAN_PKGS=(
flatpak
filezilla
qbittorrent
vlc
ntfs-3g
cachyos-gaming-meta
cachyos-gaming-applications
)

sudo pacman -Syu --needed "${PACMAN_PKGS[@]}"

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.bitwarden.desktop com.obsproject.Studio com.discordapp.Discord com.spotify.Client app.zen_browser.zen com.usebottles.bottles

paru -S music-presence-bin

sudo sed -i \
-e 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=-1/' \
/etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "=== setup complete! ==="
