function echo_chk_clrd {
    echo -e "\033[$1;$2m""dbg msg - `basename $0` -> $3""\033[0;0m" > /dev/stderr
}

function param_display {

    echo
    echo_chk_clrd 1 32 "PATH:               $PATH"
    echo_chk_clrd 1 32 "main_name:          $main_name"
    echo_chk_clrd 1 32 "apps_name:          $apps_name"
    echo_chk_clrd 1 32 "platform:           $platform"
    echo_chk_clrd 1 32 "platform_cmake:     $platform_cmake"
    echo_chk_clrd 1 32 "toolchain_cmake:    $toolchain_cmake"
    echo_chk_clrd 1 32 "build_type:         $build_type"
    echo_chk_clrd 1 32 "build_type_cmake:   $build_type_cmake"
    echo_chk_clrd 1 32 "scriptlink:         $scriptlink"
    echo_chk_clrd 1 32 "verbose_cmake:      $verbose_cmake"
    echo_chk_clrd 1 32 "clean_cmake:        $clean_cmake"
    echo_chk_clrd 1 32 "remove option:      $option_r"
    
    echo

}

function param_display_clear {

    param_display
    echo
    echo_chk_clrd 1 32 "frommain_name:      $frommain_name"
    echo_chk_clrd 1 32 "fromapp_name:       $fromapp_name"
    
    echo

}

function param_display_cube_patch {

    echo
    echo_chk_clrd 1 32 "main_name:                          $main_name"
    echo_chk_clrd 1 32 "apps_name:                          $apps_name"
    echo_chk_clrd 1 32 "mod_type:                           $mod_type"
    echo_chk_clrd 1 32 "mod_name:                           $mod_name"
    echo_chk_clrd 1 32 "platform:                           $platform"
    echo_chk_clrd 1 32 "versiondir_rpath:                   $versiondir_rpath"
    echo_chk_clrd 1 32 "versiondir_apath:                   $versiondir_apath"
    echo_chk_clrd 1 32 "developenv:                         $developenv"
    echo_chk_clrd 1 32 "developenv_prj_rpath:               $developenv_prj_rpath"
    echo_chk_clrd 1 32 "developenv_prj_apath:               $developenv_prj_apath"
    echo_chk_clrd 1 32 "main_root_apath:                    $main_root_apath"
    echo_chk_clrd 1 32 "module_root_apath:                  $module_root_apath"
    echo_chk_clrd 1 32 "------"
    echo_chk_clrd 1 32 "eclipse_main_apath:                 $eclipse_main_apath"
    echo_chk_clrd 1 32 "eclipse_core_prefs_patch_file:      $eclipse_core_prefs_patch_file"
    echo_chk_clrd 1 32 "------"
    echo_chk_clrd 1 32 "eclipse_module_apath:               $eclipse_module_apath"
    echo_chk_clrd 1 32 "eclipse_cproject_patch_file:        $eclipse_cproject_patch_file"
    echo_chk_clrd 1 32 "conf_file_apath:                    $conf_file_apath"
    
    echo

}



function param_parsing_cube_patch {

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
    
    {
        [ -f "$mpfw_code_path/CMakeLists.txt" ] &&
        [ -f "$mpfw_code_path/cmake/arm-none-eabi-gcc.cmake" ]
    } && {
        pwd_backup="$PWD"
        cd $mpfw_code_path
        echo_chk_clrd 1 33 "PWD: $PWD"

    } || {
        ## echo_chk_clrd 1 31 "ERROR - neither \"CMakeLists.txt\" nor \"./cmake/arm-none-eabi-gcc.cmake\" files exist"
        echo_chk_clrd 1 31 "ERROR"
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
        param=$(git config -f "$scrip_config_file_path" -l | cut -d. -f1,2 | grep "\.$1$" | uniq)
        param_type=${param%.*}
        param_value=${param#*.}
        [ "$param_type" ] && {
            echo "param_type:  $param_type"
            echo "param_value: $param_value"
            case "$param_type" in
                "platform")
                    [ ! "$platform" ] && {
                        platform=$param_value
                    } || {
                        echo_chk_clrd 1 31 "WARNING - \"platform\" parameter is already set to \"$platform\" value"
                        exit 1
                    }
                ;;
                "apps" | \
                "libs" )
                    [ ! "$mod_name" ] && {
                        mod_name=$param_value
                        mod_type=$param_type
                    } || {
                        echo_chk_clrd 1 31 "WARNING - \"build type\" parameter is already set to \"$mod_name\" value"
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


    [ ! "$platform" ] &&  {
        echo_chk_clrd 1 31 "No \"platform\" selected"
        exit 1
    }

    [ ! "$main_name" ] &&  {
        echo_chk_clrd 1 31 "No \"main name app\" selected"
        exit 1
    }

    [ ! "$mod_name" ] &&  {
        mod_type="main"
        mod_name=$main_name
        echo_chk_clrd 1 33 "Warning - No \"module name\" selected - It is substitued by \"$main_name\" main name"
    }

    conf_dir_apath="main/mpfw_code_main_$main_name/wsp/cmake/project/$platform"
    conf_file_apath="$conf_dir_apath/set_conf_inc_dirs.cmake"
    
    module_root_apath="$mod_type/mpfw_code_$mod_type""_$mod_name"
    main_root_apath="main/mpfw_code_main_$main_name"

    versiondir_rpath=$(     git config -f "$scrip_config_file_path" --get main.$main_name.versiondir )
    developenv=$(           git config -f "$scrip_config_file_path" --get platform.$platform.developenv )
    developenv_prj_rpath=$( git config -f "$scrip_config_file_path" --get $mod_type.$mod_name.devenvprjdir )
    eclipse_module_rpath=$( git config -f "$scrip_config_file_path" --get $mod_type.$mod_name.eclipsedir )
    eclipse_main_rpath=$(   git config -f "$scrip_config_file_path" --get main.$main_name.eclipsedir )

    versiondir_apath="main/mpfw_code_main_$main_name/$versiondir_rpath/$mod_type/mpfw_code_$mod_type""_$mod_name"
    wrapper=$(              git config -f "$scrip_config_file_path" --get $mod_type.$mod_name.wrapper ) && {
        [ "$wrapper" = "true" ] && {
            versiondir_apath="$versiondir_apath/$platform"
        }
    }

    eval "developenv_prj_rpath=\"$developenv_prj_rpath\""
    developenv_prj_apath=$module_root_apath/$developenv_prj_rpath

    worksapce_apath="main/mpfw_code_main_$main_name/wsp/$developenv/workspace/$platform/.metadata/.plugins/org.eclipse.core.runtime/.settings"
    eclipse_core_prefs_patch_file="$worksapce_apath/org.eclipse.cdt.core.prefs_$mod_name""_patch"
    eclipse_cproject_patch_file="$developenv_prj_apath/.eclipse_cproject_patch"

    param_display_cube_patch

    [ -f "$worksapce_apath/org.eclipse.cdt.core.prefs" ] && {
        echo_chk_clrd 1 32 "OK - \"$worksapce_apath/org.eclipse.cdt.core.prefs\" file exists"
    } || {
        echo_chk_clrd 1 31 "ERROR - \"$worksapce_apath/org.eclipse.cdt.core.prefs\" file does not exist"
        exit 1
    }

    [ -f "$developenv_prj_apath/.project" ] && {
        echo_chk_clrd 1 32 "OK - \"$developenv_prj_apath/.project\" exists"
    } || {
        echo_chk_clrd 1 31 "ERROR - \"$developenv_prj_apath/.project\" does not exist"
        exit 1
    }

    [ -f "$conf_file_apath" ] && {
        echo_chk_clrd 1 32 "OK - \"$conf_file_apath\" file exists"
    } || {
        echo_chk_clrd 1 31 "ERROR - \"$conf_file_apath\" folder does not exist"
        exit 1
    }

    [ -f "$versiondir_apath/set_class_src_ver.cmake" ] && {
        echo_chk_clrd 1 32 "OK - \"$versiondir_apath/set_class_src_ver.cmake\" exists"
    } || {
        echo_chk_clrd 1 31 "WARNING - \"$versiondir_apath/set_class_src_ver.cmake\" does not exist"
        versiondir_apath=
    }


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
        param=$(git config -f "$scrip_config_file_path" -l | cut -d. -f1,2 | grep "\.$1$" | uniq)
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
                "apps")
                    [ ! "$apps_name" ] && {
                        apps_name=$param_value
                    } || {
                        echo_chk_clrd 1 31 "WARNING - \"apps name\" parameter is already set to \"$apps_name\" value"
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
    scriptlink=$(      git config -f "$scrip_config_file_path" --get main.$main_name.scriptlink)
    platform_cmake=$(  git config -f "$scrip_config_file_path" --get platform.$platform.platformcmake )
    toolchain_cmake=$( git config -f "$scrip_config_file_path" --get platform.$platform.toolchaincmake)
    PATH_TOOLCHAIN=$(  git config -f "$scrip_config_file_path" --get platform.$platform.PATHTOOLCHAIN )


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


function param_getting_clear {
    frommain_name=$(git config -f "$scrip_config_file_path" --get main.$main_name.frommain ) && {
        echo_chk_clrd 1 32 "OK - frommain_name"
    } || {
        echo_chk_clrd 1 31 "ERROR - frommain_name"
        exit 1
    }

    fromapp_name=$(git config -f "$scrip_config_file_path" --get apps.$apps_name.fromapp ) && {
        echo_chk_clrd 1 32 "OK - fromapp_name"
    } || {
        echo_chk_clrd 1 31 "ERROR - fromapp_name"
        exit 1
    }
}

## set_array_param=()
## while (( $# ))
## do
##     set_array_param+=("$1")
##     shift
## done
## 
## param_parsing "${set_array_param[@]}"
