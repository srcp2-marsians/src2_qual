#!/usr/bin/env bash

# Fail on first error.
set -e
RED='\033[0;31m'

if [[ `lsb_release -rs` == "18.04" ]] # 
then
 ROS_DIST=melodic
else
 echo -e "${RED} Invalid base Ubuntu ..."
fi

echo "Installing ROS ${ROS_DIST}..."
sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

apt-get update -y && \
  apt-get install -y \
  ros-${ROS_DIST}-desktop

pip install -U rosdep

rosdep init
rosdep update

echo "Done Installing ROS ${ROS_DIST} ... "

