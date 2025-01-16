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

FROM samyarsadat/service_images:microros-build-action-jazzy

# Copy the entrypoint and other scripts
COPY entrypoint.sh /entrypoint.sh
COPY install_tools.sh /install_tools.sh
COPY rp2040_env_setup.sh /rp2040_env_setup.sh
RUN chmod +x /entrypoint.sh && chmod +x /install_tools.sh && chmod +x /rp2040_env_setup.sh
ENTRYPOINT ["/entrypoint.sh"]