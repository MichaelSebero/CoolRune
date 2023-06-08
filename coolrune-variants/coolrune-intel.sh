#!/bin/sh

# License: GNU GPLv3

# SCRIPT VOCABULARY / USER MODIFICATION SECTION
su -c '
pacman1="wget https://github.com/MichaelSebero/CoolRune/raw/main/coolrune-files/coolrune-pacman-1.7z"
pacman2="wget https://github.com/MichaelSebero/CoolRune/raw/main/coolrune-files/coolrune-pacman-2.7z"
root_files="wget https://github.com/MichaelSebero/CoolRune/raw/main/coolrune-files/coolrune-root.7z"
dotfiles="wget https://github.com/MichaelSebero/CoolRune/raw/main/coolrune-files/coolrune-dotfiles.7z"
hardening_script="svn export https://github.com/MichaelSebero/CoolRune/trunk/coolrune-files/hardening-script"

# FIRST COMMANDS AND COOLRUNE IMPORT
pacman-key --init && pacman -Sy --noconfirm --needed p7zip git subversion wget && mkdir /home/coolrune-files && cd /home/coolrune-files && eval $pacman1 && eval $pacman2 && eval $root_files && eval $hardening_script && 7z e coolrune-pacman-1.7z -o/etc -y && pacman -Sy --noconfirm --needed artix-keyring archlinux-keyring artix-archlinux-support && pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com && pacman-key --lsign-key FBA220DFC880C036 && pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' && 7z e coolrune-pacman-2.7z -o/etc -y && pacman-key --populate archlinux artix && pacman -Syyu --noconfirm --needed && eval $dotfiles &&

# PACKAGES
pacman -R --noconfirm pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-zeroconf && pacman -S --noconfirm --needed lib32-artix-archlinux-support base-devel flatpak kate librewolf python-pip tmux tealdeer jdownloader2 vulkan-icd-loader lib32-vulkan-icd-loader liferea ksnip gnome-keyring kcalc font-manager gwenview gimp gamemode lib32-gamemode fail2ban fail2ban-s6 evince dnscrypt-proxy dnscrypt-proxy-s6 apparmor apparmor-s6 bleachbit blueman unrar bluez-s6 konsole catfish clamav clamav-s6 ark devilspie gufw mugshot macchanger networkmanager networkmanager-s6 nm-connection-editor wine-ge-custom wine-mono winetricks ufw-s6 pcmanfm pavucontrol qbittorrent redshift psensor ntfs-3g steam lynis tenacity-git element-desktop rkhunter paru proton-ge-custom lib32-mesa vulkan-intel lib32-vulkan-intel protontricks-git mystiq appimagelauncher opendoas linux-tkg-pds linux-tkg-pds-headers pamac-nosnap plasma-systemmonitor tk lightdm-gtk-greeter-settings kalendar downgrade portmidi shellcheck npm libreoffice pipewire-pulse pipewire-alsa wireplumber gparted obs-studio kdenlive wine-gecko &&

# FLATPAK PACKAGES
flatpak install -y io.github.celluloid_player.Celluloid io.github.prateekmedia.appimagepool org.gnome.seahorse.Application/x86_64/stable &&

# PYTHON MODULES
pip install psutil python-dateutil pydub xlib pyaudio textract --user &&

# LAST COMMANDS AND COOLRUNE INSTALL
pacman -R --noconfirm linux linux-headers epiphany xfce4-terminal xfce4-screenshooter parole xfce4-taskmanager mousepad leafpad xfburn ristretto xfce4-appfinder atril artix-branding-base artix-grub-theme mpv xfce4-sensors-plugin xfce4-notes-plugin && 7z x coolrune-root.7z -o/ -y && 7z x coolrune-dotfiles.7z -o/home/$USER -y && chattr +i /etc/hosts && s6-service add default apparmor && s6-service add default fail2ban && s6-service add default NetworkManager && s6-service add default dnscrypt-proxy && s6-service add default ufw && rm /etc/s6/adminsv/default/contents.d/connmand && pacman -R --noconfirm connman-s6 connman connman-gtk && s6-db-reload && grub-mkconfig -o /boot/grub/grub.cfg && chmod 777 /home/$USER/.librewolf -R && chmod 777 "/home/$USER/Desktop/CoolRune Manual" && chmod 777 /home/$USER/.config -R && chmod 777 /home/$USER/.var/io.github.celluloid_player.Celluloid -R && chmod 777 /home/$USER/.var/app -R && chmod 777 /home/$USER/.local/share/applications -R && grub-install && update-grub && cd /home/coolrune-files/hardening-script && sh hardening-script.sh && rm -rf /home/coolrune-files && reboot '
