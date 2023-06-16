#!/bin/sh

# License: GNU GPLv3

read -rep $'Make sure to backup your passwords and bookmarks before updating CoolRune, press [ENTER] to continue. '

su -c '
root_files="curl -LO https://github.com/MichaelSebero/CoolRune/raw/main/files/coolrune-packages/coolrune-root.7z" 
dotfiles="curl -LO https://github.com/MichaelSebero/CoolRune/raw/main/files/coolrune-packages/coolrune-dotfiles.7z"

pacman -Syyu --noconfirm --needed && mkdir /home/coolrune-files && cd /home/coolrune-files && eval $root_files && eval $dotfiles && chattr -i /etc/hosts && chattr -i /etc/resolv.conf && 7z x coolrune-root.7z -o/ -y && 7z x coolrune-dotfiles.7z -o/home/$USER -y && chattr +i /etc/hosts && chmod 777 /home/$USER/.var/io.github.celluloid_player.Celluloid -R && rm -rf /home/coolrune-files && rm -rf /home/$USER/coolrune-update.sh && chmod 777 /home/$USER/.librewolf -R && chmod 777 /home/$USER/.config -R && chmod 777 /home/$USER/.var/app -R && chmod 777 "/home/$USER/Desktop/CoolRune Manual" && chmod 777 /home/$USER/.local/share/applications -R && update-grub && reboot '
