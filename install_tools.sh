#!/bin/bash
#  MicroROS Build Action - Install tools script, this installs the MicroROS tools.
#  Copyright 2024 Samyar Sadat Akhavi
#  Written by Samyar Sadat Akhavi, 2024.
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <https: www.gnu.org/licenses/>.

set -e

# Install MicroROS tools
echo "Installing MicroROS tools..."
sudo apt-get update
rosdep update
cd $MICROROS_DIR_PATH \
&& sudo rosdep install --rosdistro $ROS_DISTRO --from-paths $MICROROS_SRC_PATH --ignore-src -y
sudo apt-get autoremove && sudo apt-get autoclean
echo "Tools installed!"

# Clone MicroROS setup if the user has not provided a setup repository
if [ "$MICROROS_DO_CLONE" = "true" ]; then
    echo "MicroROS setup not provided, cloning MicroROS setup..."
    rm -rf $MICROROS_SETUP_PATH
    git clone --recurse-submodules --branch $ROS_DISTRO https://github.com/micro-ROS/micro_ros_setup.git $MICROROS_SETUP_PATH
fi

# Build MicroROS setup
echo "Building MicroROS setup..."
source /opt/ros/$ROS_DISTRO/setup.bash \
&& cd $MICROROS_SETUP_PATH && colcon build