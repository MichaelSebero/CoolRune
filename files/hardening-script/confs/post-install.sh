#!/bin/bash

locale-gen
loadkeys /usr/share/kbd/keymaps/i386/qwerty/uk.map.gz
mandb --quiet

ln -s /bin/bash /bin/rbash
ln -s /bin/zsh /bin/rzsh

groupadd surfer
useradd surfer -s /bin/rbash -g surfer

mkdir /home/surfer
chown surfer:surfer /home/surfer

chmod 700 /usr/bin/as
chmod 700 /usr/bin/gcc
chmod 700 /usr/bin/g++
chmod 700 /usr/bin/ld
chmod 700 /usr/lib/hardening-wrapper/bin/*

systemctl enable multi-user.target
systemctl enable iptables.service
systemctl enable ip6tables.service

rkhunter -c
rkhunter --propupd

#We no longer need the Orignal Linux Kernel since this is a GrSec setup
pacman -R linux

chsh -s /bin/zsh

echo "Running aide initial database for checksum verification."

aide -i

echo "Please backup the following file /var/lib/aide/aide.db.initial.gz to a safe location not on this system!"
cp /var/lib/aide/aide.db.gz /var/lib/aide/aide.db.initial.gz
sleep 5

lynix audit system --auditor "Base Installation"

echo "Dont forget to set passwords for all users root and surfer!"
sleep 2

echo "Post Installation completed!"
exit 0
