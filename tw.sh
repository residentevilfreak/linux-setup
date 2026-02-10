#!/bin/bash

exec < /dev/tty

echo "=== opensuse setup script ==="

OPENSUSE_PKGS=(
filelight
filezilla
qbittorrent
steam
lutris
wine
btop
mangohud
goverlay
gamemode
zip
unrar
unzip
fish
fastfetch
kio-admin
power-profiles-daemon
)

sudo zypper refresh
sudo zypper install "${OPENSUSE_PKGS[@]}"

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.obsproject.Studio com.bitwarden.desktop com.surfshark.Surfshark com.discordapp.Discord

sudo sed -i \
-e 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=-1/' \
/etc/default/grub
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

chsh -s "$(which fish)"

mkdir -p ~/.config/fish
cat > ~/.config/fish/config.fish << 'EOF'
if status is-interactive
    fastfetch
end

set fish_greeting

alias fetch='fastfetch'
EOF

echo "=== setup complete! ==="
