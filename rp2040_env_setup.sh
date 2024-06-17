#!/bin/bash
#  MicroROS Build Action - Default environment setup script.
#  This script installs all necessary dependencies for building micro-ROS for the RP2040.
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

# Install dependencies
apt-get update \
&& apt-get install -y cmake gcc-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib build-essential \
&& apt-get install -y git python3 rsync \
&& rm -rf /var/lib/apt/lists/* && apt-get autoremove && apt-get autoclean

# "Install" the Pico SDK
mkdir /pico && cd /pico \
&& git clone https://github.com/raspberrypi/pico-sdk.git --branch master \
&& cd pico-sdk \
&& git submodule update --init

# Set Pico SDK path
export PICO_SDK_PATH="/pico/pico-sdk"