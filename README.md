# uuv_simulator: Unmanned Underwater Vehicle (UUV) simulation with Gazebo rebuilt for Vortex NTNU purposes

[![Build Status](https://travis-ci.org/uuvsimulator/uuv_simulator.svg?branch=dev%2Ftravis_integration)](https://travis-ci.org/uuvsimulator/uuv_simulator)
[![Read the Docs](https://img.shields.io/readthedocs/pip.svg)](https://uuvsimulator.github.io/)
[![Gitter](https://img.shields.io/gitter/room/nwjs/nw.js.svg)](https://gitter.im/uuvsimulator)

## 1. If you have ROS Kinetic installed. Create ROS workspace ##
###### This is necessary to be able to run the simulation package that I have created
-------------------------

1. creating a catkin workspace:
	```bash
	$ mkdir -p ~/manta_ws/src
	$ cd ~/manta_ws/src
	$ catkin_init_workspace
  
2. building the workspace created:
	```bash
	$ cd ~/manta_ws/
	$ catkin build
  
3. source the current workspace and Gazebo model:
	```bash
	$ echo "source manta_ws/devel/setup.bash" >> ~/.bashrc
	$ echo "export GAZEBO_MODEL_PATH=/home/youruser/manta_ws/src/manta_gazebo:$GAZEBO_MODEL_PATH" >> ~/.bashrc 
	$ echo "export ROS_PACKAGE_PATH=/home/youruser/manta_ws:$ROS_PACKAGE_PATH" >> ~/.bashrc

	
3. close the current window.

4. Open a new window. To make sure the workspace is properly overlayed:
	```bash
	$ echo $ROS_PACKAGE_PATH
	  /home/youruser/manta_ws/src:/opt/ros/kinetic/share 


## 2. How to run the simulation ##
-------------------------
1. Enter the folder where you want to clone the repostory:
	```bash
	$ cd manta_ws/src
	```

2. Clone the repository: 
	```bash
	$  git clone https://github.com/vortexntnu/uuv-simulator.git
	```
Ps. You can also manually download the zip-folder in the up-right corner and extract the file <br />
inside the src-folder of you workspace

3. Compile the code by running "catkin build" inside the workspace:
	```bash
	$ cd ~/manta_ws/
	$ catkin build
  
4. Open a window and run Gazebo world, spawn Manta, thruster manager and navigation by executing: 
	```bash
	$ roslaunch roslaunch simulator_launch cybernetics_pool.launch
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
