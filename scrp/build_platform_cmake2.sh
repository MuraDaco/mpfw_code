#!/bin/bash

current_script_dir=$(dirname "${BASH_SOURCE[0]}")
source $current_script_dir/func_echo.sh

declare -a out_cmake_array
# ********************************************************
function update_path {
    while IFS= read item; do
        echo "${item#*mpfw_code/}" 
    done
}

function output_cmake     {
    item_id=0
    while IFS= read item; do
        out_cmake_array+=( "$item" )
        echo xxx ${out_cmake_array[$item_id]}
        ((item_id++))
    done

    echo "yyy ${out_cmake_array[@]}"    
}


function get_wsp_path {
    while IFS= read item; do
        ## echo "wsp - $item" 
        module_name=$(echo $item | cut -d ':' -f2 )
        wsp_rpath=$(echo $item | cut -d ':' -f3 )
        mpfw_code_dir=${PWD%/mpfw_code/*}
        result_find1=$(find $mpfw_code_dir/mpfw_code -type d -maxdepth 5 -name "$module_name")
        while IFS= read wsp_apath; do
            [ -d "$wsp_apath/$wsp_rpath" ] && echo "OK :$wsp_apath/$wsp_rpath" || echo "ERROR :$wsp_apath/$wsp_rpath"
        done < <(find $result_find1 -type d -name "wsp")
    done
}

function get_wsp_path_2 {
    (
        cd $MPFW_CODE_DIR

        for item in ${out_cmake_array[@]}; do
            header=$(echo $item | cut -d ':' -f1 )

            [[ "wsp" = "$header" ]] && {

                module_name=$(echo $item | cut -d ':' -f2 )
                wsp_rpath=$(echo $item | cut -d ':' -f3 )

                result_find1=$(find $MPFW_CODE_DIR -type d -maxdepth 5 -name "$module_name")
                while IFS= read wsp_apath; do
                    rpath="$wsp_apath/$wsp_rpath"
                    rpath=${rpath#*/mpfw_code/}
                    [ -d "$rpath" ] && echo "OK :$rpath" || echo "ERROR :$rpath"
                done < <(find $result_find1 -type d -name "wsp")
            }
        done
    )
}

function get_cfg_path {
    while IFS= read item; do
        ## echo "cfg - $item" 
        module_name=$(echo $item | cut -d ':' -f2 )
        cfg_rpath=$(echo $item | cut -d ':' -f3 )
        mpfw_code_dir=${PWD%/mpfw_code/*}
        result_find1=$(find $mpfw_code_dir/mpfw_code -type d -maxdepth 5 -name "$module_name")
        while IFS= read cfg_apath; do
            [ -d "$cfg_apath/$cfg_rpath" ] && echo "OK :$cfg_apath/$cfg_rpath" || echo "ERROR :$cfg_apath/$cfg_rpath"
        done < <(find $result_find1 -type d -name "wsp")
    done
}

function get_cfg_path_2 {
    (
        cd $MPFW_CODE_DIR
        for item in ${out_cmake_array[@]}; do
            header=$(echo $item | cut -d ':' -f1 )
            [[ "cfg" = "$header" ]] && {

                module_name=$(echo $item | cut -d ':' -f2 )
                cfg_rpath=$(echo $item | cut -d ':' -f3 )

                result_find1=$(find $MPFW_CODE_DIR -type d -maxdepth 5 -name "$module_name")
                while IFS= read cfg_apath; do
                    rpath="$cfg_apath/$cfg_rpath"
                    rpath=${rpath#*/mpfw_code/}
                    [ -d "$rpath" ] && echo "OK :$rpath" || echo "ERROR :$rpath"
                done < <(find $result_find1 -type d -name "wsp")
            }
        done
    )
}

function get_extlib_path {
    (
        cd $MPFW_CODE_DIR
        for item in ${out_cmake_array[@]}; do
            header=$(echo $item | cut -d ':' -f1 )
            [[ "extlib" = "$header" ]] && {

                mpfw_code_dir=$(        echo $item | cut -d ':' -f2 )
                module_root_rpath=$(    echo $item | cut -d ':' -f3 )
                extlib_rpath=$(         echo $item | cut -d ':' -f4 )
                extlib_dir="$mpfw_code_dir/$extlib_rpath"
                [ -d "$extlib_rpath" ] && echo "OK :$extlib_rpath" || echo "ERROR :$extlib_rpath"
            }
        done
    )
}

function get_h_n_c_cpp_files    {
    while IFS= read item; do
        [ -d "$item" ] && {
            cntr=0
            while IFS= read file_h; do
                ((cntr++))
                [[ -f "$file_h" ]] && echo "OK :$file_h" || true
            done < <(echo "$item/"*.h | tr ' ' '\n'; echo "$item/"*_template.cpp | tr ' ' '\n')
            ## done < <(echo "$item/"*.h | tr ' ' '\n')
            [[ $cntr -eq 0 ]] && echo "WARNING - no include files :$item" || true
        } || {
            [ -f "$item" ] && {
                echo "OK :$item"
            } || {
                echo "ERROR - no folder nor regular file :$item"
            }
        }
    done
}

function get_archive    {
    (
        date > $output_filtered_build
        cd $MPFW_CODE_DIR
        for item in ${out_cmake_array[@]}; do

            echo $item >> $output_filtered_build
            echo $item | grep "/mpfw_code/" > /dev/null 2>&1 && {

                item=${item#*/mpfw_code/}            
                [ -d "$item" ] && {
                    cntr=0
                    while IFS= read file_h; do
                        ((cntr++))
                        [[ -f "$file_h" ]] && echo "OK :$file_h" || true
                    done < <(echo "$item/"*.h | tr ' ' '\n'; echo "$item/"*_template.cpp | tr ' ' '\n')
                    ## done < <(echo "$item/"*.h | tr ' ' '\n')
                    [[ $cntr -eq 0 ]] && echo "WARNING - no include files :$item" || true
                } || {
                    [ -f "$item" ] && {
                        echo "OK :$item"
                    } || {
                        echo "ERROR - no folder nor regular file :$item"
                    }
                }

            } || {

                header=$(echo $item | cut -d ':' -f1 )
                [[ "cfg" = "$header" ]] && {

                    module_name=$(echo $item | cut -d ':' -f2 )
                    cfg_rpath=$(echo $item | cut -d ':' -f3 )

                    result_find1=$(find $MPFW_CODE_DIR -type d -maxdepth 5 -name "$module_name")
                    while IFS= read cfg_apath; do
                        rpath="$cfg_apath/$cfg_rpath"
                        rpath=${rpath#*/mpfw_code/}
                        [ -d "$rpath" ] && echo "OK :$rpath" || echo "ERROR :$rpath"
                    done < <(find $result_find1 -type d -name "wsp")
                }

                [[ "wsp" = "$header" ]] && {

                    module_name=$(echo $item | cut -d ':' -f2 )
                    wsp_rpath=$(echo $item | cut -d ':' -f3 )

                    result_find1=$(find $MPFW_CODE_DIR -type d -maxdepth 5 -name "$module_name")
                    while IFS= read wsp_apath; do
                        rpath="$wsp_apath/$wsp_rpath"
                        rpath=${rpath#*/mpfw_code/}
                        [ -d "$rpath" ] && echo "OK :$rpath" || echo "ERROR :$rpath"
                    done < <(find $result_find1 -type d -name "wsp")
                }

                [[ "extlib" = "$header" ]] && {

                    mpfw_code_dir=$(        echo $item | cut -d ':' -f2 )
                    module_root_rpath=$(    echo $item | cut -d ':' -f3 )
                    extlib_rpath=$(         echo $item | cut -d ':' -f4 )
                    extlib_dir="$mpfw_code_dir/$extlib_rpath"
                    [ -d "$extlib_rpath" ] && echo "OK :$extlib_rpath" || echo "ERROR :$extlib_rpath"
                }

            }
        done
    )
}


function get_h_n_c_cpp_files_2    {
    (
        echo $item > $output_filtered_build
        cd $MPFW_CODE_DIR
        for item in ${out_cmake_array[@]}; do

            echo $item | grep "/mpfw_code/" > /dev/null 2>&1 && {
                echo $item >> $output_filtered_build

                item=${item#*/mpfw_code/}            
                [ -d "$item" ] && {
                    cntr=0
                    while IFS= read file_h; do
                        ((cntr++))
                        [[ -f "$file_h" ]] && echo "OK :$file_h" || true
                    done < <(echo "$item/"*.h | tr ' ' '\n'; echo "$item/"*_template.cpp | tr ' ' '\n')
                    ## done < <(echo "$item/"*.h | tr ' ' '\n')
                    [[ $cntr -eq 0 ]] && echo "WARNING - no include files :$item" || true
                } || {
                    [ -f "$item" ] && {
                        echo "OK :$item"
                    } || {
                        echo "ERROR - no folder nor regular file :$item"
                    }
                }

            }
        done
    )
}

PATH_BKP=${PATH}
PLATFORM_NAME=$1
TRDP_LIST=$2
archive_par=$3

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
MPFW_CODE_CMAKE_DIR=$MPFW_CODE_DIR/cmake/mpfw_fw2_cmake/v_$CMAKE_SRC_VER

if ! [ -f $MPFW_CODE_DIR/cmake/arm-none-eabi-gcc.cmake ]; then
  echo "File \"arm-none-eabi-gcc.cmake\" is not found."
  echo "MPFW_CODE_DIR: $MPFW_CODE_DIR"
  exit 1
fi

## PLATFORM_NAME=$1
## MPFW_CODE_CMAKE_DIR=../../../../../../cmake
## BUILD_DIR=../../../build/${PLATFORM_NAME}

## NXP - PATH_TOOLCHAIN
    ## IDE 11.5.1
        ## PATH_TOOLCHAIN="/Applications/MCUXpressoIDE_11.5.1_7266/ide/tools/bin"
        ## PATH_TOOLCHAIN="/Users/work/Tools/nxp/mcux_11_5_1/arm_toolchain/ver_10_3_2021_07/tools/bin"
    ## IDE 11.9.1
        ## PATH_TOOLCHAIN="/Applications/MCUXpressoIDE_11.9.1_2170/ide/plugins/com.nxp.mcuxpresso.tools.macosx_11.9.1.202402080819/tools/bin"
        ## PATH_TOOLCHAIN="/Applications/MCUXpressoIDE_11.9.1_2170/ide/tools/bin"
        ## PATH_TOOLCHAIN="/Users/work/Tools/nxp/mcux_11_9_1/arm_toolchain/ver_12_3_1_20230626/tools/bin"
## STM32F769_DISCO - PATH_TOOLCHAIN
    ## IDE 1_10_1
        ## PATH_TOOLCHAIN="/Users/work/Applications/STM32_1_10_1/STM32CubeIDE.app/Contents/Eclipse/plugins/com.st.stm32cube.ide.mcu.externaltools.gnu-tools-for-stm32.10.3-2021.10.macos64_1.0.0.202111181127/tools/bin"
        ## PATH_TOOLCHAIN="/Users/work/Tools/stm/cube_1_10_1/arm_toolchain/ver_10_3_2021_10/tools/bin"
    ## IDE 1_15_1
        ## PATH_TOOLCHAIN="/Users/work/Applications/STM32_1_15_1/STM32CubeIDE.app/Contents/Eclipse/plugins/com.st.stm32cube.ide.mcu.externaltools.gnu-tools-for-stm32.12.3.rel1.macos64_1.0.100.202403111906/tools/bin"
        ## PATH_TOOLCHAIN="/Users/work/Tools/stm/cube_1_15_1/arm_toolchain/ver_12_3_rel_1/tools/bin"

out_cmake_array=()

[ -n "$PLATFORM_NAME" ] && {

    if [ $PLATFORM_NAME = "mac" ];
    then
        if [ -z "${APP_NAME}" ]; then
            ## verbose -> cmake -S . -B ${BUILD_DIR} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DPLATFORM_NAME=${PLATFORM_NAME} -DTRDP_LIST=${TRDP_LIST} -DBUILD_DIR=$BUILD_DIR -DMPFW_CODE_CMAKE_DIR=$MPFW_CODE_CMAKE_DIR -DEXTNL_LIB=N -DSRC_CFG=${SRC_CFG} -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
            cmake -S . -B ${BUILD_DIR} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DPLATFORM_NAME=${PLATFORM_NAME} -DTRDP_LIST=${TRDP_LIST} -DBUILD_DIR=$BUILD_DIR -DMPFW_CODE_CMAKE_DIR=$MPFW_CODE_CMAKE_DIR -DEXTNL_LIB=N -DSRC_CFG=${SRC_CFG} -DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF
        else
            ## verbose -> cmake -S . -B ${BUILD_DIR} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DPLATFORM_NAME=${PLATFORM_NAME} -DTRDP_LIST=${TRDP_LIST} -DBUILD_DIR=$BUILD_DIR -DMPFW_CODE_CMAKE_DIR=$MPFW_CODE_CMAKE_DIR -DEXTNL_LIB=N -DSRC_CFG=${SRC_CFG} -DAPP_NAME=${APP_NAME} -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
            while IFS= read item; do
                out_cmake_array+=( "$item" )
            done < <( cmake -S . -B ${BUILD_DIR} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DPLATFORM_NAME=${PLATFORM_NAME} -DTRDP_LIST=${TRDP_LIST} -DBUILD_DIR=$BUILD_DIR -DMPFW_CODE_CMAKE_DIR=$MPFW_CODE_CMAKE_DIR -DEXTNL_LIB=N -DSRC_CFG=${SRC_CFG} -DAPP_NAME=${APP_NAME} -DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF | grep "filelist --" | tr ';' '\n' | sort | uniq )
        fi
        echo
        echo "\"mac\" platform selected"    
        echo "MPFW_CODE_CMAKE_DIR:      $MPFW_CODE_CMAKE_DIR"
    fi

    if [ $PLATFORM_NAME = "nxp" ];
    then
        PATH_TOOLCHAIN="/Applications/MCUXpressoIDE_11.5.1_7266/ide/tools/bin"
        export PATH=$PATH_TOOLCHAIN:$PATH_BKP
        if [ -z "${APP_NAME}" ]; then
            cmake -S . -B ${BUILD_DIR} -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE=${MPFW_CODE_DIR}/cmake/arm-none-eabi-gcc.cmake -DBUILD_DIR=$BUILD_DIR -DMPFW_CODE_CMAKE_DIR=$MPFW_CODE_CMAKE_DIR -DCMAKE_BUILD_TYPE=Release -DPLATFORM_NAME=${PLATFORM_NAME} -DTRDP_LIST=${TRDP_LIST} -DEXTNL_LIB=N -DSRC_CFG=${SRC_CFG}
        else
            while IFS= read item; do
                out_cmake_array+=( "$item" )
            done < <( cmake -S . -B ${BUILD_DIR} -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE=${MPFW_CODE_DIR}/cmake/arm-none-eabi-gcc.cmake -DBUILD_DIR=$BUILD_DIR -DMPFW_CODE_CMAKE_DIR=$MPFW_CODE_CMAKE_DIR -DCMAKE_BUILD_TYPE=Release -DPLATFORM_NAME=${PLATFORM_NAME} -DTRDP_LIST=${TRDP_LIST} -DEXTNL_LIB=N -DSRC_CFG=${SRC_CFG} -DAPP_NAME=${APP_NAME} | grep "filelist --" | tr ';' '\n' | sort | uniq )
        fi

        echo
        echo "\"nxp\" platform selected"
    fi

    [[ "archive" = "$archive_par" ]] && {
        archive_dirs_n_files="appl_${APP_NAME}_files_n_dirs_${PLATFORM_NAME}.txt"
        output_filtered_build="$PWD/appl_${APP_NAME}_build_filtered_${PLATFORM_NAME}.txt"
        get_archive             >   $archive_dirs_n_files
        ## get_wsp_path_2          >   $archive_dirs_n_files
        ## get_cfg_path_2          >>  $archive_dirs_n_files
        ## get_h_n_c_cpp_files_2   >>  $archive_dirs_n_files
        ## get_extlib_path         >>  $archive_dirs_n_files
    } || true
    


    if [ $PLATFORM_NAME = "stm32f769_disco" ];
    then
        PATH_TOOLCHAIN="/Users/work/Tools/stm/cube_1_10_1/arm_toolchain/ver_10_3_2021_10/tools/bin"
        export PATH=$PATH_TOOLCHAIN:$PATH_BKP
        if [ -z "${APP_NAME}" ]; then
            cmake -S . -B ${BUILD_DIR} -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE=${MPFW_CODE_DIR}/cmake/arm-none-eabi-gcc.cmake -DBUILD_DIR=$BUILD_DIR -DMPFW_CODE_CMAKE_DIR=$MPFW_CODE_CMAKE_DIR -DCMAKE_BUILD_TYPE=Release -DPLATFORM_NAME=${PLATFORM_NAME} -DTRDP_LIST=${TRDP_LIST} -DEXTNL_LIB=N -DSRC_CFG=${SRC_CFG}
        else
            cmake -S . -B ${BUILD_DIR} -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE=${MPFW_CODE_DIR}/cmake/arm-none-eabi-gcc.cmake -DBUILD_DIR=$BUILD_DIR -DMPFW_CODE_CMAKE_DIR=$MPFW_CODE_CMAKE_DIR -DCMAKE_BUILD_TYPE=Release -DPLATFORM_NAME=${PLATFORM_NAME} -DTRDP_LIST=${TRDP_LIST} -DEXTNL_LIB=N -DSRC_CFG=${SRC_CFG} -DAPP_NAME=${APP_NAME}
        fi
        echo
        echo "\"stm32f769_disco\" platform selected"
    fi

    echo "PLATFORM_NAME:    $PLATFORM_NAME"
    echo "SRC_CFG:          $SRC_CFG"
    echo "PATH:             $PATH"
    echo
    echo "PWD:              $PWD"
    echo "TRDP_LIST:        $TRDP_LIST"
    pwd

} || {
    script_name=$(basename "$0")
    echo_clrd 1 33 "WARNING - you must set <platform name>"
    echo_clrd 1 33 "WARNING - usage: '$ $script_name <platform name>' "

    echo_clrd 1 34 "INFO - the available <platform name> are:"
    echo_clrd 1 34 "INFO -     . mac"
    echo_clrd 1 34 "INFO -     . nxp"
    echo_clrd 1 34 "INFO -     . stm32f769_disco"

}
