FROM nvidia/cudagl:10.1-devel-ubuntu18.04
MAINTAINER Paritosh Kelkar <paritoshskelkar@gmail.com>

COPY installers/pre_install.sh /tmp/installers/pre_install.sh
RUN bash /tmp/installers/pre_install.sh

COPY installers/install_ros.sh /tmp/installers/install_ros.sh
RUN bash /tmp/installers/install_ros.sh

COPY installers/install_user.sh /tmp/installers/install_user.sh
RUN bash /tmp/installers/install_user.sh

#Entrypoint command
COPY ./entrypoint.sh /home
ENTRYPOINT ["/home/entrypoint.sh"]
CMD ["/bin/bash"]
