addgroup --gid "$DOCKER_GRP_ID" "$DOCKER_GRP"
adduser --disabled-password --force-badname --gecos '' "$DOCKER_USER" \
    --uid "$DOCKER_USER_ID" --gid "$DOCKER_GRP_ID" 2>/dev/null
usermod -aG sudo "$DOCKER_USER"
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
cp -r /etc/skel/. /home/${DOCKER_USER}
echo '
export PATH=${PATH}:/apollo/scripts:/usr/local/miniconda/bin
ulimit -c unlimited
' >> "/home/${DOCKER_USER}/.bashrc"

echo '
source /opt/ros/melodic/setup.bash
' >> "/home/${DOCKER_USER}/.bashrc"

echo "
source /home/${DOCKER_USER}/src2_qual/catkin_ws/devel/setup.bash
" >> "/home/${DOCKER_USER}/.bashrc"

echo '
genhtml_branch_coverage = 1
lcov_branch_coverage = 1
' > "/home/${DOCKER_USER}/.lcovrc"

# Set user files ownership to current user, such as .bashrc, .profile, etc.
chown ${DOCKER_USER}:${DOCKER_GRP} /home/${DOCKER_USER}
ls -ad /home/${DOCKER_USER}/.??* | xargs chown -R ${DOCKER_USER}:${DOCKER_GRP}
