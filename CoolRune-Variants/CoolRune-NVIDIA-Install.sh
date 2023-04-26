#!/bin/sh

# License: GNU GPLv3

# SCRIPT VOCABULARY / USER MODIFICATION SECTION
su -c '
pacman1="curl -RO https://raw.githubusercontent.com/MichaelSebero/CoolRune/master/CoolRune-Pacman-1.7z"
pacman2="curl -RO https://raw.githubusercontent.com/MichaelSebero/CoolRune/master/CoolRune-Pacman-2.7z"
root_files="curl -RO https://raw.githubusercontent.com/MichaelSebero/CoolRune/master/CoolRune-Root.7z"
dotfiles="curl -RO https://raw.githubusercontent.com/MichaelSebero/CoolRune/master/CoolRune-Dotfiles.7z"
nvidia_patch="curl -RO https://raw.githubusercontent.com/MichaelSebero/CoolRune/master/CoolRune-NVIDIA-Patch.7z"
bwr1="curl -RO https://raw.githubusercontent.com/MichaelSebero/BWR_Frequencies/master/BWR_Frequencies_p1.7z"
bwr2="curl -RO https://raw.githubusercontent.com/MichaelSebero/BWR_Frequencies/master/BWR_Frequencies_p2.7z"
bwr3="curl -RO https://raw.githubusercontent.com/MichaelSebero/BWR_Frequencies/master/BWR_Frequencies_p3.7z"

# FIRST COMMANDS AND COOLRUNE IMPORT
pacman-key --init && pacman -Sy --noconfirm --needed p7zip glibc git && mkdir /home/CoolRune-Files && cd /home/CoolRune-Files && eval $pacman1 && eval $pacman2 && eval $root_files && eval $dotfiles && eval $nvidia_patch && eval $bwr1 && eval $bwr2 && eval $bwr3 && 7z e CoolRune-Pacman-1.7z -o/etc -y && pacman-key --refresh && pacman -Sy --noconfirm --needed artix-keyring archlinux-keyring artix-archlinux-support && pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com && pacman-key --lsign-key FBA220DFC880C036 && pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' && 7z e CoolRune-Pacman-2.7z -o/etc -y && pacman-key --populate archlinux artix && pacman -Syyu --noconfirm --needed &&

# PACKAGES
pacman -S --noconfirm --needed lib32-artix-archlinux-support base-devel flatpak kate librewolf python-pip tmux tealdeer jdownloader2 vulkan-icd-loader lib32-vulkan-icd-loader ksysguard liferea gnome-screenshot gnome-keyring gnome-calculator font-manager gwenview vim gimp gamemode lib32-gamemode fail2ban fail2ban-s6 evince dnscrypt-proxy dnscrypt-proxy-s6 apparmor apparmor-s6 bleachbit blueman unrar bluez-s6 konsole catfish clamav clamav-s6 ark devilspie gufw mugshot macchanger networkmanager networkmanager-s6 nm-connection-editor wine-ge-custom wine-mono winetricks ufw-s6 pcmanfm pavucontrol qbittorrent redshift pulseaudio-alsa psensor ntfs-3g steam lynis tenacity-git element-desktop pulsemixer rkhunter paru proton-ge-custom && pacman -R --noconfirm nvidia && pacman -S --noconfirm --needed nvidia-dkms nvidia-utils nvidia-utils-s6 lib32-nvidia-utils nvidia-settings protontricks-git mystiq appimagelauncher opendoas linux-tkg-pds linux-tkg-pds-headers pamac-nosnap gnome-disk-utility tk lightdm-gtk-greeter-settings pantheon-calendar downgrade portmidi shellcheck npm &&

# FLATPAK PACKAGES
flatpak install -y io.github.celluloid_player.Celluloid org.libreoffice.LibreOffice io.github.prateekmedia.appimagepool org.gnome.seahorse.Application/x86_64/stable &&

# PYTHON MODULES
pip install psutil python-dateutil pydub xlib &&

# LAST COMMANDS AND COOLRUNE INSTALL
pacman -R --noconfirm linux linux-headers epiphany xfce4-terminal xfce4-screenshooter parole xfce4-taskmanager mousepad leafpad xfburn ristretto xfce4-appfinder atril artix-branding-base artix-grub-theme mpv xfce4-sensors-plugin xfce4-notes-plugin && 7z x CoolRune-Root.7z -o/ -y && 7z x CoolRune-NVIDIA-Patch.7z -o/ -y && 7z x CoolRune-Dotfiles.7z -o/home/$USER -y && chattr +i /etc/hosts && s6-service add default apparmor && s6-service add default fail2ban && s6-service add default NetworkManager && s6-service add default dnscrypt-proxy && s6-service add default ufw && rm /etc/s6/adminsv/default/contents.d/connmand && pacman -R --noconfirm connman-s6 connman connman-gtk && s6-db-reload && grub-mkconfig -o /boot/grub/grub.cfg && chmod 777 /home/$USER/.librewolf -R && chmod 777 /home/$USER/.config -R && chmod 777 /home/$USER/.var/io.github.celluloid_player.Celluloid -R && chmod 777 /home/$USER/.var/app -R && 7z x BWR_Frequencies_p1.7z -o/-CoolRune-/System_Sounds -y && 7z x BWR_Frequencies_p2.7z -o/-CoolRune-/System_Sounds -y && 7z x BWR_Frequencies_p3.7z -o/-CoolRune-/System_Sounds -y && grub-install && update-grub && rm -rf /home/CoolRune-Files && reboot '
