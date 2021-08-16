cmake_minimum_required(VERSION 3.0.2)
project(uuv_world_ros_plugins)

if(NOT "${CMAKE_VERSION}" VERSION_LESS "3.16")
    set(CMAKE_CXX_STANDARD 17)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)
else()
    set(LOCAL_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
endif()

find_package(catkin REQUIRED COMPONENTS
  roscpp
  gazebo_msgs
  geometry_msgs
  uuv_world_plugins
  uuv_world_ros_plugins_msgs
  gazebo_dev)

catkin_package(
 INCLUDE_DIRS include
 LIBRARIES
  uuv_underwater_current_ros_plugin
  uuv_sc_ros_interface_plugin
 CATKIN_DEPENDS
   roscpp
   gazebo_msgs
   geometry_msgs
   uuv_world_plugins
   uuv_world_ros_plugins_msgs
   gazebo_dev
)

include_directories(
  ${PROJECT_SOURCE_DIR}/include
  ${catkin_INCLUDE_DIRS}
  ${GAZEBO_INCLUDE_DIRS}
)

add_library(uuv_underwater_current_ros_plugin src/UnderwaterCurrentROSPlugin.cc)
target_link_libraries(uuv_underwater_current_ros_plugin ${catkin_LIBRARIES})
add_dependencies(uuv_underwater_current_ros_plugin ${catkin_EXPORTED_TARGETS})

add_library(uuv_sc_ros_interface_plugin src/SphericalCoordinatesROSInterfacePlugin.cc)
target_link_libraries(uuv_sc_ros_interface_plugin ${catkin_LIBRARIES})
add_dependencies(uuv_sc_ros_interface_plugin ${catkin_EXPORTED_TARGETS})

## Mark executables and/or libraries for installation
install(TARGETS
    uuv_underwater_current_ros_plugin
    uuv_sc_ros_interface_plugin
  ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

## Mark cpp header files for installation
install(DIRECTORY include/${PROJECT_NAME}/
  DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
  FILES_MATCHING PATTERN "*.h"
  PATTERN ".~" EXCLUDE
)
