#!/bin/sh

su -c '
# CLEANUP
cleanup() {
    rm -rf /home/coolrune-files
    exit 1
}

trap cleanup INT TERM ERR EXIT

# SCRIPT VOCABULARY / USER MODIFICATION SECTION
pacman1="wget https://github.com/MichaelSebero/CoolRune/raw/main/files/coolrune-packages/coolrune-pacman-1.7z"
pacman2="wget https://github.com/MichaelSebero/CoolRune/raw/main/files/coolrune-packages/coolrune-pacman-2.7z"
root_files="wget https://github.com/MichaelSebero/CoolRune/raw/main/files/coolrune-packages/coolrune-root.7z"
dotfiles="wget https://github.com/MichaelSebero/CoolRune/raw/main/files/coolrune-packages/coolrune-dotfiles.7z"
hardening_script="svn export https://github.com/MichaelSebero/CoolRune/trunk/files/hardening-script"
nvidia_patch="wget https://github.com/MichaelSebero/CoolRune/raw/main/files/coolrune-packages/coolrune-nvidia-patch.7z"

# COOLRUNE CHOICE SELECTION
echo "Select a CoolRune Variant"
echo "1. CoolRune-AMD"
echo "2. CoolRune-INTEL"
echo "3. CoolRune-NVIDIA"
read -p "Enter your choice (1, 2 or 3): " choice



### AMD CHOICE ###
if [ "$choice" = "1" ]; then
# FIRST COMMANDS AND COOLRUNE IMPORT
pacman-key --init && pacman -Sy --noconfirm --needed p7zip git subversion wget && mkdir /home/coolrune-files && cd /home/coolrune-files && eval $pacman1 && eval $pacman2 && eval $root_files && eval $hardening_script && 7z e coolrune-pacman-1.7z -o/etc -y && pacman -Sy --noconfirm --needed artix-keyring archlinux-keyring artix-archlinux-support && pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com && pacman-key --lsign-key 3056513887B78AEB && pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' && 7z e coolrune-pacman-2.7z -o/etc -y && pacman-key --populate archlinux artix && pacman -Syyu --noconfirm --needed --ignore=nvidia,nvidia-utils && eval $dotfiles &&

# REPO PACKAGES
pacman -R --noconfirm linux linux-headers pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-zeroconf epiphany xfce4-terminal xfce4-screenshooter parole xfce4-taskmanager mousepad leafpad xfburn ristretto xfce4-appfinder atril artix-branding-base artix-grub-theme mpv xfce4-sensors-plugin xfce4-notes-plugin && pacman -S --noconfirm --needed lib32-artix-archlinux-support base-devel flatpak kate librewolf python-pip tmux tealdeer jdownloader2 vulkan-icd-loader lib32-vulkan-icd-loader liferea ksnip gnome-keyring kcalc font-manager gwenview gimp gamemode lib32-gamemode fail2ban fail2ban-s6 evince dnscrypt-proxy dnscrypt-proxy-s6 apparmor apparmor-s6 bleachbit blueman unrar bluez-s6 konsole catfish clamav clamav-s6 ark gufw mugshot macchanger networkmanager networkmanager-s6 nm-connection-editor wine-ge-custom wine-mono winetricks ufw-s6 pcmanfm pavucontrol qbittorrent redshift psensor ntfs-3g steam lynis tenacity-git element-desktop rkhunter paru proton-ge-custom lib32-mesa vulkan-radeon lib32-vulkan-radeon protontricks-git mystiq appimagelauncher opendoas linux-tkg-pds linux-tkg-pds-headers pamac-nosnap plasma-systemmonitor tk lightdm-gtk-greeter-settings kalendar downgrade portmidi shellcheck npm libreoffice pipewire-pulse pipewire-alsa wireplumber gparted obs-studio wine-gecko rust python-psutil python-dateutil python-pydub python-xlib python-pyaudio python-pipenv python-textract spice-vdagent find-the-command plasma &&

# FLATPAK PACKAGES
flatpak install -y io.github.celluloid_player.Celluloid org.gnome.seahorse.Application/x86_64/stable &&

# LAST COMMANDS AND COOLRUNE INSTALL
7z x coolrune-root.7z -o/ -y && 7z x coolrune-dotfiles.7z -o/home/$USER -y && chattr +i /etc/hosts && s6-service add default apparmor && s6-service add default fail2ban && s6-service add default NetworkManager && s6-service add default dnscrypt-proxy && s6-service add default ufw && rm /etc/s6/adminsv/default/contents.d/connmand && pacman -R --noconfirm connman-s6 connman connman-gtk && s6-db-reload && grub-mkconfig -o /boot/grub/grub.cfg && chmod 777 /home/$USER/.librewolf -R && chmod 777 "/home/$USER/Desktop/CoolRune Manual" && chmod 777 /home/$USER/.config -R && chmod 777 /home/$USER/.var/io.github.celluloid_player.Celluloid -R && chmod 777 /home/$USER/.var/app -R && chmod 777 /home/$USER/.local/share/applications -R && cd /home/coolrune-files/hardening-script && sh hardening-script.sh && mv /etc/profile{,.old} && grub-install && update-grub && echo "CoolRune has been successfully installed." && reboot



### INTEL CHOICE ###
elif [ "$choice" = "2" ]; then
# FIRST COMMANDS AND COOLRUNE IMPORT
pacman-key --init && pacman -Sy --noconfirm --needed p7zip git subversion wget && mkdir /home/coolrune-files && cd /home/coolrune-files && eval $pacman1 && eval $pacman2 && eval $root_files && eval $hardening_script && 7z e coolrune-pacman-1.7z -o/etc -y && pacman -Sy --noconfirm --needed artix-keyring archlinux-keyring artix-archlinux-support && pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com && pacman-key --lsign-key 3056513887B78AEB && pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' && 7z e coolrune-pacman-2.7z -o/etc -y && pacman-key --populate archlinux artix && pacman -Syyu --noconfirm --needed --ignore=nvidia,nvidia-utils && eval $dotfiles &&

# REPO PACKAGES
pacman -R --noconfirm linux linux-headers pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-zeroconf epiphany xfce4-terminal xfce4-screenshooter parole xfce4-taskmanager mousepad leafpad xfburn ristretto xfce4-appfinder atril artix-branding-base artix-grub-theme mpv xfce4-sensors-plugin xfce4-notes-plugin && pacman -S --noconfirm --needed lib32-artix-archlinux-support base-devel flatpak kate librewolf python-pip tmux tealdeer jdownloader2 vulkan-icd-loader lib32-vulkan-icd-loader liferea ksnip gnome-keyring kcalc font-manager gwenview gimp gamemode lib32-gamemode fail2ban fail2ban-s6 evince dnscrypt-proxy dnscrypt-proxy-s6 apparmor apparmor-s6 bleachbit blueman unrar bluez-s6 konsole catfish clamav clamav-s6 ark gufw mugshot macchanger networkmanager networkmanager-s6 nm-connection-editor wine-ge-custom wine-mono winetricks ufw-s6 pcmanfm pavucontrol qbittorrent redshift psensor ntfs-3g steam lynis tenacity-git element-desktop rkhunter paru proton-ge-custom lib32-mesa vulkan-intel lib32-vulkan-intel protontricks-git mystiq appimagelauncher opendoas linux-tkg-pds linux-tkg-pds-headers pamac-nosnap plasma-systemmonitor tk lightdm-gtk-greeter-settings kalendar downgrade portmidi shellcheck npm libreoffice pipewire-pulse pipewire-alsa wireplumber gparted obs-studio wine-gecko rust python-psutil python-dateutil python-pydub python-xlib python-pyaudio python-pipenv python-textract spice-vdagent find-the-command plasma &&

# FLATPAK PACKAGES
flatpak install -y io.github.celluloid_player.Celluloid org.gnome.seahorse.Application/x86_64/stable &&

# LAST COMMANDS AND COOLRUNE INSTALL
7z x coolrune-root.7z -o/ -y && 7z x coolrune-dotfiles.7z -o/home/$USER -y && chattr +i /etc/hosts && s6-service add default apparmor && s6-service add default fail2ban && s6-service add default NetworkManager && s6-service add default dnscrypt-proxy && s6-service add default ufw && rm /etc/s6/adminsv/default/contents.d/connmand && pacman -R --noconfirm connman-s6 connman connman-gtk && s6-db-reload && grub-mkconfig -o /boot/grub/grub.cfg && chmod 777 /home/$USER/.librewolf -R && chmod 777 "/home/$USER/Desktop/CoolRune Manual" && chmod 777 /home/$USER/.config -R && chmod 777 /home/$USER/.var/io.github.celluloid_player.Celluloid -R && chmod 777 /home/$USER/.var/app -R && chmod 777 /home/$USER/.local/share/applications -R && cd /home/coolrune-files/hardening-script && sh hardening-script.sh && mv /etc/profile{,.old} && grub-install && update-grub && echo "CoolRune has been successfully installed." && reboot



### NVIDIA CHOICE ###
elif [ "$choice" = "3" ]; then
# FIRST COMMANDS AND COOLRUNE IMPORT
pacman-key --init && pacman -Sy --noconfirm --needed p7zip git subversion wget && mkdir /home/coolrune-files && cd /home/coolrune-files && eval $pacman1 && eval $pacman2 && eval $root_files && eval $nvidia_patch && eval $hardening_script && 7z e coolrune-pacman-1.7z -o/etc -y && pacman -Sy --noconfirm --needed artix-keyring archlinux-keyring artix-archlinux-support && pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com && pacman-key --lsign-key 3056513887B78AEB && pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' && 7z e coolrune-pacman-2.7z -o/etc -y && pacman-key --populate archlinux artix && pacman -Syyu --noconfirm --needed --ignore=nvidia,nvidia-utils && eval $dotfiles &&

# REPO PACKAGES
pacman -R --noconfirm linux linux-headers pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-zeroconf epiphany xfce4-terminal xfce4-screenshooter parole xfce4-taskmanager mousepad leafpad xfburn ristretto xfce4-appfinder atril artix-branding-base artix-grub-theme mpv xfce4-sensors-plugin xfce4-notes-plugin && pacman -S --noconfirm --needed lib32-artix-archlinux-support base-devel flatpak kate librewolf python-pip tmux tealdeer jdownloader2 vulkan-icd-loader lib32-vulkan-icd-loader liferea ksnip gnome-keyring kcalc font-manager gwenview gimp gamemode lib32-gamemode fail2ban fail2ban-s6 evince dnscrypt-proxy dnscrypt-proxy-s6 apparmor apparmor-s6 bleachbit blueman unrar bluez-s6 konsole catfish clamav clamav-s6 ark gufw mugshot macchanger networkmanager networkmanager-s6 nm-connection-editor wine-ge-custom wine-mono winetricks ufw-s6 pcmanfm pavucontrol qbittorrent redshift psensor ntfs-3g steam lynis tenacity-git element-desktop rkhunter paru proton-ge-custom nvidia-dkms nvidia-utils nvidia-utils-s6 lib32-nvidia-utils nvidia-settings protontricks-git mystiq appimagelauncher opendoas linux-tkg-pds linux-tkg-pds-headers pamac-nosnap plasma-systemmonitor tk lightdm-gtk-greeter-settings kalendar downgrade portmidi shellcheck npm libreoffice pipewire-pulse pipewire-alsa wireplumber gparted obs-studio wine-gecko rust python-psutil python-dateutil python-pydub python-xlib python-pyaudio python-pipenv python-textract spice-vdagent find-the-command plasma &&

# FLATPAK PACKAGES
flatpak install -y io.github.celluloid_player.Celluloid org.gnome.seahorse.Application/x86_64/stable &&

# LAST COMMANDS AND COOLRUNE INSTALL
7z x coolrune-root.7z -o/ -y && 7z x coolrune-nvidia-patch.7z -o/ -y && 7z x coolrune-dotfiles.7z -o/home/$USER -y && chattr +i /etc/hosts && s6-service add default apparmor && s6-service add default fail2ban && s6-service add default NetworkManager && s6-service add default dnscrypt-proxy && s6-service add default ufw && rm /etc/s6/adminsv/default/contents.d/connmand && pacman -R --noconfirm connman-s6 connman connman-gtk && s6-db-reload && grub-mkconfig -o /boot/grub/grub.cfg && chmod 777 "/home/$USER/Desktop/CoolRune Manual" && chmod 777 /home/$USER/.librewolf -R && chmod 777 /home/$USER/.config -R && chmod 777 /home/$USER/.var/io.github.celluloid_player.Celluloid -R && chmod 777 /home/$USER/.var/app -R && chmod 777 /home/$USER/.local/share/applications -R && cd /home/coolrune-files/hardening-script && sh hardening-script.sh && mv /etc/profile{,.old} && grub-install && update-grub && echo "CoolRune has been successfully installed." && reboot
fi
'
