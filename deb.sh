#!/bin/bash

exec < /dev/tty

echo "=== debian 13 setup script ==="

# standard packages 
APT_PKGS=(
  fish
  flatpak
  filezilla
  qbittorrent
  gamemode
  ntfs-3g
  fastfetch
  plasma-discover-backend-flatpak
  power-profiles-daemon
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
  com.valvesoftware.Steam \
  com.protonvpn.www

# configure GRUB
sudo sed -i -e 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=-1/' /etc/default/grub
sudo update-grub

# set fish as default shell
chsh -s "$(which fish)"

# configure fish
mkdir -p ~/.config/fish
cat > ~/.config/fish/config.fish << 'EOF'
if status is-interactive
    fastfetch
end

set fish_greeting

alias fetch='fastfetch'
EOF

echo "=== setup complete! ==="
