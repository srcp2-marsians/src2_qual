#!/usr/bin/env bash

# Fail on first error.
set -e

echo "Setting up user parameters..."

# Add basic user
USER_NAME=marsians
useradd -m $USER_NAME
echo "$USER_NAME:$USER_NAME" | chpasswd

adduser --disabled-password --gecos '' ${USER_NAME}
# usermod --shell /bin/bash $USER_NAME
usermod -aG sudo ${USER_NAME}
echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USER_NAME
# chmod 0440 /etc/sudoers.d/$USER_NAME

# Replace 1000 with your user/group id
# usermod  --uid 1000 $USER_NAME
# groupmod --gid 1000 $USER_NAME

echo """
ulimit -c unlimited
""" >> /home/${USER_NAME}/.bashrc

#Fix for qt and X server errors
echo "export QT_X11_NO_MITSHM=1" >> /home/$USER_NAME/.bashrc && \
# cd to home on login
echo "cd" >> /home/$USER_NAME/.bashrc

# Setting language
LANG="en_US.UTF-8"
echo "export LANG=\"en_US.UTF-8\"" >> /home/$USER_NAME/.bashrc
