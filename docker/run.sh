#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

DOCKER_NAME=marsians/base
CONTAINER_NAME=marsian_$USER
dockerUserName=$USER

if [ -z "${MARS_PATH}" ]; then
  echo "Aborting ... "
  echo -e "\e[91mPlease set env variable MARS_PATH to absolute path of  your catkin ws \033[0m"

  exit 1
fi

hostPath="${MARS_PATH}"
hostPathParent="$(dirname "$MARS_PATH")"

dockerPath=${hostPath/"$USER"/$dockerUserName}
dockerPathParent=${hostPathParent/"$USER"/$dockerUserName}

XSOCK=/tmp/.X11-unix
XAUTH=/home/$USER/.Xauthority
SHARED_DIR=$dockerPathParent
HOST_DIR=$hostPathParent
command="/bin/bash"

USER_ID=$(id -u)
GRP=$(id -g -n)
GRP_ID=$(id -g)

# Create Shared Folder
#mkdir -p $HOST_DIR
#echo "Shared directory: ${HOST_DIR}"

# Delete the existing container
docker ps -a --format "{{.Names}}" | grep "$CONTAINER_NAME" 1>/dev/null
if [ $? == 0 ]; then
    docker rm -v -f $CONTAINER_NAME 1>/dev/null
fi

# Start the docker container
docker run \
-it -d --rm \
--volume=$XSOCK:$XSOCK:rw \
--volume=$XAUTH:$XAUTH:rw \
--volume=$HOST_DIR:$SHARED_DIR:rw \
--volume=/home/$USER/.vim:/home/$dockerUserName/.vim:ro \
--volume="/etc/timezone:/etc/timezone":ro \
--volume="/etc/localtime:/etc/localtime":ro \
--env="XAUTHORITY=${XAUTH}" \
--env="DISPLAY=${DISPLAY}" \
-e MARS_PATH="${dockerPath}" \
-e USER=$USER \
-e DOCKER_USER=$USER \
-e DOCKER_USER_ID=$USER_ID \
-e DOCKER_GRP="$GRP" \
-e DOCKER_GRP_ID=$GRP_ID \
-e DOCKER_IMG=$DOCKER_NAME \
--hostname marsian_docker \
--net=host \
-w /home/$USER/src2_qual/ \
--privileged \
--gpus all \
--name $CONTAINER_NAME \
$DOCKER_NAME \
$command

if [ $? -ne 0 ];then
    echo "Failed to start marsians container \"${CONTAINER_NAME}\""
    exit 1
fi

if [ "${USER}" != "root" ]; then
    docker exec $CONTAINER_NAME bash -c "/home/$USER/src2_qual/docker/installers/add_user.sh"
fi

echo "Finished setting up docker environment."
