#!/bin/bash

exec < /dev/tty

echo "=== cachyOS setup script ==="

PACMAN_PKGS=(
flatpak
filezilla
qbittorrent
proton-vpn-gtk-app
vlc
ntfs-3g
cachyos-gaming-meta
cachyos-gaming-applications
)

sudo pacman -Syu --needed "${PACMAN_PKGS[@]}"

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.obsproject.Studio com.discordapp.Discord com.spotify.Client

paru -S music-presence-bin

read -p "do you want to install cinnamon packages? (y/n): " INSTALL_CINNAMON
if [[ "$INSTALL_CINNAMON" =~ ^[Yy]$ ]]; then
    echo "installing cinnamon packages..."
    CINNAMON_PKGS=(
        flameshot
    )
    sudo pacman -S --needed "${CINNAMON_PKGS[@]}"
    flatpak install flathub io.github.peazip.PeaZip
else
    echo "skipping cinnamon packages."
fi

sudo sed -i \
-e 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=-1/' \
-e 's/^#*GRUB_DISABLE_OS_PROBER=.*/GRUB_DISABLE_OS_PROBER=false/' \
/etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "=== setup complete! ==="
