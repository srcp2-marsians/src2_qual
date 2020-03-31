# SRCP2 Qualification - Team Marsians

This repository contains the code developed by team marsians for the NASA Space Robotics Challenge Phase 2. In order to setup the following repository, follow
the below mentioned steps:

* Install the ROS Melodic Desktop version
* Clone the repository using the comand mentioned below. While clone the submodule repo viz srcp2-competitiors, it might ask you the username and password. This will be our marsians username and pasword.
```
git clone --recurse-submodules https://github.com/srcp2-marsians/src2_qual.git
```
* Now, initialize a catkin workspace inside the catkin_ws folder. In addition, set up the MARS_PATH variable.
```
cd src2_qual/catkin_ws/src
catkin_init_workspace
cd ..
echo "export $(pwd)/devel/setup.bash" >> ~/.bashrc
echo "export MARS_PATH=$(pwd)" >> ~/.bashrc
```
* Start the docker using
```
cd ..
./run.sh
```
* You will see that an instance of the marsians docker container has started. Now use the into.sh script to get into the docker.
```
./into.sh
```
