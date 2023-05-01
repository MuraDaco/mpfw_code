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

if(NOT DEFINED WP_PLATFORM_STR)
    message(FATAL_ERROR "NO PLATFORM selected !!!!" )
endif()

## ******************************************************************
## __________________________________________________________________
## subdirectories Calls

set(RELATIVE_PATH__CODE     .)
include(cmake/mpfw_code_cmake/set_public_include_prj_dir_main.cmake                         )
set(RELATIVE_PATH__LIBS     libs)
set(RELATIVE_PATH__APPS     apps)

# step_1 - cmake subdirectories/project versions & project dir set
# step 1.1 - set project version 
include(${RELATIVE_PATH__MAIN_PUBLIC_ROOTMODULE}/set_modules_cmake_prj_ver.cmake)
# step 1.2 - set project directories 
include(${RELATIVE_PATH__MAIN_PUBLIC_ROOTMODULE}/include_modules_set_cmake_prj_dir.cmake)

## ******************************************************************
## __________________________________________________________________

# set common directory to which all modules can access
# here all sub-modules can find public directory of each other sub-module
set(GLOBAL_CMAKE_MODULES_PATH cmake/mpfw_code_cmake/${MPFW_CMAKE_VER_DIR})

# call CMakeLists.txt file of all sub-projects
include(${RELATIVE_PATH__MAIN_PUBLIC_ROOTMODULE}/subdir.cmake)

