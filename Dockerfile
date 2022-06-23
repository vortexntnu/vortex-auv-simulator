FROM ros:melodic-ros-base-bionic

RUN adduser --quiet --disabled-password --shell /bin/bash \
    --home /home/vortex --gecos "Vortex user for simulator" vortex
RUN echo "vortex:gladlaks" | chpasswd
RUN usermod -aG sudo vortex

#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 314DF160 
RUN apt-get update
# Accept software from packages.osrfoundation.org.
RUN apt-get install wget
RUN sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
RUN wget https://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -

RUN apt-get update

# Utility
RUN apt-get install -y --allow-unauthenticated \
    openssh-server \
    nano \
    net-tools \
    curl \
    python-catkin-tools \
    python-openpyxl \
    python-dev \
    python-pip

# Required packages
RUN apt-get install -y \
    protobuf-compiler \
    gazebo9 \
    libgazebo9-dev \
    ros-melodic-gazebo-plugins \
    ros-melodic-gazebo-msgs \
    ros-melodic-xacro \
    ros-melodic-tf \
    ros-melodic-robot-state-publisher \
    ros-melodic-message-to-tf \
    ros-melodic-image-view \
    libeigen3-dev 

# Pip packages
RUN pip install pymap3d==1.5.2


# Set up gazebo
RUN echo "export ROS_PACKAGE_PATH=/home/vortex/sim_ws:$ROS_PACKAGE_PATH" >> ~/.bashrc
RUN echo "export GAZEBO_MODEL_PATH=/home/vortex/sim_ws/src/manta_gazebo:$GAZEBO_MODEL_PATH" >> ~/.bashrc 

# Source workspaces
RUN echo 'source /opt/ros/melodic/setup.bash' >> /home/vortex/.bashrc
RUN echo 'source ~/sim_ws/devel/setup.bash' >> /home/vortex/.bashrc

CMD ["/bin/bash"]