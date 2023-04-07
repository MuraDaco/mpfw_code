###############     ###############     ###############     ###############     ###############
# DEBUG BUILD
###############     ###############     ###############     ###############     ###############


####################
# PLATFORM MAC BUILD
####################
# fw2_lib configuration file directory setting
# cmake -S . -B main/mpfw_main_tst_20221229/wsp/cmake/build_as_lib/mac/dbg -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_MAC=ON -DFW2_CMAKE_VERSION=   -DAPP_CMAKE_VERSION=   -DFW2_LIB_CONFIG_DIR=libs/tst_20221206/src -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B main/mpfw_main_tst_20221229/wsp/cmake/build_as_lib/mac/dbg -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_MAC=ON -DFW2_CMAKE_VERSION=   -DAPP_CMAKE_VERSION=   -DFW2_LIB_CONFIG_DIR=                      -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B main/mpfw_main_tst_20221229/wsp/cmake/build_as_lib/mac/dbg -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_MAC=ON -DFW2_CMAKE_VERSION=01 -DAPP_CMAKE_VERSION=   -DFW2_LIB_CONFIG_DIR=                      -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B main/mpfw_main_tst_20221229/wsp/cmake/build_as_lib/mac/dbg -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_MAC=ON -DFW2_CMAKE_VERSION=02 -DAPP_CMAKE_VERSION=01 -DFW2_LIB_CONFIG_DIR=                      -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B main/mpfw_main_tst_20221229/wsp/cmake/build_as_lib/mac/dbg -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_MAC=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake --build main/mpfw_main_tst_20221229/wsp/cmake/build_as_lib/mac/dbg --clean-first -- -j 4
# main/mpfw_main_tst_20221229/wsp/cmake/build_as_lib/mac/rls/mpfw_main_tst_20221229/wsp/cmake/project/subdir/tst_20221229.out
# main/mpfw_main_tst_20221229/wsp/cmake/build_as_lib/mac/rls/mpfw_main_tst_20221229/wsp/cmake/project/subdir/v_${APP_CMAKE_VERSION}/tst_20221229.out

####################
# PLATFORM NXP BUILD
####################
# fw2_lib configuration file directory setting
# cmake -S . -B main/mpfw_main_tst_20221229/wsp/cmake/build_as_lib/nxp/dbg -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_NXP=ON  -DCMAKE_TOOLCHAIN_FILE=./arm-none-eabi-gcc.cmake -DFW2_CMAKE_VERSION=   -DAPP_CMAKE_VERSION=   -DFW2_LIB_CONFIG_DIR=libs/tst_20221206/src -DCMAKE_BUILD_TYPE=Debug -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B main/mpfw_main_tst_20221229/wsp/cmake/build_as_lib/nxp/dbg -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_NXP=ON  -DCMAKE_TOOLCHAIN_FILE=./arm-none-eabi-gcc.cmake -DFW2_CMAKE_VERSION=   -DAPP_CMAKE_VERSION=   -DFW2_LIB_CONFIG_DIR=                      -DCMAKE_BUILD_TYPE=Debug -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B main/mpfw_main_tst_20221229/wsp/cmake/build_as_lib/nxp/dbg -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_NXP=ON  -DCMAKE_TOOLCHAIN_FILE=./arm-none-eabi-gcc.cmake -DFW2_CMAKE_VERSION=01 -DAPP_CMAKE_VERSION=   -DFW2_LIB_CONFIG_DIR=                      -DCMAKE_BUILD_TYPE=Debug -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B main/mpfw_main_tst_20221229/wsp/cmake/build_as_lib/nxp/dbg -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_NXP=ON  -DCMAKE_TOOLCHAIN_FILE=./arm-none-eabi-gcc.cmake -DFW2_CMAKE_VERSION=02 -DAPP_CMAKE_VERSION=01 -DFW2_LIB_CONFIG_DIR=                      -DCMAKE_BUILD_TYPE=Debug -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B main/mpfw_main_tst_20221229/wsp/cmake/build_as_lib/nxp/dbg -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_NXP=ON  -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cp main/mpfw_main_tst_20221229/wsp/cmake/project/link_script/dbg/*.ld apps/tst_20221229/wsp/cmake/build_as_lib/nxp/dbg/main/mpfw_main_tst_20221229/wsp/cmake/project/subdir/v_01
# cmake --build main/mpfw_main_tst_20221229/wsp/cmake/build_as_lib/nxp/dbg --clean-first -- -j 4
# main/mpfw_main_tst_20221229/wsp/cmake/build_as_lib/nxp/dbg/main/mpfw_main_tst_20221229/wsp/cmake/project/subdir/tst_20221229.out
# main/mpfw_main_tst_20221229/wsp/cmake/build_as_lib/nxp/dbg/main/mpfw_main_tst_20221229/wsp/cmake/project/subdir/v_${APP_CMAKE_VERSION}/tst_20221229.out



###############     ###############     ###############     ###############     ###############
# RELEASE BUILD
###############     ###############     ###############     ###############     ###############     


####################
# PLATFORM MAC BUILD
####################
# fw2_lib configuration file directory setting
# cmake -S . -B apps/tst_20221229/wsp/cmake/build_as_lib/mac/rls -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_MAC=ON -DFW2_CMAKE_VERSION=   -DAPP_CMAKE_VERSION=   -DFW2_LIB_CONFIG_DIR=libs/tst_20221206/src -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B apps/tst_20221229/wsp/cmake/build_as_lib/mac/rls -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_MAC=ON -DFW2_CMAKE_VERSION=   -DAPP_CMAKE_VERSION=   -DFW2_LIB_CONFIG_DIR=                      -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B apps/tst_20221229/wsp/cmake/build_as_lib/mac/rls -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_MAC=ON -DFW2_CMAKE_VERSION=01 -DAPP_CMAKE_VERSION=   -DFW2_LIB_CONFIG_DIR=                      -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B apps/tst_20221229/wsp/cmake/build_as_lib/mac/rls -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_MAC=ON -DFW2_CMAKE_VERSION=02 -DAPP_CMAKE_VERSION=01 -DFW2_LIB_CONFIG_DIR=                      -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B apps/tst_20221229/wsp/cmake/build_as_lib/mac/rls -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_MAC=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake --build apps/tst_20221229/wsp/cmake/build_as_lib/mac/rls --clean-first -- -j 4
# apps/tst_20221229/wsp/cmake/build_as_lib/mac/rls/apps/tst_20221229/wsp/cmake/project/subdir/tst_20221229.out
# apps/tst_20221229/wsp/cmake/build_as_lib/mac/rls/apps/tst_20221229/wsp/cmake/project/subdir/v_${APP_CMAKE_VERSION}/tst_20221229.out

####################
# PLATFORM NXP BUILD
####################
# fw2_lib configuration file directory setting
# cmake -S . -B apps/tst_20221229/wsp/cmake/build_as_lib/nxp/rls -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_NXP=ON  -DCMAKE_TOOLCHAIN_FILE=./arm-none-eabi-gcc.cmake -DFW2_CMAKE_VERSION=   -DAPP_CMAKE_VERSION=   -DFW2_LIB_CONFIG_DIR=libs/tst_20221206/src -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B apps/tst_20221229/wsp/cmake/build_as_lib/nxp/rls -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_NXP=ON  -DCMAKE_TOOLCHAIN_FILE=./arm-none-eabi-gcc.cmake -DFW2_CMAKE_VERSION=   -DAPP_CMAKE_VERSION=   -DFW2_LIB_CONFIG_DIR=                      -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B apps/tst_20221229/wsp/cmake/build_as_lib/nxp/rls -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_NXP=ON  -DCMAKE_TOOLCHAIN_FILE=./arm-none-eabi-gcc.cmake -DFW2_CMAKE_VERSION=01 -DAPP_CMAKE_VERSION=   -DFW2_LIB_CONFIG_DIR=                      -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B apps/tst_20221229/wsp/cmake/build_as_lib/nxp/rls -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_NXP=ON  -DCMAKE_TOOLCHAIN_FILE=./arm-none-eabi-gcc.cmake -DFW2_CMAKE_VERSION=02 -DAPP_CMAKE_VERSION=01 -DFW2_LIB_CONFIG_DIR=                      -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B apps/tst_20221229/wsp/cmake/build_as_lib/nxp/rls -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_NXP=ON  -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake --build apps/tst_20221229/wsp/cmake/build_as_lib/nxp/rls --clean-first -- -j 4
# apps/tst_20221229/wsp/cmake/build_as_lib/nxp/rls/apps/tst_20221229/wsp/cmake/project/subdir/tst_20221229.out
# apps/tst_20221229/wsp/cmake/build_as_lib/nxp/rls/apps/tst_20221229/wsp/cmake/project/subdir/v_${APP_CMAKE_VERSION}/tst_20221229.out

cmake_minimum_required(VERSION 3.16)

# set the project name and version
project(${APP_NAME} VERSION 1.0)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED True)


## ******************************************************************
## __________________________________________________________________
## PLATFORM Definitions

if(WP_PLATFORM_LINUX)
    if(DEFINED WP_PLATFORM_STR)
        message(FATAL_ERROR "TOO MANY PLATFORM selected !!!!" )
    else()
        set(WP_PLATFORM_STR     linux   )
    endif()
endif()

if(WP_PLATFORM_MAC)
    if(DEFINED WP_PLATFORM_STR)
        message(FATAL_ERROR "TOO MANY PLATFORM selected !!!!" )
    else()
        set(WP_PLATFORM_STR     mac   )
    endif()
endif()

if(WP_PLATFORM_NXP)
    if(DEFINED WP_PLATFORM_STR)
        message(FATAL_ERROR "TOO MANY PLATFORM selected !!!!" )
    else()
        set(WP_PLATFORM_STR     nxp   )
    endif()
endif()

if(WP_PLATFORM_STM)
    if(DEFINED WP_PLATFORM_STR)
        message(FATAL_ERROR "TOO MANY PLATFORM selected !!!!" )
    else()
        set(WP_PLATFORM_STR     stm   )
    endif()
endif()

if(NOT DEFINED WP_PLATFORM_STR)
    message(FATAL_ERROR "NO PLATFORM selected !!!!" )
endif()

## ******************************************************************
## __________________________________________________________________
## cmake subdirectories versions
include(lib_cmake_prj_version.cmake)

if(FW2_CMAKE_VERSION)
    set(STR_FW2_CMAKE_VERSION v_${FW2_CMAKE_VERSION})
endif()

if(FW2_WP_KR_CMAKE_VERSION)
    set(STR_FW2_WP_KR_CMAKE_VERSION v_${FW2_WP_KR_CMAKE_VERSION})
endif()

if(APP_CMAKE_VERSION)
    set(STR_APP_CMAKE_VERSION v_${APP_CMAKE_VERSION})
endif()

## ******************************************************************
## __________________________________________________________________
## subdirectories Calls

set(RELATIVE_PATH__CODE     .)
set(RELATIVE_PATH__LIBS     libs)
set(RELATIVE_PATH__APPS     apps)

include(path_pub_config.cmake)

if(WP_PLATFORM_NXP)
    add_subdirectory(${RELATIVE_PATH__LIBS_SDK_NXP_PRJ})
endif()
add_subdirectory(${RELATIVE_PATH__LIBS_FW2_CORE_CORE_PRJ})

add_subdirectory(${RELATIVE_PATH__LIBS_FW2_WP_KR_PRJ})

add_subdirectory(${RELATIVE_PATH__LIBS_FW2_WP_RS_PRJ})

add_subdirectory(${RELATIVE_PATH__APPS_XXX_PRJ})

add_subdirectory(main/mpfw_main_${APP_NAME}/wsp/cmake/project/subdir/${STR_APP_CMAKE_VERSION})

