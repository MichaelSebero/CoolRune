#!/bin/bash

# Create symlinks for restricted shells
ln -s /bin/bash /bin/rbash
ln -s /bin/zsh /bin/rzsh

# Restrict permissions for compiler and linker binaries
chmod 700 /usr/bin/as
chmod 700 /usr/bin/gcc
chmod 700 /usr/bin/g++
chmod 700 /usr/bin/ld

# Change default shell to zsh
chsh -s /bin/zsh

# AIDE initialization for checksum verification
aide -i
cp /var/lib/aide/aide.db.gz /var/lib/aide/aide.db.initial.gz
sleep 5

exit 0
