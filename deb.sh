#!/bin/bash

exec < /dev/tty

echo "=== debian 13 setup script ==="

# enable 32 bit architecture
sudo dpkg --add-architecture i386

# enable contrib and non free in base repos 
sudo sed -i -E 's/Components: .*/Components: main contrib non-free non-free-firmware/' /etc/apt/sources.list.d/debian.sources 2>/dev/null || sudo sed -i 's/ main.*/ main contrib non-free non-free-firmware/g' /etc/apt/sources.list 2>/dev/null

# base update
sudo apt update && sudo apt upgrade -y

# add backports repo
echo "deb http://deb.debian.org/debian trixie-backports main contrib non-free non-free-firmware" | sudo tee /etc/apt/sources.list.d/backports.list
sudo apt update

# install modern kernel + microcode + amd/realtek firmware from backports
sudo apt install -t trixie-backports -y \
  linux-image-amd64 \
  amd64-microcode \
  firmware-amd-graphics \
  firmware-misc-nonfree \
  firmware-realtek

# install mesa drivers & vulkan loader (64 + 32 bit) from backports
sudo apt install -t trixie-backports -y \
  libgl1-mesa-dri \
  libgl1-mesa-dri:i386 \
  mesa-vulkan-drivers \
  mesa-vulkan-drivers:i386 \
  libvulkan1 \
  libvulkan1:i386 \
  mesa-va-drivers \
  mesa-vdpau-drivers

# standard packages
APT_PKGS=(
  flatpak
  filezilla
  qbittorrent
  steam-installer
  steam-devices
  mangohud
  goverlay
  gamemode
  ntfs-3g
  fastfetch
  mesa-utils
  vulkan-tools
  plasma-discover-backend-flatpak
)

# install standard packages
sudo apt install "${APT_PKGS[@]}" -y

# install flatpaks
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y --noninteractive flathub \
  com.bitwarden.desktop \
  com.obsproject.Studio \
  com.discordapp.Discord \
  com.spotify.Client \
  app.zen_browser.zen \
  com.usebottles.bottles \
  com.protonvpn.www

# configure GRUB
sudo sed -i -e 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=-1/' /etc/default/grub
sudo update-grub

echo "=== setup complete! ==="
