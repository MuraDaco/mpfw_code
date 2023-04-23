#!/bin/bash

. build_functions.sh

{
    [ -f "$mpfw_code_path/CMakeLists.txt" ] &&
    [ -f "$mpfw_code_path/cmake/arm-none-eabi-gcc.cmake" ]
} && (
    cd $mpfw_code_path
    [ -d "main/mpfw_code_main_$main_name/wsp/cmake/build_as_lib/$platform/$build_type" ] && {
        rm -rf main/mpfw_code_main_$main_name/wsp/cmake/build_as_lib/$platform/$build_type
        echo_chk_clrd 1 32 "\"$mpfw_code_path/main/mpfw_code_main_$main_name/wsp/cmake/build_as_lib/$platform/$build_type\" directory is removed"
    } || {
        echo_chk_clrd 1 33 "\"$mpfw_code_path/main/mpfw_code_main_$main_name/wsp/cmake/build_as_lib/$platform/$build_type\" directory is already removed"
    }
    true
) || {
    echo_chk_clrd 1 31 "ERROR - \"$mpfw_code_path/CMakeLists.txt\" or \"$mpfw_code_path/cmake/arm-none-eabi-gcc.cmake\" files do not exist"
}

param_display
