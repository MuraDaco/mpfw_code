#   *******************************************************************************
#   
#   mpfw / fw2 - Multi Platform FirmWare FrameWork 
#       library that contains the "main" entry point and, 
#       eventualy, application code that is platform dependent
#   Copyright (C) (2023) Marco Dau
#   
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU Affero General Public License as published
#   by the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#   
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU Affero General Public License for more details.
#   
#   You should have received a copy of the GNU Affero General Public License
#   along with this program.  If not, see <https://www.gnu.org/licenses/>.
#   
#   You can contact me by the following email address
#   marco <d o t> ing <d o t> dau <a t> gmail <d o t> com
#   
#   *******************************************************************************
message(STATUS "Start super-project CMAkeLists.txt")

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

set(CODE_DIR     .)
set(CMAKE_MODULE_RPATH cmake/mpfw_code_cmake)
include(cmake/mpfw_code_cmake/set_apps_libs_dirs.cmake )
include(cmake/mpfw_code_cmake/set_public_include_prj_dir_main.cmake )

# step_1 - cmake subdirectories/project versions & project dir set
# step 1.1 - set project version 
include(${MAIN_CMAKE_PUBLIC_ROOTMODULE_RPATH}/01_set_modules_cmake_prj_ver.cmake)
# step 1.2 - set project directories 
include(${MAIN_CMAKE_PUBLIC_ROOTMODULE_RPATH}/02_include_modules_set_cmake_prj_dir.cmake)

## ******************************************************************
## __________________________________________________________________

# set common directory to which all modules can access
# here all sub-modules can find/set public directory of each other sub-module
set(CMAKE_MODULE_VER_RPATH ${CMAKE_MODULE_RPATH}/${MPFW_CMAKE_VER_DIR})

message(STATUS "MAIN_XXX_SRC_COMMON_RPATH: ${MAIN_XXX_SRC_COMMON_RPATH}")

# call CMakeLists.txt file of all sub-projects
include(${MAIN_CMAKE_PUBLIC_ROOTMODULE_RPATH}/subdir.cmake)

message(STATUS "End   super-project CMAkeLists.txt")
