# ROS Template

This repo is a collection of files/scripts to conveniently build and run ROS packages inside a Docker container and enable shared memory transport between ROS 2 nodes run inside the container and on its host.

## Problem

When running ROS 2 nodes inside a container and on its host, we might want to transmit messages between them using efficient shared memory transport. However, this requires a non-trivial configuration and the issue has been described multiple times: 

https://github.com/eProsima/Fast-DDS/issues/2624  
https://github.com/eProsima/Fast-DDS/issues/2956  
https://stackoverflow.com/questions/65900201/troubles-communicating-with-ros2-node-in-docker-container   
https://answers.ros.org/question/387076/ros2-galactic-nodes-cant-communicate-through-docker-container-border/  


## Solution

Transmitting images between Docker container and host using shared memory transport requires 
a) running the container with specific options, --network=host --ipc=host --pid=host, and 
b) running ROS 2 nodes inside the container by a user with the same ID as the user of the host.


## Contribution

This repository is the most convenient setup (that I came up with so far) to build and run ROS packages inside a Docker container and enables shared memory transport between ROS 2 nodes inside the container and on its host. The setup involves: 
- build.sh and run.sh scripts to build/run the container with the correct options
- ros_entrypoint.sh that creates a user inside with matching user/group IDs at startup
- build and run aliases inside the container to build/run colcon workspace as correct user


## Usage

On host:
```
    ./build.sh #Builds and tags Docker image
    ./run.sh   #Runs Docker image with correct options 
```
    
Inside container:
```
build   #Alias to build colcon_ws as root user
run     #Alias to run ROS package as correct user

```
