###############     ###############     ###############     ###############     ###############
# DEBUG BUILD
###############     ###############     ###############     ###############     ###############

### WARNING - l'opzione "-DFW2_LIB_CONFIG_DIR=libs/tst_20221206/src" non funziona dato che non esiste la directory "libs/tst_20221206/src"

####################
# PLATFORM MAC BUILD
####################
# fw2_lib configuration file directory setting
# cmake -S . -B main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/mac/dbg -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_MAC=ON -DFW2_CMAKE_VERSION=   -DAPP_CMAKE_VERSION=   -DFW2_LIB_CONFIG_DIR=libs/tst_20221206/src -DCMAKE_BUILD_TYPE=Debug -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/mac/dbg -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_MAC=ON -DFW2_CMAKE_VERSION=   -DAPP_CMAKE_VERSION=   -DFW2_LIB_CONFIG_DIR=                      -DCMAKE_BUILD_TYPE=Debug -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/mac/dbg -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_MAC=ON -DFW2_CMAKE_VERSION=01 -DAPP_CMAKE_VERSION=   -DFW2_LIB_CONFIG_DIR=                      -DCMAKE_BUILD_TYPE=Debug -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/mac/dbg -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_MAC=ON -DFW2_CMAKE_VERSION=02 -DAPP_CMAKE_VERSION=01 -DFW2_LIB_CONFIG_DIR=                      -DCMAKE_BUILD_TYPE=Debug -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/mac/dbg -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_MAC=ON                                                                                          -DCMAKE_BUILD_TYPE=Debug -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON

# cmake -S . -B main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/mac/dbg -G "Unix Makefiles" -DWP_PLATFORM_MAC=ON -DMAIN_NAME=tst_20221229 -DAPP_NAME=tst_20221206 -DCMAKE_BUILD_TYPE=Debug -DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF
# cmake --build main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/mac/dbg --clean-first -- -j 4
# main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/mac/dbg/mpfw_code_main_tst_20221229/wsp/cmake/project/subdir/tst_20221229.out
# main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/mac/dbg/mpfw_code_main_tst_20221229/wsp/cmake/project/subdir/v_${APP_CMAKE_VERSION}/tst_20221229.out

####################
# PLATFORM NXP BUILD
####################
# fw2_lib configuration file directory setting
# cmake -S . -B main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/nxp/dbg -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_NXP=ON  -DCMAKE_TOOLCHAIN_FILE=./arm-none-eabi-gcc.cmake -DFW2_CMAKE_VERSION=   -DAPP_CMAKE_VERSION=   -DFW2_LIB_CONFIG_DIR=libs/tst_20221206/src -DCMAKE_BUILD_TYPE=Debug -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/nxp/dbg -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_NXP=ON  -DCMAKE_TOOLCHAIN_FILE=./arm-none-eabi-gcc.cmake -DFW2_CMAKE_VERSION=   -DAPP_CMAKE_VERSION=   -DFW2_LIB_CONFIG_DIR=                      -DCMAKE_BUILD_TYPE=Debug -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/nxp/dbg -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_NXP=ON  -DCMAKE_TOOLCHAIN_FILE=./arm-none-eabi-gcc.cmake -DFW2_CMAKE_VERSION=01 -DAPP_CMAKE_VERSION=   -DFW2_LIB_CONFIG_DIR=                      -DCMAKE_BUILD_TYPE=Debug -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/nxp/dbg -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_NXP=ON  -DCMAKE_TOOLCHAIN_FILE=./arm-none-eabi-gcc.cmake -DFW2_CMAKE_VERSION=02 -DAPP_CMAKE_VERSION=01 -DFW2_LIB_CONFIG_DIR=                      -DCMAKE_BUILD_TYPE=Debug -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/nxp/dbg -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_NXP=ON                                                                                                                                            -DCMAKE_BUILD_TYPE=Debug -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON


# cmake -S . -B main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/nxp/dbg -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE=./cmake/arm-none-eabi-gcc.cmake -DWP_PLATFORM_NXP=ON -DMAIN_NAME=tst_20221229 -DAPP_NAME=tst_20221206 -DCMAKE_BUILD_TYPE=Debug -DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF
# cp main/mpfw_code_main_tst_20221229/wsp/cmake/project/link_script/dbg/*.ld main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/nxp/dbg/main/mpfw_code_main_tst_20221229/wsp/cmake/project/subdir/v_01
# cmake --build main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/nxp/dbg --clean-first -- -j 4
# main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/nxp/dbg/main/mpfw_code_main_tst_20221229/wsp/cmake/project/subdir/tst_20221229.out
# main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/nxp/dbg/main/mpfw_code_main_tst_20221229/wsp/cmake/project/subdir/v_${APP_CMAKE_VERSION}/tst_20221229.out



###############     ###############     ###############     ###############     ###############
# RELEASE BUILD
###############     ###############     ###############     ###############     ###############     


####################
# PLATFORM MAC BUILD
####################
# fw2_lib configuration file directory setting
# cmake -S . -B main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/mac/rls -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_MAC=ON -DFW2_CMAKE_VERSION=   -DAPP_CMAKE_VERSION=   -DFW2_LIB_CONFIG_DIR=libs/tst_20221206/src -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/mac/rls -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_MAC=ON -DFW2_CMAKE_VERSION=   -DAPP_CMAKE_VERSION=   -DFW2_LIB_CONFIG_DIR=                      -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/mac/rls -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_MAC=ON -DFW2_CMAKE_VERSION=01 -DAPP_CMAKE_VERSION=   -DFW2_LIB_CONFIG_DIR=                      -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/mac/rls -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_MAC=ON -DFW2_CMAKE_VERSION=02 -DAPP_CMAKE_VERSION=01 -DFW2_LIB_CONFIG_DIR=                      -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/mac/rls -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_MAC=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON

# cmake -S . -B main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/mac/rls -G "Unix Makefiles" -DWP_PLATFORM_MAC=ON -DMAIN_NAME=tst_20221229 -DAPP_NAME=tst_20221206 -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF
# cmake --build main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/mac/rls --clean-first -- -j 4
# main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/mac/rls/mpfw_code_main_tst_20221229/wsp/cmake/project/subdir/tst_20221229.out
# main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/mac/rls/mpfw_code_main_tst_20221229/wsp/cmake/project/subdir/v_${APP_CMAKE_VERSION}/tst_20221229.out


####################
# PLATFORM NXP BUILD
####################
# fw2_lib configuration file directory setting
# cmake -S . -B main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/nxp/rls -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_NXP=ON  -DCMAKE_TOOLCHAIN_FILE=./arm-none-eabi-gcc.cmake -DFW2_CMAKE_VERSION=   -DAPP_CMAKE_VERSION=   -DFW2_LIB_CONFIG_DIR=libs/tst_20221206/src -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/nxp/rls -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_NXP=ON  -DCMAKE_TOOLCHAIN_FILE=./arm-none-eabi-gcc.cmake -DFW2_CMAKE_VERSION=   -DAPP_CMAKE_VERSION=   -DFW2_LIB_CONFIG_DIR=                      -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/nxp/rls -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_NXP=ON  -DCMAKE_TOOLCHAIN_FILE=./arm-none-eabi-gcc.cmake -DFW2_CMAKE_VERSION=01 -DAPP_CMAKE_VERSION=   -DFW2_LIB_CONFIG_DIR=                      -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/nxp/rls -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_NXP=ON  -DCMAKE_TOOLCHAIN_FILE=./arm-none-eabi-gcc.cmake -DFW2_CMAKE_VERSION=02 -DAPP_CMAKE_VERSION=01 -DFW2_LIB_CONFIG_DIR=                      -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
# cmake -S . -B main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/nxp/rls -G "Unix Makefiles" -DAPP_NAME=tst_20221229 -DWP_PLATFORM_NXP=ON       

# cmake -S . -B main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/nxp/rls -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE=./cmake/arm-none-eabi-gcc.cmake -DWP_PLATFORM_NXP=ON -DMAIN_NAME=tst_20221229 -DAPP_NAME=tst_20221206 -DCMAKE_BUILD_TYPE=Release -DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF
# cp main/mpfw_code_main_tst_20221229/wsp/cmake/project/link_script/rls/*.ld main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/nxp/rls/main/mpfw_code_main_tst_20221229/wsp/cmake/project/subdir/v_01
# cmake --build main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/nxp/rls --clean-first -- -j 4
# main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/nxp/rls/main/mpfw_code_main_tst_20221229/wsp/cmake/project/subdir/tst_20221229.out
# main/mpfw_code_main_tst_20221229/wsp/cmake/build_as_lib/nxp/rls/main/mpfw_code_main_tst_20221229/wsp/cmake/project/subdir/v_${APP_CMAKE_VERSION}/tst_20221229.out

cmake_minimum_required(VERSION 3.16)

# set the project name and version
project(${MAIN_NAME} VERSION 1.0)

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
## cmake files path
set(MAIN_CMAKE_FILES_PATH main/mpfw_code_main_${MAIN_NAME}/wsp/cmake/project_root)

## ******************************************************************
## __________________________________________________________________
## cmake subdirectories versions
#include(cmake/main/${MAIN_NAME}/lib_cmake_prj_version.cmake)
#include(cmake/main/${MAIN_NAME}/path_ver_config.cmake)
include(${MAIN_CMAKE_FILES_PATH}/lib_cmake_prj_version.cmake)
include(${MAIN_CMAKE_FILES_PATH}/path_ver_config.cmake)


## ******************************************************************
## __________________________________________________________________
## subdirectories Calls

set(RELATIVE_PATH__CODE     .)
set(RELATIVE_PATH__LIBS     libs)
set(RELATIVE_PATH__APPS     apps)

#include(cmake/main/${MAIN_NAME}/path_pub_config.cmake)
#include(cmake/main/${MAIN_NAME}/subdir.cmake)
include(${MAIN_CMAKE_FILES_PATH}/path_pub_config.cmake)
include(${MAIN_CMAKE_FILES_PATH}/subdir.cmake)

