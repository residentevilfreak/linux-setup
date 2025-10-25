# linux-setup

my personal scripts and notes for my linux installs.

this repository holds whatever i use for setting up my linux installs. it's built for my own use, but hosted publicly on github so i can easily pull the script.

## getting started

### run the script

1.  **clone the repo**

    ```bash
    git clone https://github.com/residentevilfreak/linux-setup ~/Desktop/linux-setup
    ```

2.  **run the scripts**

    change into the directory

    ```bash
    cd ~/Desktop/linux-setup
    ```

    then, run the desired script:

    | System | Command |
    | :--- | :--- |
    | **fedora** (gnome) | `bash gnome.sh` |
    | **fedora** (kde) | `bash kde.sh` |
    | **arch linux** | `bash arch.sh` 
   
## fedora configuration

> do this before running kde.sh

1.  **enable rpmfusion repos**

    ```bash
    sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
    sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
    ```

2.  **update system & reboot**

    ```bash
    sudo dnf update -y
    sudo reboot
    ```
    
3.  **install drivers**

    ```bash
    sudo dnf install -y akmod-nvidia 
    sudo dnf install -y xorg-x11-drv-nvidia-cuda nvidia-settings
    ```
4.  **install git**

    ```bash
    sudo dnf install -y git 
    ```

## kde configuration

### behavior
- configure scrollback konsole
- configure spectacle's screenshot settings
- change the show desktop widget to minimize all windows
- add the music presence app to autostart

### hardware (pc)
- disable cursor acceleration
- configure power management

### hardware (laptop)
- invert the touchpad scroll direction for natural scrolling
- reduce the touchpad's scroll speed for better control

### appearance
- set the global display scale to 90%
- edit the application menu to hide unwanted entries
- customize the cursor
- set a user profile picture
- customize taskbar applications
- configure the system tray to show only needed icons
- customize the digital clock
- apply a global dark theme
- set new wallpapers
- disable the startup splash screen
- customize the panel
- customize the desktop
- apply an sddm theme
