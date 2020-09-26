[![GitHub stars](https://img.shields.io/github/stars/vortexntnu/manta-auv-simulator.svg?style=social&label=Star&maxAge=2592000)](https://GitHub.com/vortexntnu/manta-auv-simulator/stargazers/)
[![GitHub watchers](https://img.shields.io/github/watchers/vortexntnu/manta-auv-simulator.svg?style=social&label=Watch&maxAge=2592000)](https://GitHub.com/vortexntnu/manta-auv-simulator/watchers/)
[![GitHub forks](https://img.shields.io/github/forks/vortexntnu/manta-auv-simulator.svg?style=social&label=Fork&maxAge=2592000)](https://GitHub.com/vortexntnu/manta-auv-simulator/network/)

# Manta Autonomous Underwater Vehicle (AUV) simulator: Gazebo UUV simulator rebuilt for Vortex NTNU purposes

[![Website shields.io](https://img.shields.io/website-up-down-green-red/http/shields.io.svg)](http://vortexntnu.no)
[![GitHub contributors](https://img.shields.io/github/contributors/vortexntnu/manta-auv-simulator.svg)](https://GitHub.com/vortexntnu/manta-auv-simulator/graphs/contributors/)
[![Build Status](https://travis-ci.org/uuvsimulator/uuv_simulator.svg?branch=dev%2Ftravis_integration)](https://travis-ci.org/uuvsimulator/uuv_simulator)
[![Read the Docs](https://img.shields.io/readthedocs/pip.svg)](https://uuvsimulator.github.io/)
![ViewCount](https://views.whatilearened.today/views/github/vortexntnu/manta-auv-simulator.svg)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/vortexntnu/manta-auv-simulator/graphs/commit-activity)

![MANTA](docs/manta_underwater_robosub.png)

## Note ##
The README is almost identical to Vortex-AUV's README: https://github.com/vortexntnu/Vortex-AUV

## Prerequisites ##

Linux distributions Bionic (Ubuntu 18.04) <br />
C++ 11 compiler or newer.

## 1. Install ROS melodic for Ubuntu (If you do not have it already) ##

###### This should take no more than 3 minutes. If you have another version of linux but Ubuntu, follow this guide: http://wiki.ros.org/melodic/Installation/Ubuntu. It is very important that you follow the installation guide and instructions on how to run the guide EXACTLY as stated or you will get running errors. Simply copy and paste the commands to your terminal command window ######

Robot operating system (ROS) provides services designed for heterogeneous computer cluster such as hardware abstraction, low-level device control, implementation of commonly used functionality, message-passing between processes, and package management. The main ROS client libraries (C++, Python, and Lisp) are geared toward a Unix-like system, primarily because of their dependence on large collections of open-source software dependencies.


-------------------------

1. Setup your computer to accept software from packages.ros.org:
	```bash
	$ sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
	```

2. Set up your keys:
	```bash
	$ sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
	```

3. Update:
	```bash
	$ sudo apt-get update
  
4. Installation:
	```bash
	$ sudo apt install ros-melodic-desktop-full
	```

5. Before you can use ROS, you will need to initialize rosdep: 
	```bash
	$ sudo rosdep init
	$ rosdep update
  

6. Environment setup:
	```bash
	$ echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
	$ source ~/.bashrc

## 2. Install the necessary dependencies to interface with drivers, Gazebo etc. ##
-------------------------

Quick command for installing all dependencies:  
```
sudo apt install protobuf-compiler ros-melodic-rosbridge-server ros-melodic-message-to-tf ros-melodic-geographic-msgs ros-melodic-move-base ros-melodic-move-base-msgs 
```

Explainations for the dependencies: 

1. Install the protobuf library, which is used as interface to Gazebo.:
	```bash
	$ sudo apt-get install protobuf-compiler

2. Install rosbridge-server to interface with sensor and actuator drivers on the physical Manta.
	```bash
	$ sudo apt-get install ros-melodic-rosbridge-server
  
3. Install tf. tf is a package that lets the user keep track of multiple coordinate frames over time:
	```bash
	$ sudo apt-get install ros-melodic-message-to-tf

4. Install tf. tf is a package that lets the user keep track of multiple coordinate frames over time:
	```bash
	$ sudo apt-get install ros-melodic-geographic-msgs

5. Install move-base-msgs. This is necessary to perform some actions:
	```bash
	$ sudo apt-get install ros-melodic-move-base
	$ sudo apt-get install ros-melodic-move-base-msgs 

## 3. Now that you have ROS Melodic installed. Create ROS workspace ##
###### This is necessary to be able to run the simulation package
-------------------------

1. Creating a catkin workspace:
	```bash
	$ mkdir -p ~/manta_ws/src
	$ cd ~/manta_ws
	$ catkin_init_workspace
	```

2. Building the workspace created:
	```bash
	$ cd ~/manta_ws/
	$ catkin build
	```
Note: if you get the error message "catkin: command not found", run the following command:

	```bash
	$ sudo apt-get install python-catkin-tools
	```


3. Source the current workspace and Gazebo model:
	```bash
	$ echo "source manta_ws/devel/setup.bash" >> ~/.bashrc
	$ echo "export GAZEBO_MODEL_PATH=/home/youruser/manta_ws/src/manta_gazebo:$GAZEBO_MODEL_PATH" >> ~/.bashrc 
	$ echo "export ROS_PACKAGE_PATH=/home/youruser/manta_ws:$ROS_PACKAGE_PATH" >> ~/.bashrc
	```
	
4. Install the protobuf library, which is used as interface to Gazebo:
	```bash
	$ sudo apt-get install protobuf-compiler
	```bash
	
5. Close the current terminal.

6. Open a new terminal window. To make sure the workspace is properly overlayed:
	```bash
	$ echo $ROS_PACKAGE_PATH
	  /home/youruser/manta_ws/src:/opt/ros/melodic/share 
	```

## 4. Download and build Manta V1 ##
-------------------------
1. Enter the folder where you want to clone the repostory:
	```bash
	$ cd manta_ws/src
	```

2. Clone the repositories: 
	```bash
	$  git clone https://github.com/vortexntnu/manta-auv.git
	$  git clone https://github.com/vortexntnu/vortex_msgs.git
	```

Ps. Can also be manually download the zip-folder in the up-right corner and extract the file <br />
inside the src-folder of you workspace

3. Compile the code by running "catkin build" inside the workspace:
	```bash
	$ cd ~/manta_ws/
	$ catkin build vortex_msgs
	$ catkin build
  
## 5. Download and build the customized UUV simulator for Manta AUV ##
-------------------------

![MANTA](docs/manta_underwater_robosub.png)

Figure by: Kristoffer Rakstad Solberg

1. Enter the folder where you want to clone the repostory:
	```bash
	$ cd manta_ws/src
	```

2. Clone the repository: 
	```bash
	$ git clone https://github.com/vortexntnu/manta-auv-simulator.git
	```

3. Compile the code by running "catkin build" inside the workspace:
	```bash
	$ cd ~/manta_ws/
	$ catkin build
	```
## 6. Run Manta V1 in Simulation with Gazebo, Smach viewer, Camera pop-up windows etc ##
-------------------------

1. Open a new terminal and run your simulation world. This will upload Manta (w/ sensor, camera, thrusters etc.) and launch robot localization as well. i.e :
	```bash
	$ roslaunch simulator_launch cybernetics_pool.launch
	```

2. Launch all modules required for operating Manta:
	```bash
	$ roslaunch vortex manta_simulator.launch
	```

2. Execute your state machine of choice. i.e: 
	```bash
	$ roslaunch finite_state_machine simtest.launch
	```


## Credits

This package contains plugins to allow simulating UUVs with Gazebo. For installation and usage instructions, please refer to the [documentation pages](https://uuvsimulator.github.io/).
To send questions, report bugs or suggest improvements, please use the [Issues](https://github.com/uuvsimulator/uuv_simulator/issues) page.

If you are using this simulator for your publication, please cite:

```
@inproceedings{Manhaes_2016,
	doi = {10.1109/oceans.2016.7761080},
	url = {https://doi.org/10.1109%2Foceans.2016.7761080},
	year = 2016,
	month = {sep},
	publisher = {{IEEE}},
	author = {Musa Morena Marcusso Manh{\~{a}}es and Sebastian A. Scherer and Martin Voss and Luiz Ricardo Douat and Thomas Rauschenbach},
	title = {{UUV} Simulator: A Gazebo-based package for underwater intervention and multi-robot simulation},
	booktitle = {{OCEANS} 2016 {MTS}/{IEEE} Monterey}
}
```

In you are willing to contribute to this package, please check the instructions in [CONTRIBUTING](CONTRIBUTING.md)

## Purpose of the project

This software is a research prototype, originally developed for the EU ECSEL
Project 662107 [SWARMs](http://swarms.eu/).

The software is not ready for production use. However, the license conditions of the
applicable Open Source licenses allow you to adapt the software to your needs.
Before using it in a safety relevant setting, make sure that the software
fulfills your requirements and adjust it according to any applicable safety
standards (e.g. ISO 26262).

## License

UUV Simulator is open-sourced under the Apache-2.0 license. See the
[LICENSE](LICENSE) file for details.

For a list of other open source components included in UUV Simulator, see the
file [3rd-party-licenses.txt](3rd-party-licenses.txt).
