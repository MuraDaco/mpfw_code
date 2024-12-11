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

set(MPFW_CMAKE_SUPER_PROJECT_DIR        ${CMAKE_CURRENT_SOURCE_DIR} )
set(MPFW_TRACE_FILE_CNT 0)
macro(trace_execution_cmakelists)
    if(TRACE_FILE) 
        set(MPFW_TRACE_FILE_INDENT 2)
        string(REPLACE "${MPFW_CMAKE_SUPER_PROJECT_DIR}/" "" CURRENT_LIST_FILE "${CMAKE_CURRENT_LIST_FILE}" )    
        string(REPEAT "    " ${MPFW_TRACE_FILE_INDENT} INDENT_STRING)
        message(STATUS "---- debug --- trace cmake file ---- ${INDENT_STRING}- start CMakeList.txt ---- ${CURRENT_LIST_FILE} ") 
    endif()
endmacro()

macro(trace_execution)
    if(TRACE_FILE) 
        MATH(EXPR MPFW_TRACE_FILE_INDENT "${MPFW_TRACE_FILE_INDENT}+1")    
        MATH(EXPR MPFW_TRACE_FILE_CNT "${MPFW_TRACE_FILE_CNT}+1")
        string(REPEAT "    " ${MPFW_TRACE_FILE_INDENT} INDENT_STRING)
        string(REPLACE "${MPFW_CMAKE_SUPER_PROJECT_DIR}/" "" CURRENT_LIST_FILE "${CMAKE_CURRENT_LIST_FILE}" )    
        message(STATUS "---- debug --- trace cmake file ---- ${INDENT_STRING}- ${MPFW_TRACE_FILE_CNT} -- ${CURRENT_LIST_FILE} ") 
    endif()
endmacro()

macro(end_include)
    if(TRACE_FILE) 
        MATH(EXPR MPFW_TRACE_FILE_INDENT "${MPFW_TRACE_FILE_INDENT}-1")    
    endif()
endmacro()

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
## set mpfw_code (CODE_DIR) path relative to current directory
set(CODE_DIR        .)

## ******************************************************************
## __________________________________________________________________
## set cmake module version dir and cmake dirs
include(${CODE_DIR}/cmake/mpfw_code_cmake/main/${MAIN_NAME}/set_cmake_ver_dir.cmake )
## set cmake module relative path
include(${CODE_DIR}/cmake/mpfw_code_cmake/set_cmake_dir_rpath.cmake )

## ******************************************************************
## __________________________________________________________________
## set main, apps & libs directory paths
include(${CODE_DIR}/cmake/${CMAKE_ROOT_VER_DIR_RPATH}/set_modules_root_dir.cmake )

## ******************************************************************
## __________________________________________________________________
## call sub-projects
# step_1 - prepare to call sub-projects (cmake subdirectories/project versions & project dir set)
# step 1.1 - set project version 
include(${CMAKE_MAIN_XXX_DIR}/01_set_modules_cmake_prj_ver.cmake)
# step 1.2 - set project directories 
include(${CMAKE_MAIN_XXX_DIR}/02_include_modules_set_cmake_prj_dir.cmake)
# step 2 - call sub-projects
include(${CMAKE_MAIN_XXX_DIR}/subdir.cmake)

message(STATUS "End   super-project CMAkeLists.txt")
