#!/bin/bash

exec < /dev/tty

echo "=== fedora kde setup script ==="

DNF_PKGS=(
fastfetch
filezilla
fish
obs-studio
qbittorrent
steam
lutris
mangohud
gamemode
)

sudo dnf install "${DNF_PKGS[@]}"   

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.discordapp.Discord com.surfshark.Surfshark com.spotify.Client

sudo sed -i \
-e 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=-1/' \
-e 's/^\(GRUB_CMDLINE_LINUX=\".*\)\"/\1 pcie_aspm=off\"/' \
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

echo "=== setup complete ==="
