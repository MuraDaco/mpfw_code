#!/bin/bash

function echo_chk_clrd {
    echo -e "\033[$1;$2m""dbg msg - `basename $0` -> $3""\033[0;0m" > /dev/stderr
}

## cd /Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/main/mpfw_code_main_stm_20230516/wsp/cmake/build_as_lib/stm32f769_disco/rls/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01 && /Users/work/Tools/stm/cube_1_10_1/arm_toolchain/ver_10_3_2021_10/tools/bin/arm-none-eabi-gcc -DFW2_WP_RS_LIB_VERSION=1.1 -DNDEBUG -DSTM32F769xx -DUSE_HAL_DRIVER -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../main/mpfw_code_main_stm_20230516/src/stm32f769_disco/Inc -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Drivers/CMSIS/Device/ST/STM32F7xx/Include -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Drivers/CMSIS/Include -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Drivers/STM32F7xx_HAL_Driver/Inc -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Drivers/BSP/STM32F769I-Discovery -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Drivers/BSP/Components/Common -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Utilities/Log -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Utilities/Fonts -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Utilities/CPU -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Middlewares/Third_Party/FreeRTOS/Source/include -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM7/r0p1 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/cg -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/cs -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/dt/dtDef/v_00 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/kr/krEvent/v_02 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/kr/krInit/v_03 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/kr/krTimer/v_03 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/sv/svSync/v_02 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/sv/svState/v_02 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/sv/svStateMachine/v_03 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/dg/dgInterface/v_01 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/dg/dgFormatDigit/v_01 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_wrapper_resources/stm32f769_disco/src/rs/rsSerial/v_01 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../main/mpfw_code_main_stm_20230516/src/common/cg/libs/fw2_wrapper_core -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_wrapper_core/stm32f769_disco/src/kr/krThread/v_04 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_wrapper_core/stm32f769_disco/src/../../common/src/kr/krThread/v_04 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_wrapper_core/stm32f769_disco/src/sy/syThread/v_01 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_wrapper_core/stm32f769_disco/src/tb/kr/krThread/v_01 -O3 -DNDEBUG -mcpu=cortex-m7 -c -std=gnu11 -Os -ffunction-sections -fdata-sections -Wall -fstack-usage --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -MD -MT libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/CMakeFiles/fw2_wp_rs_lib.dir/__/__/__/__/__/stm32f769_disco/src/rs/rsSerial/v_01/sdk_config/stm_main.c.obj -MF CMakeFiles/fw2_wp_rs_lib.dir/__/__/__/__/__/stm32f769_disco/src/rs/rsSerial/v_01/sdk_config/stm_main.c.obj.d -o CMakeFiles/fw2_wp_rs_lib.dir/__/__/__/__/__/stm32f769_disco/src/rs/rsSerial/v_01/sdk_config/stm_main.c.obj -c /Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/stm32f769_disco/src/rs/rsSerial/v_01/sdk_config/stm_main.c
## exit 0

c_cpp_files_dir="/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/stm32f769_disco/src/rs/rsSerial/v_01"
file_to_compile="$1"
file_to_compile_ext=${file_to_compile#*.}
[ -f "$c_cpp_files_dir/$file_to_compile" ] && {
    echo_chk_clrd 1 32 "Compiling \""$c_cpp_files_dir/$file_to_compile"\" file ..." 
    echo_chk_clrd 1 33 "file_to_compile_ext: $file_to_compile_ext" 

    [ "$file_to_compile_ext" = "cpp" ] && {
        cd /Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/main/mpfw_code_main_stm_20230516/wsp/cmake/build_as_lib/stm32f769_disco/rls/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01 \
        && /Users/work/Tools/stm/cube_1_10_1/arm_toolchain/ver_10_3_2021_10/tools/bin/arm-none-eabi-g++ \
        -DFW2_WP_RS_LIB_VERSION=1.1 -DNDEBUG -DSTM32F769xx -DUSE_HAL_DRIVER \
        -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../main/mpfw_code_main_stm_20230516/src/stm32f769_disco/Inc -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Drivers/CMSIS/Device/ST/STM32F7xx/Include -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Drivers/CMSIS/Include -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Drivers/STM32F7xx_HAL_Driver/Inc -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Drivers/BSP/STM32F769I-Discovery -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Drivers/BSP/Components/Common -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Utilities/Log -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Utilities/Fonts -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Utilities/CPU -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Middlewares/Third_Party/FreeRTOS/Source/include -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM7/r0p1 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/cg -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/cs -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/dt/dtDef/v_00 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/kr/krEvent/v_02 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/kr/krInit/v_03 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/kr/krTimer/v_03 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/sv/svSync/v_02 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/sv/svState/v_02 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/sv/svStateMachine/v_03 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/dg/dgInterface/v_01 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/dg/dgFormatDigit/v_01 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_wrapper_resources/stm32f769_disco/src/rs/rsSerial/v_01 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../main/mpfw_code_main_stm_20230516/src/common/cg/libs/fw2_wrapper_core -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_wrapper_core/stm32f769_disco/src/kr/krThread/v_04 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_wrapper_core/stm32f769_disco/src/../../common/src/kr/krThread/v_04 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_wrapper_core/stm32f769_disco/src/sy/syThread/v_01 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_wrapper_core/stm32f769_disco/src/tb/kr/krThread/v_01 \
        -O3 -DNDEBUG -mcpu=cortex-m7 -c -std=gnu++14 -Os -ffunction-sections -fdata-sections -Wall -fstack-usage -fno-rtti -fno-exceptions -fno-use-cxa-atexit --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -std=gnu++14 \
        -Wfatal-errors \
        -MD -MT libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/CMakeFiles/fw2_wp_rs_lib.dir/__/__/__/__/__/stm32f769_disco/src/rs/rsSerial/v_01/$file_to_compile.obj \
        -MF CMakeFiles/fw2_wp_rs_lib.dir/__/__/__/__/__/stm32f769_disco/src/rs/rsSerial/v_01/$file_to_compile.obj.d \
        -o  CMakeFiles/fw2_wp_rs_lib.dir/__/__/__/__/__/stm32f769_disco/src/rs/rsSerial/v_01/$file_to_compile.obj \
        -c "$c_cpp_files_dir/$file_to_compile" && {
            echo_chk_clrd 1 32 "File \"$file_to_compile\" compiled" 
        } || true
    }

    [ "$file_to_compile_ext" = "c" ] && {
        cd /Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/main/mpfw_code_main_stm_20230516/wsp/cmake/build_as_lib/stm32f769_disco/rls/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01 \
        && /Users/work/Tools/stm/cube_1_10_1/arm_toolchain/ver_10_3_2021_10/tools/bin/arm-none-eabi-gcc \
        -DFW2_WP_RS_LIB_VERSION=1.1 -DNDEBUG -DSTM32F769xx -DUSE_HAL_DRIVER \
        -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../main/mpfw_code_main_stm_20230516/src/stm32f769_disco/Inc -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Drivers/CMSIS/Device/ST/STM32F7xx/Include -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Drivers/CMSIS/Include -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Drivers/STM32F7xx_HAL_Driver/Inc -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Drivers/BSP/STM32F769I-Discovery -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Drivers/BSP/Components/Common -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Utilities/Log -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Utilities/Fonts -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Utilities/CPU -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Middlewares/Third_Party/FreeRTOS/Source/include -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_sdk_stm32f769_disco/src/v_01/Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM7/r0p1 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/cg -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/cs -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/dt/dtDef/v_00 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/kr/krEvent/v_02 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/kr/krInit/v_03 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/kr/krTimer/v_03 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/sv/svSync/v_02 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/sv/svState/v_02 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/sv/svStateMachine/v_03 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/dg/dgInterface/v_01 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_core_core/src/dg/dgFormatDigit/v_01 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_wrapper_resources/stm32f769_disco/src/rs/rsSerial/v_01 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../main/mpfw_code_main_stm_20230516/src/common/cg/libs/fw2_wrapper_core -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_wrapper_core/stm32f769_disco/src/kr/krThread/v_04 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_wrapper_core/stm32f769_disco/src/../../common/src/kr/krThread/v_04 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_wrapper_core/stm32f769_disco/src/sy/syThread/v_01 -I/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/../../../../../../../libs/mpfw_code_libs_fw2_wrapper_core/stm32f769_disco/src/tb/kr/krThread/v_01 \
        -O3 -DNDEBUG -mcpu=cortex-m7 -c -std=gnu11 -Os -ffunction-sections -fdata-sections -Wall -fstack-usage --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb \
        -MD -MT libs/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/v_01/CMakeFiles/fw2_wp_rs_lib.dir/__/__/__/__/__/stm32f769_disco/src/rs/rsSerial/v_01/$file_to_compile.obj \
        -MF CMakeFiles/fw2_wp_rs_lib.dir/__/__/__/__/__/stm32f769_disco/src/rs/rsSerial/v_01/$file_to_compile.obj.d \
        -o  CMakeFiles/fw2_wp_rs_lib.dir/__/__/__/__/__/stm32f769_disco/src/rs/rsSerial/v_01/$file_to_compile.obj \
        -c  "$c_cpp_files_dir/$file_to_compile" && {
            echo_chk_clrd 1 32 "File \"$file_to_compile\" compiled" 
        } || true
    }

    true
} || {
    echo_chk_clrd 1 31 "ERROR - The \""$c_cpp_files_dir/$file_to_compile"\" file does not exist" 
}



