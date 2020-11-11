#! /bin/bash

POOL="cybernetics_pool"
# BUILTIN WORLDS:
# cybernetics_pool
# basin_pool
# vortex_pool
# robosub_pool

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

SLEEP_TIME=5

MATCH="[${FSM}-1] process has finished cleanly"

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
    -s|--sleep)
    SLEEP_TIME="$2"
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

echo ""
echo ""
echo "POOL: ${POOL}"
echo "FSM: ${FSM}"
echo ""
echo "GUI: ${GUI}"
echo "CAMERAFRONT: ${CAMERAFRONT}"
echo "CAMERAUNDER: ${CAMERAUNDER}"
echo ""
echo "PAUSED: ${PAUSED}"
echo "SET_TIMEOUT: ${SET_TIMEOUT}"
echo "TIMEOUT: ${TIMEOUT}"
echo ""
echo "SLEEP_TIME: ${SLEEP_TIME}"
echo ""
echo "MATCH: ${MATCH}"
echo ""
echo ""

( roslaunch simulator_launch combined_launch.launch gui:=${GUI} camerafront:=${CAMERAFRONT} cameraunder:=${CAMERAUNDER} paused:=${PAUSED} set_timeout:=${SET_TIMEOUT} timeout:=${TIMEOUT} pool:=${POOL} ) &
SIM_PID=$!
( "$SLEEP_TIME" ; roslaunch finite_state_machine ${FSM}.launch | if tee >( fgrep -q "$MATCH" ) ; then kill "$SIM_PID"; fi) &&
fg
