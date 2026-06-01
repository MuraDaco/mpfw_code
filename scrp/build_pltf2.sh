#!/bin/bash

current_script_dir=$(dirname "${BASH_SOURCE[0]}")
source $current_script_dir/func_echo.sh

PATH_BKP=${PATH}
PLATFORM_NAME=$1

if ! [ -f $PWD/set_build_params.sh ]; then
  echo_clrd 1 31 "ERROR - To perform this script the current folder must have the \"set_build_params.sh\" file properly configured."
  exit 1
fi

WSP_VER_DIR=${PWD%/cmake}
WSP_VER_DIR=${WSP_VER_DIR##*/}
source $PWD/set_build_params.sh
echo "WSP_VER_DIR: $WSP_VER_DIR"
echo "BUILD_DIR: $BUILD_DIR"

source $PWD/set_build_params.sh

## PLATFORM_NAME=$1
## MPFW_CODE_CMAKE_DIR=../../../../../../cmake
## BUILD_DIR=../../../build/${PLATFORM_NAME}

## NXP - PATH_TOOLCHAIN
    ## IDE 11.5.1
        ## PATH_TOOLCHAIN="/Applications/MCUXpressoIDE_11.5.1_7266/ide/tools/bin"
        ## PATH_TOOLCHAIN="/Users/work/Tools/nxp/mcux_11_5_1/arm_toolchain/ver_10_3_2021_07/tools/bin"
    ## IDE 11.9.1
        ## PATH_TOOLCHAIN="/Applications/MCUXpressoIDE_11.9.1_2170/ide/plugins/com.nxp.mcuxpresso.tools.macosx_11.9.1.202402080819/tools/bin"
        ## PATH_TOOLCHAIN="/Applications/MCUXpressoIDE_11.9.1_2170/ide/tools/bin"
        ## PATH_TOOLCHAIN="/Users/work/Tools/nxp/mcux_11_9_1/arm_toolchain/ver_12_3_1_20230626/tools/bin"
## STM32F769_DISCO - PATH_TOOLCHAIN
    ## IDE 1_10_1
        ## PATH_TOOLCHAIN="/Users/work/Applications/STM32_1_10_1/STM32CubeIDE.app/Contents/Eclipse/plugins/com.st.stm32cube.ide.mcu.externaltools.gnu-tools-for-stm32.10.3-2021.10.macos64_1.0.0.202111181127/tools/bin"
        ## PATH_TOOLCHAIN="/Users/work/Tools/stm/cube_1_10_1/arm_toolchain/ver_10_3_2021_10/tools/bin"
    ## IDE 1_15_1
        ## PATH_TOOLCHAIN="/Users/work/Applications/STM32_1_15_1/STM32CubeIDE.app/Contents/Eclipse/plugins/com.st.stm32cube.ide.mcu.externaltools.gnu-tools-for-stm32.12.3.rel1.macos64_1.0.100.202403111906/tools/bin"
        ## PATH_TOOLCHAIN="/Users/work/Tools/stm/cube_1_15_1/arm_toolchain/ver_12_3_rel_1/tools/bin"

[ -n "$PLATFORM_NAME" ] && {

    if [ $PLATFORM_NAME = "nxp" ];
    then
        PATH_TOOLCHAIN="/Applications/MCUXpressoIDE_11.5.1_7266/ide/tools/bin"
        export PATH=$PATH_TOOLCHAIN:$PATH_BKP
    fi
    
    if [ $PLATFORM_NAME = "stm32f769_disco" ];
    then
        PATH_TOOLCHAIN="/Users/work/Tools/stm/cube_1_10_1/arm_toolchain/ver_10_3_2021_10/tools/bin"
        export PATH=$PATH_TOOLCHAIN:$PATH_BKP
    fi

    cmake --build ${BUILD_DIR} -j 1 && exit 0 || exit 1

} || {

    script_name=$(basename "$0")
    echo_clrd 1 33 "WARNING - you must set <platform name>"
    echo_clrd 1 33 "WARNING - usage: '$ $script_name <platform name>' "

    echo_clrd 1 34 "INFO - the available <platform name> are:"
    echo_clrd 1 34 "INFO -     . mac"
    echo_clrd 1 34 "INFO -     . nxp"
    echo_clrd 1 34 "INFO -     . stm32f769_disco"

}
