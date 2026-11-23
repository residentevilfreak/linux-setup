#!/bin/bash

exec < /dev/tty

echo "=== cachyOS setup script ==="

PACMAN_PKGS=(
vlc
discord
vesktop-bin
gnome-maps
filezilla
qbittorrent
prismlauncher
flatpak
ntfs-3g
sbctl
brave-bin
protonup-qt
cachyos-gaming-applications
)

sudo pacman -Syu --needed "${PACMAN_PKGS[@]}"

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.obsproject.Studio com.spotify.Client org.kde.marknote com.github.tchx84.Flatseal io.github.amit9838.mousam

shelly install aur music-presence-bin --needed --no-confirm

sudo sed -i \
-e 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=-1/' \
-e 's/^#*GRUB_DISABLE_OS_PROBER=.*/GRUB_DISABLE_OS_PROBER=false/' \
-e "/^GRUB_CMDLINE_LINUX_DEFAULT=/ { /pcie_aspm=off/! s/\(['\"]\)[[:space:]]*$/ pcie_aspm=off\1/; }" \
/etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

wpctl settings --save bluetooth.autoswitch-to-headset-profile false

echo "=== setup complete! ==="
