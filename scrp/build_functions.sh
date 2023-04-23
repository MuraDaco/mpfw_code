
function echo_chk_clrd {
    echo -e "\033[$1;$2m""dbg msg - `basename $0` -> $3""\033[0;0m" > /dev/stderr
}

function param_display {

    echo
    echo_chk_clrd 1 32 "PATH:               $PATH"
    echo_chk_clrd 1 32 "main_name:          $main_name"
    echo_chk_clrd 1 32 "platform:           $platform"
    echo_chk_clrd 1 32 "platform_cmake:     $platform_cmake"
    echo_chk_clrd 1 32 "toolchain_cmake:    $toolchain_cmake"
    echo_chk_clrd 1 32 "build_type:         $build_type"
    echo_chk_clrd 1 32 "build_type_cmake:   $build_type_cmake"
    echo_chk_clrd 1 32 "verbose_cmake:      $verbose_cmake"
    echo_chk_clrd 1 32 "clean_cmake:        $clean_cmake"
    
    echo

}


    platform_default="stm"
    build_type_default="dbg"
    main_name=${PWD#*main/mpfw_code_main_}
    main_name=${main_name%%/*}
    path_basename=$(basename $PWD)
    [ "$path_basename" = "mpfw_code" ] && {
        mpfw_code_path=$PWD
    } || {
        mpfw_code_path=${PWD%/mpfw_code/*}/mpfw_code
    }
    
    [ ! -d "$mpfw_code_path" ] && {
        echo_chk_clrd 1 33 "PWD:  \"$PWD\""
        echo_chk_clrd 1 31 "No valid \"mpfw_code\" path: \"$mpfw_code_path\""
        exit 1
    }

    [ "$1" = -v ] && {
        shift
        verbose_cmake="-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON"
    } || {
        verbose_cmake="-DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF"
    }

    [ "$1" = -c ] && {
        shift
        clean_cmake="--clean-first"
    } || {
        clean_cmake=
    }

    case "$1" in
        "nxp" | "stm" | "mac")
            platform="$1"
            shift
        ;;
        "rls" | "dbg")
            build_type="$1"
            shift
        ;;
        *)
            [ "$1" ] && {
                [ ! "$1" = "-main" ] && {
                    echo_chk_clrd 1 31 "wrong parameter"
                    exit 1
                }
            } || {
                platform="$platform_default"
                build_type="$build_type_default"
            }
        ;;
    esac


    case "$1" in
        "nxp" | "stm" | "mac")
            [ ! "$platform" ] && platform="$1" || { 
                echo_chk_clrd 1 31  "Error - 2nd parameter is wrong: \"platform\" is already set"
                exit 1 
            }
            shift
        ;;
        "rls" | "dbg")
            [ ! "$build_type" ] && build_type="$1" || {
                echo_chk_clrd 1 31  "Error - 2nd parameter is wrong: \"build_type\" is already set"
                exit 1
            }
            shift
        ;;
        *)
            [ "$1" ] && {
                [ ! "$1" = "-main" ] && {
                    echo_chk_clrd 1 31 "wrong parameter"
                    exit 1
                }
            } || {
                [ "$platform" ] && {
                    build_type="$build_type_default"
                } || {
                    [ "$build_type" ] && platform="$platform_default"
                }
            }
        ;;
    esac

    [ ! "$main_name" ] && {
        [ "$1" = "-main" ] && {
            shift
            main_name="$1"
            [ ! -d "$mpfw_code_path/main/mpfw_code_main_${main_name}" ] && {
                echo_chk_clrd 1 31 "No valid \"main name app\" selected: \"$main_name\""
                exit 1
            }
            true
        } || {
            echo_chk_clrd 1 31 "No \"main name app\" selected, use \"-main\" to set it"
            exit 1
        }
    }

    [ "$build_type" = "rls" ] && build_type_cmake="-DCMAKE_BUILD_TYPE=Release"
    [ "$build_type" = "dbg" ] && build_type_cmake="-DCMAKE_BUILD_TYPE=Debug"

    [ "$platform" = "nxp" ] && {
        platform_cmake="-DWP_PLATFORM_NXP=ON"
        toolchain_cmake="-DCMAKE_TOOLCHAIN_FILE=./cmake/arm-none-eabi-gcc.cmake"
        PATH_TOOLCHAIN="/Users/work/Tools/nxp/mcux_11_5_1/arm_toolchain/ver_10_3_2021_07/tools/bin"        
        {
            [ ! -d "$mpfw_code_path/main/mpfw_code_main_${main_name}/wsp/xpresso" ]            && 
            [ ! -d "$mpfw_code_path/main/mpfw_code_main_${main_name}/wsp/cmake/project/nxp" ] 
        } && {
            echo_chk_clrd 1 31 "No valid compatible platform (\"$platform\") for selected app (\"$main_name\")"
            exit 1
        }
    }
    [ "$platform" = "stm" ] && {
        platform_cmake="-DWP_PLATFORM_STM=ON"
        toolchain_cmake="-DCMAKE_TOOLCHAIN_FILE=./cmake/arm-none-eabi-gcc.cmake"
        PATH_TOOLCHAIN="/Users/work/Tools/stm/cube_1_10_1/arm_toolchain/ver_10_3_2021_10/tools/bin"        
        {
            [ ! -d "$mpfw_code_path/main/mpfw_code_main_${main_name}/wsp/cube" ]            && 
            [ ! -d "$mpfw_code_path/main/mpfw_code_main_${main_name}/wsp/cmake/project/stm" ] 
        } && {
            echo_chk_clrd 1 31 "No valid compatible platform (\"$platform\") for selected app (\"$main_name\")"
            exit 1
        }
    }
    [ "$platform" = "mac" ] && platform_cmake="-DWP_PLATFORM_MAC=ON"

    [ "$PATH_TOOLCHAIN" ] && {
        [ -f "$PATH_TOOLCHAIN/arm-none-eabi-gcc" ] && {
            echo_chk_clrd 1 32 "OK ---- \"$PATH_TOOLCHAIN\" is a valid TOOLCHAIN path"
            export PATH=$PATH_TOOLCHAIN:$PATH
        } || {
            echo_chk_clrd 1 31 "ERROR - \"$PATH_TOOLCHAIN\" is not a valid TOOLCHAIN path"
        }
    }

