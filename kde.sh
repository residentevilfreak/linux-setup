#!/bin/bash

exec < /dev/tty

echo "=== fedora kde setup script ==="

sudo dnf install -y fastfetch fish

sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf install -y akmod-nvidia
sudo dnf install -y xorg-x11-drv-nvidia-cuda 
sudo dnf install -y nvidia-settings          

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

echo "=== done! you can check the status of your driver build by: modinfo -F version nvidia ==="
echo "=== use nvidia-smi to check your drivers ==="
echo "=== setup complete ==="
