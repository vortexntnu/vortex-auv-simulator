#!/usr/bin/env bash

WORLD="cybernetics_sim"
# BUILTIN WORLDS:
# cybernetics_sim
# basin_sim
# vortex_sim
# robosub_sim

FSM="simtest"
# BUILTIN FSMs:
# simtest
# pooltest

GUI=1
# Supported args: 0, 1, false, true

CAMERAFRONT=1
CAMERAUNDER=0

PAUSED=0
SET_TIMEOUT=0
TIMEOUT=0.0

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    -w|--world)
    WORLD="$2"
    shift
    shift
    ;;
    -g|--gui)
    GUI="$2"
    shift
    shift
    ;;
    -f|--camerafront)
    CAMERAFRONT="$2"
    shift
    shift
    ;;
    -u|--cameraunder)
    CAMERAUNDER="$2"
    shift
    shift
    ;;
    -p|--paused)
    PAUSED="$2"
    shift
    shift
    ;;
    --set_timeout)
    SET_TIMEOUT="$2"
    shift
    shift
    ;;
    -t|--timeout)
    TIMEOUT="$2"
    shift
    shift
    ;;
    --fsm)
    FSM="$2"
    shift
    ;;
    *)
    POSITIONAL+=("$1")
    shift
    ;;
esac
done

set -- "${POSITIONAL[@]}"

( roslaunch simulator_launch ${WORLD}.launch gui:=${GUI} camerafront:=${CAMERAFRONT} cameraunder:=${CAMERAUNDER} paused:=${PAUSED} set_timeout:=${SET_TIMEOUT} timeout:=${TIMEOUT} ) &
( sleep 3 ; roslaunch auv_setup manta_simulator.launch ) &
( sleep 5 ; roslaunch finite_state_machine ${FSM}.launch) &

sleep 6
while sleep 7
do
    if ! ( rosnode list | fgrep --quiet "$FSM" )
    then
        echo "Finite State Machine terminated. Killing ROS nodes."
        killall -w roslaunch
        break
    fi
done