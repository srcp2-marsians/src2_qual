#!/usr/bin/env bash

# Fail on first error.
set -e

echo "Preparing package installation..."

# Install common tools.
apt-get update && apt-get install -y \
    apt-transport-https \
    build-essential \
    kmod \
    python-pip \
    python-dev \
    cmake \
    curl \
    software-properties-common \
    wget \
    unzip \
    git
export DEBIAN_FRONTEND=noninteractive
apt-get install -y tzdata
# set your timezone
ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata

# Install develop tools    # linux-headers-generic breaks linuxcan
apt-get update && apt-get install -y \
    software-properties-common \
    cmake-curses-gui \
    libboost-all-dev \
    libflann-dev \
    libgsl0-dev \
    libeigen3-dev \
    build-essential \
    libprotobuf-c0-dev \
    dkms \



# Install extra dev tools
apt-get update && apt-get install -y \
    vim-gtk \
    tmux \
    bc \
    cppcheck \
    debconf-utils \
    doxygen \
    doxygen-gui \
    graphviz \
    gdb \
    zip \
    ca-certificates \
    make \
    automake \
    autoconf \
    libtool \
    pkg-config \
    python \
    libxext-dev \
    libx11-dev \
    octave \
    clang-format-3.9 \
    x11proto-gl-dev && \
rm -rf /var/lib/apt/lists/*

echo "Pre-install: Done"
