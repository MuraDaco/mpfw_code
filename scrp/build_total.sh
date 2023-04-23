#!/bin/bash

source build_functions.sh

param_display

{
    [ -f "$mpfw_code_path/CMakeLists.txt" ] &&
    [ -f "$mpfw_code_path/cmake/arm-none-eabi-gcc.cmake" ]
} && (
    pwd_backup="$PWD"
    cd $mpfw_code_path

    cmake -S . -B main/mpfw_code_main_$main_name/wsp/cmake/build_as_lib/$platform/$build_type -G "Unix Makefiles" $toolchain_cmake $platform_cmake -DMAIN_NAME=$main_name -DAPP_NAME=tst_20221206 $build_type_cmake $verbose_cmake && {
        cp main/mpfw_code_main_$main_name/wsp/cmake/project/link_script/$build_type/*.ld main/mpfw_code_main_$main_name/wsp/cmake/build_as_lib/$platform/$build_type/main/mpfw_code_main_$main_name/wsp/cmake/project/subdir/v_01 && {
            cmake --build main/mpfw_code_main_$main_name/wsp/cmake/build_as_lib/$platform/$build_type $clean_cmake -- -j 1
        }
    }

    echo
    echo_chk_clrd 1 33 "current directory (where current script is performed) is $pwd_backup"
    echo
    echo
    echo_chk_clrd 1 33 "the following commands have been executed under \"$PWD\" directory"
    echo_chk_clrd 1 33 "cmake -S . -B main/mpfw_code_main_$main_name/wsp/cmake/build_as_lib/$platform/$build_type -G \"Unix Makefiles\" $toolchain_cmake $platform_cmake -DMAIN_NAME=$main_name -DAPP_NAME=tst_20221206 $build_type_cmake $verbose_cmake"
    echo_chk_clrd 1 33 "cmake --build main/mpfw_code_main_$main_name/wsp/cmake/build_as_lib/$platform/$build_type $clean_cmake -- -j 1"
    echo        

) || {
    echo "ERROR - neither \"CMakeLists.txt\" nor \"./cmake/arm-none-eabi-gcc.cmake\" files exist"
}

param_display


