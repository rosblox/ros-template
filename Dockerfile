FROM ros:humble-ros-core

# Install packages and dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3-colcon-common-extensions \
    && rm -rf /var/lib/apt/lists/*

# Copy entrypoint script (which creates ros user with same uid/gid as host user)
COPY ros_entrypoint.sh /ros_entrypoint.sh

WORKDIR /colcon_ws

# Uncomment to copy and build source_packages in colcon workspace  
# COPY ./source_packages src/source_packages 

RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
    colcon build --symlink-install --event-handlers console_direct+ --cmake-args ' -DCMAKE_BUILD_TYPE=Release'

# Set package's launch command
ENV LAUNCH_COMMAND='ros2 topic pub /talker std_msgs/msg/String "{data: Hello world}"'

# Create build and run aliases
RUN echo 'alias build="colcon build --symlink-install  --event-handlers console_direct+"' >> /etc/bash.bashrc && \
    echo 'alias run="su - ros /run.sh"' >> /etc/bash.bashrc && \
    echo "source /colcon_ws/install/setup.bash; $LAUNCH_COMMAND" >> /run.sh && chmod +x /run.sh 1