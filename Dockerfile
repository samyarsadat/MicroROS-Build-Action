#  MicroROS Build Action - Action Dockerfile.
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

FROM ros:humble

# Install git, nano, pip, and curl
RUN apt-get update \
    && apt-get install -y git nano curl python3-pip \
    && apt-get install -y cmake gcc g++ \
    && rm -rf /var/lib/apt/lists/* && apt-get autoremove && apt-get autoclean

# Copy the entrypoint and other scripts
COPY entrypoint.sh /entrypoint.sh
COPY install_tools.sh /install_tools.sh
COPY rp2040_env_setup.sh /rp2040_env_setup.sh
RUN chmod +x /entrypoint.sh && chmod +x /install_tools.sh && chmod +x /rp2040_env_setup.sh
ENTRYPOINT ["/entrypoint.sh"]