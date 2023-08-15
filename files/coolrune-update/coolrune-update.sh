#!/bin/sh

# License: GNU GPLv3

su -c '
# CLEANUP
cleanup() {
    rm -rf /home/coolrune-files
    exit 1
}

trap cleanup INT TERM ERR EXIT

# SCRIPT VOCABULARY / USER MODIFICATION SECTION
root_files="wget https://github.com/MichaelSebero/CoolRune/raw/main/files/coolrune-packages/coolrune-root.7z"
dotfiles="wget https://github.com/MichaelSebero/CoolRune/raw/main/files/coolrune-packages/coolrune-dotfiles.7z"
nvidia_patch="wget https://github.com/MichaelSebero/CoolRune/raw/main/files/coolrune-packages/coolrune-nvidia-patch.7z"
coolrune_manual="wget https://raw.githubusercontent.com/MichaelSebero/CoolRune/main/files/coolrune-manual/Manual"

# COOLRUNE CHOICE SELECTION
echo "Make sure to backup your passwords and bookmarks before updating CoolRune"
echo "1. CoolRune-AMD/INTEL"
echo "2. CoolRune-NVIDIA"
read -p "Enter your choice (1 or 2): " choice



### AMD/INTEL CHOICE ###
if [ "$choice" = "1" ]; then
pacman -Syyu --noconfirm --needed && mkdir /home/coolrune-files && cd /home/$USER/Desktop && eval $coolrune_manual && cd /home/coolrune-files && eval $root_files && eval $dotfiles && chattr -i /etc/hosts && 7z x coolrune-root.7z -o/ -y && 7z x coolrune-dotfiles.7z -o/home/$USER -y && chattr +i /etc/hosts && chmod 777 /home/$USER/Desktop/Manual && chmod 777 /home/$USER/.var/io.github.celluloid_player.Celluloid -R && rm -rf /home/coolrune-files && rm -rf /home/$USER/coolrune-update.sh && chmod 777 /home/$USER/.librewolf -R && chmod 777 /home/$USER/.config -R && chmod 777 /home/$USER/.var/app -R && chmod 777 /home/$USER/.local/share/applications -R && grub-install && update-grub && reboot



### NVIDIA CHOICE ###
elif [ "$choice" = "2" ]; then
pacman -Syyu --noconfirm --needed && mkdir /home/coolrune-files && cd /home/$USER/Desktop && eval $coolrune_manual && cd /home/coolrune-files && eval $root_files && eval $dotfiles && eval $nvidia_patch && chattr -i /etc/hosts && 7z x coolrune-root.7z -o/ -y && 7z x coolrune-nvidia-patch.7z -o/ -y && 7z x coolrune-dotfiles.7z -o/home/$USER -y && chattr +i /etc/hosts && chmod 777 /home/$USER/Desktop/Manual && chmod 777 /home/$USER/.var/io.github.celluloid_player.Celluloid -R && rm -rf /home/coolrune-files && rm -rf /home/$USER/coolrune-nvidia-update.sh && chmod 777 /home/$USER/.librewolf -R && chmod 777 /home/$USER/.config -R && chmod 777 /home/$USER/.var/app -R && chmod 777 /home/$USER/.local/share/applications -R && grub-install && update-grub && reboot
fi
'
