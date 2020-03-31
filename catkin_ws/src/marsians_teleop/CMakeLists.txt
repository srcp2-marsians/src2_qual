cmake_minimum_required(VERSION 2.8.3)
project(marsians_teleop)

find_package(catkin REQUIRED)

catkin_package()

catkin_install_python(PROGRAMS
   marsians_teleop_keyboard.py
   DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)
