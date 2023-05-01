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
    echo_chk_clrd 1 32 "remove option:      $option_r"
    
    echo

}

function param_parsing {

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
    
    scrip_config_file_path="$PWD/scrp/build_script_config.txt"
    [ ! -f "$scrip_config_file_path" ] && {
        scrip_config_file_path=${PWD%/mpfw_code/*}/mpfw_code/scrp/build_script_config.txt
        [ ! -f "$scrip_config_file_path" ] && {
            echo_chk_clrd 1 31 "ERROR - No script config file (\"build_script_config.txt\") is detected. exit 1"
            exit 1
        }
    }
    
    while (( $# )) 
    do
        param=$(git config -f "$scrip_config_file_path" -l | cut -d. -f1,2 | grep ".$1$" | uniq)
        param_type=${param%.*}
        param_value=${param#*.}
        [ "$param_type" ] && {
            echo "param_type:  $param_type"
            echo "param_value: $param_value"
            case "$param_type" in
                "option")
                    parameter=$(git config -f "$scrip_config_file_path" --get option.$param_value.parameter ) && {
                        value=$(    git config -f "$scrip_config_file_path" --get option.$param_value.value ) && {
                            eval "$parameter=\"$value\""
                        }
                    }
                ;;
                "platform")
                    [ ! "$platform" ] && {
                        platform=$param_value
                    } || {
                        echo_chk_clrd 1 31 "WARNING - \"platform\" parameter is already set to \"$platform\" value"
                        exit 1
                    }
                ;;
                "buildtype")
                    [ ! "$build_type" ] && {
                        build_type=$param_value
                    } || {
                        echo_chk_clrd 1 31 "WARNING - \"build type\" parameter is already set to \"$build_type\" value"
                        exit 1
                    }
                ;;
                "main")
                    [ ! "$main_name" ] && {
                        main_name=$param_value
                    } || {
                        echo_chk_clrd 1 31 "WARNING - \"main name\" parameter is already set to \"$main_name\" value"
                        exit 1
                    }
                ;;
                *)
                ;;
            esac
        } || {
            echo_chk_clrd 1 31 "WARNING - there is no any \"$1\" parameter in  \"$scrip_config_file_path\" config file"
            exit 1
        }
    
        shift
    done
    
    [ ! "$platform" ] && {
        platform=$(       git config -f "$scrip_config_file_path" --get default.parameter.paramplatform )
    }
    platform_cmake=$(     git config -f "$scrip_config_file_path" --get platform.$platform.platformcmake )
    toolchain_cmake=$(    git config -f "$scrip_config_file_path" --get platform.$platform.toolchaincmake)
    PATH_TOOLCHAIN=$(     git config -f "$scrip_config_file_path" --get platform.$platform.PATHTOOLCHAIN )
    
    [ ! "$build_type" ] && {
        build_type=$(   git config -f "$scrip_config_file_path" --get default.parameter.parambuildtype    )
    }
    build_type_cmake=$( git config -f "$scrip_config_file_path" --get buildtype.$build_type.buildtypecmake )
    
    [ "$PATH_TOOLCHAIN" ] && {
        [ -f "$PATH_TOOLCHAIN/arm-none-eabi-gcc" ] && {
            echo_chk_clrd 1 32 "OK ---- \"$PATH_TOOLCHAIN\" is a valid TOOLCHAIN path"
            export PATH=$PATH_TOOLCHAIN:$PATH
        } || {
            echo_chk_clrd 1 31 "ERROR - \"$PATH_TOOLCHAIN\" is not a valid TOOLCHAIN path"
        }
    }

    [ ! "$main_name" ] &&  {
        echo_chk_clrd 1 31 "No \"main name app\" selected"
        exit 1
    }

}

set_array_param=()
while (( $# ))
do
    set_array_param+=("$1")
    shift
done

param_parsing "${set_array_param[@]}"
