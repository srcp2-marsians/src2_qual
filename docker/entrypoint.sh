#!/bin/bash 

# fail on first error
set -e 

echo "alias mars_src='cd "$MARS_PATH"'" >> ~/.bashrc
echo 'export LC_ALL='C'' >> ~/.bashrc

if [[ `lsb_release -rs` == "18.04" ]] # 
then
 ROS_DIST=melodic
else
  exit 1
fi




echo "source /opt/ros/${ROS_DIST}/setup.bash" >> ~/.bashrc
echo "source ${MARS_PATH%/}/devel/setup.bash" >> ~/.bashrc
echo "PROMPT_DIRTRIM=1" >> ~/.bashrc

source ~/.bashrc
cd ~
exec "$@"

