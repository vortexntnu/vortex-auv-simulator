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

## Prerequisites ##

Linux distributions Bionic (Ubuntu 18.04) <br />
C++ 11 compiler or newer.

## Note: The simulator depends on ROS Melodic and Vortex-AUV
##### Install these if you do not have it already!

Installation guide for Vortex-AUV and ROS Melodic: https://github.com/vortexntnu/Vortex-AUV

Further documentation for ROS Melodic: http://wiki.ros.org/melodic

## 1. Download and build the customized UUV simulator for Manta AUV ##
###### Requires ROS Melodic and Vortex-AUV
  
-------------------------

![MANTA](docs/manta_underwater_robosub.png)

Figure by: Kristoffer Rakstad Solberg

1. Enter the folder where you want to clone the repostory:
	```bash
	cd vortex_ws/src
	```

2. Clone the repository: 
	```bash
	git clone https://github.com/vortexntnu/vortex-simulator.git
	```

3. Compile the code by running "catkin build" inside the workspace:
	```bash
	cd ~/vortex_ws/
	catkin build
	```
## 2. Run Vortex Simulator ##
-------------------------

### Method 1. Using launch files ### 

1. Open a new terminal and launch a simulation. This will upload Manta (w/ sensor, camera, thrusters etc.), start the simulation world, upload any other object models, and launch robot localization i.e :
	```bash
	roslaunch simulator_launch cybernetics_sim.launch
	```
Builtin simulator worlds:
- basin_sim.launch
- cybernetics_sim.launch
- robosub_sim.launch
- vortex_sim.launch

ROS launch arguments:
| Argument    | Type  | Default | Description                                          |
|-------------|-------|---------|------------------------------------------------------|
| gui         | bool  | true    | Enable/Disable Gazebo GUI                            |
| camerafront | bool  | true    | Enable/Disable Front Camera view                     |
| cameraunder | bool  | false   | Enable/Disable Under AUV Camera view                 |
| paused      | bool  | false   | Enable to start the Simulation Paused                |
| set_timeout | bool  | false   | Enable timeout of Simulation (stop runtime)          |
| timeout     | float | 0.0     | Set the runtime period (only if set_timeout is true) |
	
2. Launch all modules required for operating Manta:
	```bash
	roslaunch auv_setup <drone>.launch type:=simulator
	```
Where \<drone\> is either manta or beluga.  
	
2. Execute your state machine of choice. i.e: 
	```bash
	roslaunch finite_state_machine simtest.launch
	```

Builtin finite state machines:
- simtest.launch
- pooltest.launch
- go_to_and_inspect_point.launch

### Method 2. Using combined Simulator and AUV-modules launch file ###

1. This will upload Manta (w/ sensor, camera, thrusters etc.), start the simulation world, upload any other object models, launch robot localization, start webViz server, AND launch all the modules required for operating Manta. i.e :
	```bash
	roslaunch simulator_launch combined_launch.launch
	```
To choose a different simulator world, use ROS launch argument 'pool'. Builtin pools:
- basin_pool
- cybernetics_pool
- robosub_pool
- vortex_pool
- empty_underwater_world

ROS launch arguments:
| Argument    | Type   | Default          | Description                                          |
|-------------|--------|------------------|------------------------------------------------------|
| pool        | string | cybernetics_pool | Choose the Simulator World                           |
| gui         | bool   | true             | Enable/Disable Gazebo GUI                            |
| camerafront | bool   | true             | Enable/Disable Front Camera view                     |
| cameraunder | bool   | false            | Enable/Disable Under AUV Camera view                 |
| paused      | bool   | false            | Enable to start the Simulation Paused                |
| set_timeout | bool   | false            | Enable timeout of Simulation (stop runtime)          |
| timeout     | float  | 0.0              | Set the runtime period (only if set_timeout is true) |
	
2. Execute your state machine of choice. i.e: 
	```bash
	roslaunch finite_state_machine simtest.launch
	```
Builtin finite state machines:
- simtest.launch
- pooltest.launch
- go_to_and_inspect_point.launch

### Method 3. Using Shell (bash) scripts ###

Shell-launch scripts can be used when the intention is to launch Gazebo Simulator, AUV modules, and a Finite State Machine (FSM) simultaneously. It spares a bit of time in case of repeated launches, and requires only a single terminal to launch everything.

1. Go to the simualator folder and mark the scripts as executables (only needs to be done once):
	```bash
	cd vortex_ws/src/Vortex-Simulator/launch_scripts_bash
	chmod u+r+x sim_launch_basic.sh sim_launch_fsm.sh sim_launch_fsm2.sh comb_launch_fsm.sh comb_launch_fsm2.sh
	```

2. Execute a launch script (must start from the same folder or using a full path). i.e: 
	```bash
	./sim_launch_basic.sh
	```

Available launch scripts and descriptions:
| Launch script       | Description                                                                                                             |
|---------------------|-------------------------------------------------------------------------------------------------------------------------|
| sim_launch_basic.sh | Equals starting the Simulator using method 1                                                                            |
| sim_launch_fsm.sh   | As above, and automatically kills ALL ROS launches and ALL Gazebo runtimes when the FSM terminates                      |
| sim_launch_fsm2.sh  | As above, but only kills launches and runtimes if the FSM terminates cleanly                                            |
| comb_launch_fsm.sh  | Equals starting the Simulator using method 2, automatically kills the Simulator and AUV modules when the FSM terminates |
| comb_launch_fsm2.sh | As above, but only stops the simulator and runtimes if the FSM terminates cleanly                                       |

Script CLI arguments:
| Argument            | Type   | Default                                                   | Description                                            |
|---------------------|--------|-----------------------------------------------------------|--------------------------------------------------------|
| -w or --world       | string | cybernetics_sim                                           | (only sim_launch_... scripts) Choose a simulator world |
| --pool              | string | cybernetics_pool                                          | (only comb_launch_... scripts) Choose a simulator pool |
| --fsm               | string | simtest                                                   | Choose a finite state machine                          |
| -g or --gui         | bool   | true                                                      | Enable/Disable Gazebo client (GUI)                     |
| -f or --camerafront | bool   | true                                                      | Enable/Disable Front Camera view                       |
| -u or --cameraunder | bool   | false                                                     | Enable/Disable Under AUV Camera view                   |
| -p or --paused      | bool   | false                                                     | Enable to start the Simulation Paused                  |
| --set_timeout       | bool   | false                                                     | Enable timeout of Simulation (stop runtime)            |
| -t or --timeout     | float  | 0.0                                                       | Set the runtime period (set_timeout must be true)      |
| -s or --sleep       | int    | 3 (sim_launch_... scripts)<br>5 (comb_launch_... scripts) | Time period between different ROS launches             |

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
