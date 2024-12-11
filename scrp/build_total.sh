#!/bin/bash

source build_functions.sh

set_array_param=()
while (( $# ))
do
    set_array_param+=("$1")
    shift
done

param_parsing "${set_array_param[@]}"

export EXIT_CODE=0

param_display


{
    [ "$option_r" = "remove" ]      ||
    [ "$option_r" = "remove_exit" ]
} && {

    {
        [ -f "$mpfw_code_path/CMakeLists.txt" ] &&
        [ -f "$mpfw_code_path/cmake/arm-none-eabi-gcc.cmake" ]
    } && (
        cd $mpfw_code_path
        [ -d "main/mpfw_code_main_$main_name/wsp/cmake/build_as_lib/$platform/$build_type" ] && {
            [ "$option_test" = "test_on" ] && {
                echo_chk_clrd 1 33 "Nothing has be done - Test is on"
            } || {
                rm -rf main/mpfw_code_main_$main_name/wsp/cmake/build_as_lib/$platform/$build_type
            }
            echo_chk_clrd 1 32 "\"$mpfw_code_path/main/mpfw_code_main_$main_name/wsp/cmake/build_as_lib/$platform/$build_type\" directory is removed"
        } || {
            echo_chk_clrd 1 33 "\"$mpfw_code_path/main/mpfw_code_main_$main_name/wsp/cmake/build_as_lib/$platform/$build_type\" directory is already removed"
        }
    ) || {
        echo_chk_clrd 1 31 "ERROR - \"$mpfw_code_path/CMakeLists.txt\" or \"$mpfw_code_path/cmake/arm-none-eabi-gcc.cmake\" files do not exist"
    }

}

[ "$option_r" = "remove_exit" ] && exit 0

{
    [ -f "$mpfw_code_path/CMakeLists.txt" ] &&
    [ -f "$mpfw_code_path/cmake/arm-none-eabi-gcc.cmake" ]
} && (
    pwd_backup="$PWD"
    cd $mpfw_code_path

    [ "$option_test" = "test_on" ] && {
        echo_chk_clrd 1 35 "Nothing has be done - Test is on"
    } || {
        cmake -S . -B main/mpfw_code_main_$main_name/wsp/cmake/build_as_lib/$platform/$build_type -G "Unix Makefiles" $toolchain_cmake $platform_cmake -DWP_PLATFORM_STR=$platform -DMAIN_NAME=$main_name -DAPP_NAME=$apps_name $build_type_cmake $verbose_cmake $cmake_trace_files && {
            [ "$option_skip" = "skip_build" ] && {
                echo_chk_clrd 1 35 "No build performed - option \"skip\" is active"
            } || {
                [ "$scriptlink" = "yes" ] && {
                    cmake --build main/mpfw_code_main_$main_name/wsp/cmake/build_as_lib/$platform/$build_type $clean_cmake -- -j 1 || {
                        echo_chk_clrd 1 31 "ERROR - cmake build command fail"
                        EXIT_CODE=1
                    }
                } || {
                    cp main/mpfw_code_main_$main_name/wsp/cmake/project/$platform/link_script/$build_type/*.ld main/mpfw_code_main_$main_name/wsp/cmake/build_as_lib/$platform/$build_type/main/mpfw_code_main_$main_name/wsp/cmake/project/subdir/v_01 && {
                        cmake --build main/mpfw_code_main_$main_name/wsp/cmake/build_as_lib/$platform/$build_type $clean_cmake -- -j 1 || {
                            echo_chk_clrd 1 31 "ERROR - cmake build command fail"
                            EXIT_CODE=1
                        }
                    }
                }
            }
        } || {
            echo_chk_clrd 1 31 "ERROR - cmake workspace command fail"
            EXIT_CODE=1
        }
    }

    echo
    echo_chk_clrd 1 33 "current directory (where current script is performed) is $pwd_backup"
    echo
    echo
    echo_chk_clrd 1 33 "the following commands have been executed under \"$PWD\" directory"
    echo_chk_clrd 1 33 "cmake -S . -B main/mpfw_code_main_$main_name/wsp/cmake/build_as_lib/$platform/$build_type -G \"Unix Makefiles\" $toolchain_cmake $platform_cmake -DWP_PLATFORM_STR=$platform -DMAIN_NAME=$main_name -DAPP_NAME=$apps_name $build_type_cmake $verbose_cmake"
    echo_chk_clrd 1 33 "cmake --build main/mpfw_code_main_$main_name/wsp/cmake/build_as_lib/$platform/$build_type $clean_cmake -- -j 1"
    echo        

    exit ${EXIT_CODE}

) || {
    ## echo_chk_clrd 1 31 "ERROR - neither \"CMakeLists.txt\" nor \"./cmake/arm-none-eabi-gcc.cmake\" files exist"
    echo_chk_clrd 1 31 "ERROR - Test"
    EXIT_CODE=1
}

param_display

exit ${EXIT_CODE}
