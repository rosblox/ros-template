#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

export HOST_UID=$(id -u)

docker compose -f $SCRIPT_DIR/docker-compose.yml run \
--volume $(pwd)/livox_ros_driver2:/colcon_ws/src/livox_ros_driver2 \
--volume $(pwd)/Livox-SDK2:/Livox-SDK2 \
ros-livox-ros-driver2 bash
