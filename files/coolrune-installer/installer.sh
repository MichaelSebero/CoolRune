#!/bin/sh

su -c '
# CLEANUP
cleanup() {
    rm -rf /home/coolrune-files
    exit 1
}

trap cleanup INT TERM ERR EXIT



# COOLRUNE CHOICE SELECTION
echo "Select a CoolRune Variant"
echo "1. CoolRune-AMD"
echo "2. CoolRune-INTEL"
echo "3. CoolRune-NVIDIA-OPENSOURCE"
echo "4. CoolRune-NVIDIA-PROPRIETARY"

read -p "Enter your choice (1, 2, 3 or 4): " choice



### AMD CHOICE ###
if [ "$choice" = "1" ]; then

# FIRST COMMANDS AND COOLRUNE IMPORT
killall xfce4-screensaver && pacman -Sy --noconfirm --needed p7zip git && mkdir /home/coolrune-files && git clone https://github.com/MichaelSebero/CoolRune /home/coolrune-files && cd /home/coolrune-files/files/coolrune-packages && 7z e coolrune-pacman-1.7z -o/etc -y && pacman -Sy --noconfirm artix-archlinux-support && pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com && pacman-key --lsign-key 3056513887B78AEB && pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' && 7z e coolrune-pacman-2.7z -o/etc -y && chmod 755 /etc/pacman.conf && pacman-key --populate archlinux artix && pacman -Syyu --noconfirm --needed && mv /home/coolrune-files/files/coolrune-manual/Manual /home/$USER/Desktop &&

# REPO PACKAGES REMOVE
pacman -R --noconfirm nvidia nvidia-utils linux linux-headers pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-zeroconf epiphany xfce4-terminal xfce4-screenshooter parole xfce4-taskmanager mousepad leafpad xfburn ristretto xfce4-appfinder atril artix-branding-base artix-grub-theme xfce4-sensors-plugin xfce4-notes-plugin mpv && 

# REPO PACKAGES INSTALL
pacman -S --noconfirm --needed --ignore=vlc-git lib32-artix-archlinux-support base-devel flatpak kate librewolf python-pip tmux tealdeer jdownloader2 vulkan-icd-loader lib32-vulkan-icd-loader liferea ksnip kcalc font-manager gwenview gimp gamemode lib32-gamemode fail2ban fail2ban-s6 okular dnscrypt-proxy dnscrypt-proxy-s6 apparmor apparmor-s6 bleachbit blueman bluez-s6 konsole catfish clamav clamav-s6 ark gufw mugshot macchanger networkmanager networkmanager-s6 nm-connection-editor wine-ge-custom wine-mono winetricks ufw-s6 qbittorrent redshift steam lynis sneedacity element-desktop rkhunter paru proton-ge-custom lib32-mesa-tkg-git vulkan-radeon protontricks-git appimagelauncher opendoas linux-cachyos linux-cachyos-headers pamac-nosnap mate-system-monitor lightdm-gtk-greeter-settings downgrade libreoffice pipewire-pulse pipewire-alsa wireplumber wine-gecko rust python-psutil python-dateutil python-pydub python-xlib python-pyaudio python-pipenv usbguard usbguard-s6 hunspell-en_us gtk-engine-murrine vkbasalt lib32-vkbasalt chkrootkit testdisk yay && pacman -Rdd --noconfirm --nodeps vulkan-headers && pacman -S --noconfirm vulkan-headers-tkg-git && pacman -R --noconfirm vkd3d && pacman -S --noconfirm --needed vkd3d-proton-tkg-git python-matplotlib python-tqdm python-pillow python-pydub python-mutagen wget noto-fonts-emoji tk xfce4-panel-profiles poetry tauon-music-box yt-dlp pyenv lxsession doas-sudo-shim &&

# FLATPAK PACKAGES
flatpak remote-add flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo && flatpak install -y org.gnome.seahorse.Application/x86_64/stable org.kde.haruna &&

# PYTHON PACKAGES (MODULES NOT AVAILABLE IN REPO)
rm -rf /usr/lib/python3.12/EXTERNALLY-MANAGED && pip install --user imagehash pyzipper textract sounddevice tinytag eyed3 futures audioread librosa moviepy && cd /home/coolrune-files/files/coolrune-packages &&


# LAST COMMANDS AND COOLRUNE INSTALL
7z x coolrune-root.7z -o/ -y && chattr +i /etc/hosts && s6-service add default apparmor && s6-service add default fail2ban && s6-service add default NetworkManager && s6-service add default dnscrypt-proxy && s6-service add default ufw && rm /etc/s6/adminsv/default/contents.d/connmand && pacman -R --noconfirm connman-s6 connman connman-gtk && s6-db-reload && grub-mkconfig -o /boot/grub/grub.cfg && 7z x coolrune-dotfiles.7z -o/home/$USER -y &&

chmod 777 /home/$USER/.librewolf -R &&
chmod 777 /home/$USER/.config -R &&
chmod 777 /home/$USER/Desktop/Manual &&
chmod 777 /home/$USER/.local/share/applications -R &&
chmod 777 /home/$USER/.local/share/konsole -R &&
chmod 777 /home/$USER/.local/share/xfce4-panel-profile -R &&
chmod 777 /home/$USER/.var -R &&

cd /home/coolrune-files/files/hardening-script && sh hardening-script.sh && mv /etc/profile{,.old} && grub-install && update-grub && echo "CoolRune has been successfully installed." && reboot



### INTEL CHOICE ###
elif [ "$choice" = "2" ]; then

# FIRST COMMANDS AND COOLRUNE IMPORT
killall xfce4-screensaver && pacman -Sy --noconfirm --needed p7zip git && mkdir /home/coolrune-files && git clone https://github.com/MichaelSebero/CoolRune /home/coolrune-files && cd /home/coolrune-files/files/coolrune-packages && 7z e coolrune-pacman-1.7z -o/etc -y && pacman -Sy --noconfirm artix-archlinux-support && pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com && pacman-key --lsign-key 3056513887B78AEB && pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' && 7z e coolrune-pacman-2.7z -o/etc -y && chmod 755 /etc/pacman.conf && pacman-key --populate archlinux artix && pacman -Syyu --noconfirm --needed && mv /home/coolrune-files/files/coolrune-manual/Manual /home/$USER/Desktop &&

# REPO PACKAGES REMOVE
pacman -R --noconfirm nvidia nvidia-utils linux linux-headers pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-zeroconf epiphany xfce4-terminal xfce4-screenshooter parole xfce4-taskmanager mousepad leafpad xfburn ristretto xfce4-appfinder atril artix-branding-base artix-grub-theme xfce4-sensors-plugin xfce4-notes-plugin mpv && 

# REPO PACKAGES INSTALL
pacman -S --noconfirm --needed --ignore=vlc-git lib32-artix-archlinux-support base-devel flatpak kate librewolf python-pip tmux tealdeer jdownloader2 vulkan-icd-loader lib32-vulkan-icd-loader liferea ksnip kcalc font-manager gwenview gimp gamemode lib32-gamemode fail2ban fail2ban-s6 okular dnscrypt-proxy dnscrypt-proxy-s6 apparmor apparmor-s6 bleachbit blueman bluez-s6 konsole catfish clamav clamav-s6 ark gufw mugshot macchanger networkmanager networkmanager-s6 nm-connection-editor wine-ge-custom wine-mono winetricks ufw-s6 qbittorrent redshift steam lynis sneedacity element-desktop rkhunter paru proton-ge-custom lib32-mesa-tkg-git vulkan-intel protontricks-git appimagelauncher opendoas linux-cachyos linux-cachyos-headers pamac-nosnap mate-system-monitor lightdm-gtk-greeter-settings downgrade libreoffice pipewire-pulse pipewire-alsa wireplumber wine-gecko rust python-psutil python-dateutil python-pydub python-xlib python-pyaudio python-pipenv usbguard usbguard-s6 hunspell-en_us gtk-engine-murrine vkbasalt lib32-vkbasalt chkrootkit testdisk yay && pacman -Rdd --noconfirm --nodeps vulkan-headers && pacman -S --noconfirm vulkan-headers-tkg-git && pacman -R --noconfirm vkd3d && pacman -S --noconfirm --needed vkd3d-proton-tkg-git python-matplotlib python-tqdm python-pillow python-pydub python-mutagen wget noto-fonts-emoji tk xfce4-panel-profiles poetry tauon-music-box yt-dlp pyenv lxsession doas-sudo-shim &&

# FLATPAK PACKAGES
flatpak remote-add flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo && flatpak install -y org.gnome.seahorse.Application/x86_64/stable org.kde.haruna &&

# PYTHON PACKAGES (MODULES NOT AVAILABLE IN REPO)
rm -rf /usr/lib/python3.12/EXTERNALLY-MANAGED && pip install --user imagehash pyzipper textract sounddevice tinytag eyed3 futures audioread librosa moviepy && cd /home/coolrune-files/files/coolrune-packages &&

# LAST COMMANDS AND COOLRUNE INSTALL
7z x coolrune-root.7z -o/ -y && chattr +i /etc/hosts && s6-service add default apparmor && s6-service add default fail2ban && s6-service add default NetworkManager && s6-service add default dnscrypt-proxy && s6-service add default ufw && rm /etc/s6/adminsv/default/contents.d/connmand && pacman -R --noconfirm connman-s6 connman connman-gtk && s6-db-reload && grub-mkconfig -o /boot/grub/grub.cfg && 7z x coolrune-dotfiles.7z -o/home/$USER -y &&

chmod 777 /home/$USER/.librewolf -R &&
chmod 777 /home/$USER/.config -R &&
chmod 777 /home/$USER/Desktop/Manual &&
chmod 777 /home/$USER/.local/share/applications -R &&
chmod 777 /home/$USER/.local/share/konsole -R &&
chmod 777 /home/$USER/.local/share/xfce4-panel-profile -R &&
chmod 777 /home/$USER/.var -R &&

cd /home/coolrune-files/files/hardening-script && sh hardening-script.sh && mv /etc/profile{,.old} && grub-install && update-grub && echo "CoolRune has been successfully installed." && reboot



### NVIDIA OPENSOURCE CHOICE ###
elif [ "$choice" = "3" ]; then

# FIRST COMMANDS AND COOLRUNE IMPORT
killall xfce4-screensaver && pacman -Sy --noconfirm --needed p7zip git && mkdir /home/coolrune-files && git clone https://github.com/MichaelSebero/CoolRune /home/coolrune-files && cd /home/coolrune-files/files/coolrune-packages && 7z e coolrune-pacman-1.7z -o/etc -y && pacman -Sy --noconfirm artix-archlinux-support && pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com && pacman-key --lsign-key 3056513887B78AEB && pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' && 7z e coolrune-pacman-2.7z -o/etc -y && chmod 755 /etc/pacman.conf && pacman-key --populate archlinux artix && pacman -Syyu --noconfirm --needed && mv /home/coolrune-files/files/coolrune-manual/Manual /home/$USER/Desktop &&

# REPO PACKAGES REMOVE
pacman -R --noconfirm nvidia linux linux-headers pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-zeroconf epiphany xfce4-terminal xfce4-screenshooter parole xfce4-taskmanager mousepad leafpad xfburn ristretto xfce4-appfinder atril artix-branding-base artix-grub-theme xfce4-sensors-plugin xfce4-notes-plugin mpv && 

# REPO PACKAGES INSTALL
pacman -S --noconfirm --needed --ignore=nvidia-390xx-utils,lib32-nvidia-390xx-utils,vlc-git lib32-artix-archlinux-support base-devel flatpak kate librewolf python-pip tmux tealdeer jdownloader2 vulkan-icd-loader lib32-vulkan-icd-loader liferea ksnip kcalc font-manager gwenview gimp gamemode lib32-gamemode fail2ban fail2ban-s6 okular dnscrypt-proxy dnscrypt-proxy-s6 apparmor apparmor-s6 bleachbit blueman bluez-s6 konsole catfish clamav clamav-s6 ark gufw mugshot macchanger networkmanager networkmanager-s6 nm-connection-editor wine-ge-custom wine-mono winetricks ufw-s6 qbittorrent redshift steam lynis sneedacity element-desktop rkhunter paru proton-ge-custom nvidia-open-dkms nvidia-utils nvidia-utils-s6 lib32-nvidia-utils nvidia-settings protontricks-git appimagelauncher opendoas linux-cachyos linux-cachyos-headers pamac-nosnap mate-system-monitor lightdm-gtk-greeter-settings downgrade libreoffice pipewire-pulse pipewire-alsa wireplumber wine-gecko rust python-psutil python-dateutil python-pydub python-xlib python-pyaudio python-pipenv usbguard usbguard-s6 hunspell-en_us gtk-engine-murrine vkbasalt lib32-vkbasalt chkrootkit testdisk yay && pacman -Rdd --noconfirm --nodeps vulkan-headers && pacman -S --noconfirm vulkan-headers-tkg-git && pacman -R --noconfirm vkd3d && pacman -S --noconfirm --needed vkd3d-proton-tkg-git python-matplotlib python-tqdm python-pillow python-pydub python-mutagen wget noto-fonts-emoji tk xfce4-panel-profiles poetry tauon-music-box yt-dlp pyenv lxsession doas-sudo-shim &&

# FLATPAK PACKAGES
flatpak remote-add flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo && flatpak install -y org.gnome.seahorse.Application/x86_64/stable org.kde.haruna com.leinardi.gwe &&

# PYTHON PACKAGES (MODULES NOT AVAILABLE IN REPO)
rm -rf /usr/lib/python3.12/EXTERNALLY-MANAGED && pip install --user imagehash pyzipper textract sounddevice tinytag eyed3 futures audioread librosa moviepy && cd /home/coolrune-files/files/coolrune-packages &&

# LAST COMMANDS AND COOLRUNE INSTALL
7z x coolrune-root.7z -o/ -y && 7z x coolrune-nvidia-patch.7z -o/ -y && chattr +i /etc/hosts && s6-service add default apparmor && s6-service add default fail2ban && s6-service add default NetworkManager && s6-service add default dnscrypt-proxy && s6-service add default ufw && rm /etc/s6/adminsv/default/contents.d/connmand && pacman -R --noconfirm connman-s6 connman connman-gtk && s6-db-reload && grub-mkconfig -o /boot/grub/grub.cfg && 7z x coolrune-dotfiles.7z -o/home/$USER -y &&

chmod 777 /home/$USER/.librewolf -R &&
chmod 777 /home/$USER/.config -R &&
chmod 777 /home/$USER/Desktop/Manual &&
chmod 777 /home/$USER/.local/share/applications -R &&
chmod 777 /home/$USER/.local/share/konsole -R &&
chmod 777 /home/$USER/.local/share/xfce4-panel-profile -R &&
chmod 777 /home/$USER/.var -R &&

cd /home/coolrune-files/files/hardening-script && sh hardening-script.sh && mv /etc/profile{,.old} && grub-install && update-grub && echo "CoolRune has been successfully installed." && reboot



### NVIDIA PROPRIETARY CHOICE ###
elif [ "$choice" = "4" ]; then

# FIRST COMMANDS AND COOLRUNE IMPORT
killall xfce4-screensaver && pacman -Sy --noconfirm --needed p7zip git && mkdir /home/coolrune-files && git clone https://github.com/MichaelSebero/CoolRune /home/coolrune-files && cd /home/coolrune-files/files/coolrune-packages && 7z e coolrune-pacman-1.7z -o/etc -y && pacman -Sy --noconfirm artix-archlinux-support && pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com && pacman-key --lsign-key 3056513887B78AEB && pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' && 7z e coolrune-pacman-2.7z -o/etc -y && chmod 755 /etc/pacman.conf && pacman-key --populate archlinux artix && pacman -Syyu --noconfirm --needed && mv /home/coolrune-files/files/coolrune-manual/Manual /home/$USER/Desktop &&

# REPO PACKAGES REMOVE
pacman -R --noconfirm nvidia linux linux-headers pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-zeroconf epiphany xfce4-terminal xfce4-screenshooter parole xfce4-taskmanager mousepad leafpad xfburn ristretto xfce4-appfinder atril artix-branding-base artix-grub-theme xfce4-sensors-plugin xfce4-notes-plugin mpv && 

# REPO PACKAGES INSTALL
pacman -S --noconfirm --needed --ignore=nvidia-390xx-utils,lib32-nvidia-390xx-utils,vlc-git lib32-artix-archlinux-support base-devel flatpak kate librewolf python-pip tmux tealdeer jdownloader2 vulkan-icd-loader lib32-vulkan-icd-loader liferea ksnip kcalc font-manager gwenview gimp gamemode lib32-gamemode fail2ban fail2ban-s6 okular dnscrypt-proxy dnscrypt-proxy-s6 apparmor apparmor-s6 bleachbit blueman bluez-s6 konsole catfish clamav clamav-s6 ark gufw mugshot macchanger networkmanager networkmanager-s6 nm-connection-editor wine-ge-custom wine-mono winetricks ufw-s6 qbittorrent redshift steam lynis sneedacity element-desktop rkhunter paru proton-ge-custom nvidia-dkms nvidia-utils nvidia-utils-s6 lib32-nvidia-utils nvidia-settings protontricks-git appimagelauncher opendoas linux-cachyos linux-cachyos-headers pamac-nosnap mate-system-monitor lightdm-gtk-greeter-settings downgrade libreoffice pipewire-pulse pipewire-alsa wireplumber wine-gecko rust python-psutil python-dateutil python-pydub python-xlib python-pyaudio python-pipenv usbguard usbguard-s6 hunspell-en_us gtk-engine-murrine vkbasalt lib32-vkbasalt chkrootkit testdisk yay && pacman -Rdd --noconfirm --nodeps vulkan-headers && pacman -S --noconfirm vulkan-headers-tkg-git && pacman -R --noconfirm vkd3d && pacman -S --noconfirm --needed vkd3d-proton-tkg-git python-matplotlib python-tqdm python-pillow python-pydub python-mutagen wget noto-fonts-emoji tk xfce4-panel-profiles poetry tauon-music-box yt-dlp pyenv lxsession doas-sudo-shim &&

# FLATPAK PACKAGES
flatpak remote-add flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo && flatpak install -y org.gnome.seahorse.Application/x86_64/stable org.kde.haruna com.leinardi.gwe &&

# PYTHON PACKAGES (MODULES NOT AVAILABLE IN REPO)
rm -rf /usr/lib/python3.12/EXTERNALLY-MANAGED && pip install --user imagehash pyzipper textract sounddevice tinytag eyed3 futures audioread librosa moviepy && cd /home/coolrune-files/files/coolrune-packages &&

# LAST COMMANDS AND COOLRUNE INSTALL
7z x coolrune-root.7z -o/ -y && 7z x coolrune-nvidia-patch.7z -o/ -y && chattr +i /etc/hosts && s6-service add default apparmor && s6-service add default fail2ban && s6-service add default NetworkManager && s6-service add default dnscrypt-proxy && s6-service add default ufw && rm /etc/s6/adminsv/default/contents.d/connmand && pacman -R --noconfirm connman-s6 connman connman-gtk && s6-db-reload && grub-mkconfig -o /boot/grub/grub.cfg && 7z x coolrune-dotfiles.7z -o/home/$USER -y &&

chmod 777 /home/$USER/.librewolf -R &&
chmod 777 /home/$USER/.config -R &&
chmod 777 /home/$USER/Desktop/Manual &&
chmod 777 /home/$USER/.local/share/applications -R &&
chmod 777 /home/$USER/.local/share/konsole -R &&
chmod 777 /home/$USER/.local/share/xfce4-panel-profile -R &&
chmod 777 /home/$USER/.var -R &&

cd /home/coolrune-files/files/hardening-script && sh hardening-script.sh && mv /etc/profile{,.old} && grub-install && update-grub && echo "CoolRune has been successfully installed." && reboot
fi
'
