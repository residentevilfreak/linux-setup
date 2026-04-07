#!/bin/bash

exec < /dev/tty

echo "=== cachyOS setup script ==="

PACMAN_PKGS=(
vlc
filezilla
qbittorrent
mullvad-vpn
prismlauncher
flatpak
ntfs-3g
protonup-qt
cachyos-gaming-meta
cachyos-gaming-applications
)

sudo pacman -Syu --needed "${PACMAN_PKGS[@]}"

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.obsproject.Studio com.discordapp.Discord com.spotify.Client

paru -S --noconfirm music-presence-bin

read -p "do you want to install cinnamon packages? (y/N): " INSTALL_CINNAMON
if [[ "$INSTALL_CINNAMON" =~ ^[Yy]$ ]]; then
    echo "installing cinnamon packages..."
    CINNAMON_PKGS=(
        flameshot
    )
    sudo pacman -S --needed "${CINNAMON_PKGS[@]}"
    flatpak install -y flathub io.github.peazip.PeaZip
else
    echo "skipping cinnamon packages."
fi

sudo sed -i \
-e 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=-1/' \
-e 's/^#*GRUB_DISABLE_OS_PROBER=.*/GRUB_DISABLE_OS_PROBER=false/' \
/etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

sudo systemctl start mullvad-daemon
sudo systemctl enable mullvad-daemon

mkdir -p ~/Desktop/{games,tools,other}

echo "=== setup complete! ==="
