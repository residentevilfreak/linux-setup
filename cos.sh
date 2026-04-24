#!/bin/bash

exec < /dev/tty

echo "=== cachyOS setup script ==="

PACMAN_PKGS=(
vlc
kweather
gnome-maps
filezilla
qbittorrent
prismlauncher
flatpak
ntfs-3g
gamemode
protonup-qt
cachyos-gaming-meta
cachyos-gaming-applications
)

sudo pacman -Syu --needed "${PACMAN_PKGS[@]}"

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.obsproject.Studio com.discordapp.Discord dev.vencord.Vesktop com.spotify.Client org.kde.marknote com.github.tchx84.Flatseal app.zen_browser.zen

paru -S --noconfirm music-presence-bin amneziavpn-bin betterbird-bin

paru -S polychromatic

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

sudo gpasswd -a $USER openrazer

wpctl settings --save bluetooth.autoswitch-to-headset-profile false

systemctl --user restart wireplumber

echo "=== setup complete! ==="
