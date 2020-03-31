xhost +local:root 1>/dev/null 2>&1
docker exec \
    -u $USER \
    -it marsian_$USER \
    /bin/bash
xhost -local:root 1>/dev/null 2>&1
