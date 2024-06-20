<h1 align="center">MicroROS Build Action</h1>

<!-- ![banner](.github/images/logo_dark.png#gh-dark-mode-only)
![banner](.github/images/logo_light.png#gh-light-mode-only) -->

<p align="center">
    <a href="LICENSE"><img src="https://img.shields.io/github/license/samyarsadat/MicroROS-Build-Action"></a>
    |
    <a href="../../issues"><img src="https://img.shields.io/github/issues/samyarsadat/MicroROS-Build-Action"></a>
    |
    <a href="actions/workflows/test-action.yml"><img src="../../actions/workflows/test-action.yml/badge.svg"></a>
</p>

<br><br>

----
This is a GitHub Action for building micro-ROS as a static C library.<br>
This is a Docker container action.
<br><br>


## Inputs
| Name                       | Description                                                                                                                                                                                                      | Required | Default                |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- | ---------------------- |
| `microros_dir`             | _Micro-ROS directory. This directory should contain the source directory, the `my_colcon.meta`, and `my_toolchain.cmake` files._                                                                                 | Yes      | N/A                    |
| `microros_source_dir`      | _Micro-ROS source directory. The path should be relative to the micro-ROS directory. This directory should contain the micro-ROS setup repository and any extra packages that micro-ROS should be built with._   | No       | `"src"`                |
| `microros_setup_path`      | _Path to the micro-ROS setup repository. The path should be relative to the micro-ROS source directory._                                                                                                         | No       | `"micro_ros_setup"`    |
| `environment_setup_script` | _Path to environment setup script. This script should perform any steps required to set up the environment for building micro-ROS for your specific platform._                                                   | No       | RP2040 setup script.   |
| `clone_microros_setup`     | _Whether to clone the micro-ROS setup repository. Set to `"false"` if the repository is added as a submodule or otherwise exists at the provided path._                                                          | Yes      | `"true"`               |
| `colcon_meta_file`         | _Name of the `colcon.meta` file. This file should be in the micro-ROS directory._                                                                                                                                | No       | `"my_colcon.meta"`     |
| `toolchain_cmake_file`     | _Name of the `toolchain` file. This file should be in the micro-ROS directory._                                                                                                                                  | No       | `"my_toolchain.cmake"` |
| `extra_build_packages`     | _A space-separated list of packages that are to be built with the library. These packages should be in the micro-ROS source directory. The packages should be in a directory with the same name as the package._ | No       | `""`                   |
<br>

## Outputs
| Name                | Description                                                                                                             |
| ------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| `library_build_dir` | _Relative path to the build directory. The `libmicroros.a` file and the `include` directory will be in this directory._ |
<br>


## Notes
Some extra notes on configuration and usage.

### The Environment Setup Script
The environment setup script, as described above, should setup the environment for building micro-ROS for the specific that you're building micro-ROS for.<br>
This may include installing compilers, SDKs, toolchains, setting environment variables, etc. An example of such a file can be found in the form of the default
setup script for the RP2040 _(see [rp2040_env_setup.sh](rp2040_env_setup.sh))_. This script installs the Pico SDK, along with all other required dependencies.<br>
<br>

### Full Raspberry Pi Pico Usage Example
To see this action in action _(no pun intended)_ along with the [Pico Build Action](https://github.com/samyarsadat/Pico-Build-Action), take a look at my
[ROS Robot Project](https://github.com/samyarsadat/ROS-Robot)! There you will find this action being used to build micro-ROS for the Raspberry Pi Pico along
with the aforementioned Pico Build Action for building the final binaries that can be used on the Pico.<br>
<br>
In my ROS Robot Project, I'm using the FreeRTOS kernel to enable multithreading for micro-ROS. Unfortunately, some platform-specific FreeRTOS header files import
an autogenerated header from the Pico SDK (`version.h`). This header is created by the SDK when generating build files. This means that, unless we want 
to manually copy it in, we have to run the Pico Build Action once before building micro-ROS. We can run Pico Build with the `cmake_config_only` option set to 
`"true"`, as we only need the build files to be generated. We will, of course, have to run Pico Build again after building micro-ROS.<br>
<br>
This is an incredibly janky solution, but it is the easiest way of doing, unless you want to manually copy the headers in, which is usually not recommended;
besides, who wants to do things manually when there's a way to automate it?<br>
<br>

### No Spaces In Paths
Due to a bug, or rather an oversight, in `micro_ros_setup`'s `create_firmware_ws.sh` script, you must make sure that there are no spaces in the path to
`microros_dir`. Escaping spaces in the path when passing it to the action does not work as the script uses its present working directory 
instead of taking the path as an input. I have not tested whether spaces in `microros_source_dir` or `microros_source_dir` cause issues, but 
it's a good idea to avoid spaces in paths altogether.<br>
<br>

### The Firmware Workspace Creation Script
If you have any extra packages that get built alongside micro-ROS, those packages need to have a firmware workspace creation script located at 
`[PACKAGE DIR]/scripts/create_firmware_ws.sh`. This script is executed before building micro-ROS. The build will fail if this script is not found.
You can see a generic example of such a script
[here](https://github.com/samyarsadat/ROS-Robot/blob/stage-1-pico-rtos/Source%20Code/pico_ws/libmicroros/src/rrp_pico_coms/scripts/create_firmware_ws.sh).
This script should be fine for most packages.<br>
<br><br>


## Example usage
```YAML
jobs:
    test_build:
        name: Build example micro-ROS library
        runs-on: ubuntu-latest
        permissions:
            contents: read

        steps:
            - name: Checkout
              uses: actions/checkout@v4
              with:
                  submodules: recursive

            - name: Build MicroROS Library
              id: build
              uses: ./
              with:
                  microros_dir: test_library/libmicroros
                  clone_microros_setup: "true"
```
<br><br>


## Contact
You can contact me via e-mail.<br>
E-mail: samyarsadat@gigawhat.net
<br><br>
If you think that you have found a bug or issue please report it <a href="../../issues">here</a>.
<br><br>


## Contributing
Please take a look at <a href="CONTRIBUTING.md">CONTRIBUTING.md</a> for contributing.
<br><br>


## Credits
|      Role      |                               Name                               |
|----------------|------------------------------------------------------------------|
| Lead Developer | <a href="https://github.com/samyarsadat">Samyar Sadat Akhavi</a> |

<br><br>


Copyright © 2024 Samyar Sadat Akhavi.
