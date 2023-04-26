cmake_minimum_required(VERSION 3.16)

# set the project name and version
project(${MAIN_NAME} VERSION 1.0)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED True)

#enable_language(C ASM)
#set(CMAKE_C_STANDARD 11)
#set(CMAKE_C_STANDARD_REQUIRED ON)
#set(CMAKE_C_EXTENSIONS OFF)

message(STATUS "TOOLCHAIN - ASM:                  ${CMAKE_ASM_COMPILER}")
message(STATUS "TOOLCHAIN - C:                    ${CMAKE_C_COMPILER}"  )
message(STATUS "TOOLCHAIN - C++:                  ${CMAKE_CXX_COMPILER}")

## ******************************************************************
## __________________________________________________________________
## PLATFORM Definitions

## if(WP_PLATFORM_LINUX)
##     if(DEFINED WP_PLATFORM_STR)
##         message(FATAL_ERROR "TOO MANY PLATFORM selected !!!!" )
##     else()
##         set(WP_PLATFORM_STR     linux   )
##     endif()
## endif()
## 
## if(WP_PLATFORM_MAC)
##     if(DEFINED WP_PLATFORM_STR)
##         message(FATAL_ERROR "TOO MANY PLATFORM selected !!!!" )
##     else()
##         set(WP_PLATFORM_STR     mac   )
##     endif()
## endif()
## 
## if(WP_PLATFORM_NXP)
##     if(DEFINED WP_PLATFORM_STR)
##         message(FATAL_ERROR "TOO MANY PLATFORM selected !!!!" )
##     else()
##         set(WP_PLATFORM_STR     nxp   )
##     endif()
## endif()
## 
## if(WP_PLATFORM_STM)
##     if(DEFINED WP_PLATFORM_STR)
##         message(FATAL_ERROR "TOO MANY PLATFORM selected !!!!" )
##     else()
##         set(WP_PLATFORM_STR     stm   )
##     endif()
## endif()
## 
## include(cmake/plt_stm32f769_disco.cmake)
## 
## if(WP_PLATFORM_STM32F769DISCO)
##     if(DEFINED WP_PLATFORM_STR)
##         message(FATAL_ERROR "TOO MANY PLATFORM selected !!!!" )
##     else()
##         set(WP_PLATFORM_STR     stm32f769_disco   )
##     endif()
## endif()

if(NOT DEFINED WP_PLATFORM_STR)
    message(FATAL_ERROR "NO PLATFORM selected !!!!" )
endif()

## ******************************************************************
## __________________________________________________________________
## cmake files path
set(GLOBAL_CMAKE_MODULES_PATH cmake/modules)
set(MAIN_CMAKE_FILES_PATH main/mpfw_code_main_${MAIN_NAME}/wsp/cmake/project_root)

## ******************************************************************
## __________________________________________________________________
## cmake subdirectories versions
include(${MAIN_CMAKE_FILES_PATH}/lib_cmake_prj_version.cmake)
include(${MAIN_CMAKE_FILES_PATH}/path_ver_config.cmake)


## ******************************************************************
## __________________________________________________________________
## subdirectories Calls

set(RELATIVE_PATH__CODE     .)
set(RELATIVE_PATH__LIBS     libs)
set(RELATIVE_PATH__APPS     apps)

include(${MAIN_CMAKE_FILES_PATH}/path_pub_config.cmake)
include(${MAIN_CMAKE_FILES_PATH}/subdir.cmake)

