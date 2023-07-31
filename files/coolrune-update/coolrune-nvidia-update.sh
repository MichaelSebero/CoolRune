#!/bin/sh

read -rep $'Make sure to backup your passwords and bookmarks before updating CoolRune, press [ENTER] to continue. '

su -c '
root_files="wget https://github.com/MichaelSebero/CoolRune/raw/main/files/coolrune-packages/coolrune-root.7z" 
dotfiles="wget https://github.com/MichaelSebero/CoolRune/raw/main/files/coolrune-packages/coolrune-dotfiles.7z"
nvidia_patch="wget https://github.com/MichaelSebero/CoolRune/raw/main/files/coolrune-packages/coolrune-nvidia-patch.7z"
coolrune-manual="wget https://raw.githubusercontent.com/MichaelSebero/CoolRune/main/files/coolrune-manual/CoolRune-Manual"

pacman -Syyu --noconfirm --needed && mkdir /home/coolrune-files && cd /home/$USER/Desktop && eval $coolrune-manual && cd /home/coolrune-files && eval $root_files && eval $dotfiles && eval $nvidia_patch && chattr -i /etc/hosts && chattr -i /etc/resolv.conf && 7z x coolrune-root.7z -o/ -y && 7z x coolrune-nvidia-patch.7z -o/ -y && 7z x coolrune-dotfiles.7z -o/home/$USER -y && chattr +i /etc/hosts && chmod 777 /home/$USER/.var/io.github.celluloid_player.Celluloid -R && rm -rf /home/coolrune-files && rm -rf /home/$USER/coolrune-nvidia-update.sh && chmod 777 /home/$USER/.librewolf -R && chmod 755 /home/$USER/.config -R && chmod 777 /home/$USER/.var/app -R && chmod 777 /home/$USER/.local/share/applications -R && grub-install && update-grub && reboot '
