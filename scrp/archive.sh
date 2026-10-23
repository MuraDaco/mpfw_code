#!/bin/bash

## to perform synchronization 
## { cat appl_app20250424_files_n_dirs_nxp.txt; cat appl_app20250424_files_n_dirs_mac.txt } | sort | uniq | archive.sh

current_script_dir=$(dirname "${BASH_SOURCE[0]}")
source $current_script_dir/func_echo.sh


## PATH_BKP=${PATH}
## PLATFORM_NAME=$1
## TRDP_LIST=$2

if ! [ -f $PWD/set_build_params.sh ]; then
  echo_clrd 1 31 "ERROR - To perform this script the current folder must have the \"set_build_params.sh\" file properly configured."
  exit 1
fi

WSP_VER_DIR=${PWD%/cmake}
WSP_VER_DIR=${WSP_VER_DIR##*/}
source $PWD/set_build_params.sh
echo "WSP_VER_DIR: $WSP_VER_DIR"
echo "BUILD_DIR: $BUILD_DIR"

## determine relative path respect "mpfw_code" directory
MPFW_CODE_DIR=${PWD%/mpfw_code/*}/mpfw_code
MPFW_CODE_CMAKE_RPATH="cmake/mpfw_fw2_cmake/v_$CMAKE_SRC_VER"
MPFW_CODE_CMAKE_DIR=$MPFW_CODE_DIR/$MPFW_CODE_CMAKE_RPATH



## { cat appl_app20250424_files_n_dirs_nxp.txt; cat appl_app20250424_files_n_dirs_mac.txt } | sort | uniq | archive.sh
echo                            >  ${APP_NAME}_archive.txt
echo "scrp"                     >> ${APP_NAME}_archive.txt
echo "$MPFW_CODE_CMAKE_RPATH"   >> ${APP_NAME}_archive.txt
echo "cmake/arm-none-eabi-gcc.cmake" >> ${APP_NAME}_archive.txt
if [ -n "${APP_NAME}" ]; then
    while IFS= read item; do

        status=$(echo $item | cut -d ':' -f1 )
        [[ "OK " = $status ]] && {
            rpath=$(echo $item | cut -d ':' -f2 )
            echo "$rpath" >> ${APP_NAME}_archive.txt
        } || true

    done
fi

date > ${APP_NAME}_sync_output.txt
current_dir=$PWD
(
    cd $MPFW_CODE_DIR
    [[ -f "$current_dir/${APP_NAME}_archive.txt" ]] && {
        [[ "run" = "$1" ]] && {
            [[ -d "archive/${APP_NAME}/mpfw_code" ]] || {
                echo "Creating 'archive/${APP_NAME}/mpfw_code' directory under 'mpfw_code' folder"
                mkdir -p "archive/${APP_NAME}/mpfw_code"
            }
            echo "Performing the real synchronization ..."
            { echo "Performing the real synchronization ..."; echo; } >> "$current_dir/${APP_NAME}_sync_output.txt"
            rsync -av --recursive --files-from="$current_dir/${APP_NAME}_archive.txt" . "archive/${APP_NAME}/mpfw_code" >> "$current_dir/${APP_NAME}_sync_output.txt"
            true
        } || {
            echo "Performing a simulation of synchronization ... (pass \"run\" parameter to perform the real synchro )"
            { echo "Performing a simulation of synchronization ... (pass \"run\" parameter to perform the real synchro )"; echo; } >> "$current_dir/${APP_NAME}_sync_output.txt"
            rsync -nav --recursive --files-from="$current_dir/${APP_NAME}_archive.txt" . "archive/${APP_NAME}/mpfw_code" >> "$current_dir/${APP_NAME}_sync_output.txt"
        }
    } || echo "${APP_NAME}_archive.txt does not exist."

)
