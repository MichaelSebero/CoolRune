#!/bin/sh

# License: GNU GPLv3

read -rep $'Make sure to backup your passwords and bookmarks before updating CoolRune, press [ENTER] to continue. '

su -c '
root_files="wget https://github.com/MichaelSebero/CoolRune/raw/main/CoolRune-Files/CoolRune-Root.7z" 
dotfiles="wget https://github.com/MichaelSebero/CoolRune/raw/main/CoolRune-Files/CoolRune-Dotfiles.7z"
nvidia_patch="wget https://github.com/MichaelSebero/CoolRune/raw/main/CoolRune-Files/CoolRune-NVIDIA-Patch.7z"

pacman -Syyu --noconfirm --needed && mkdir /home/CoolRune-Files && cd /home/CoolRune-Files && eval $root_files && eval $dotfiles && eval $nvidia_patch && chattr -i /etc/hosts && chattr -i /etc/resolv.conf && 7z x CoolRune-Root.7z -o/ -y && 7z x CoolRune-NVIDIA-Patch.7z -o/ -y && 7z x CoolRune-Dotfiles.7z -o/home/$USER -y && chattr +i /etc/hosts && chmod 777 /home/$USER/.var/io.github.celluloid_player.Celluloid -R && rm -rf /home/CoolRune-Files && rm -rf /home/$USER/CoolRune-NVIDIA-Update.sh && chmod 777 /home/$USER/.librewolf -R && chmod 777 /home/$USER/.config -R && chmod 777 /home/$USER/.var/app -R && chmod 777 "/home/$USER/Desktop/CoolRune Manual" && chmod 777 /home/$USER/.local/share/applications -R && update-grub && reboot '
