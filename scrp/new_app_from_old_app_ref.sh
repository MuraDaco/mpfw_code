#!/bin/bash

source build_functions.sh

function check_rename   {
    empty_list=" "

    get_name=$(basename "$1")
    get_folder=$(dirname "$1")
    get_prefix=${get_name%$2*}
    get_postfix=${get_name#*$2}

    echo_chk_clrd 1 33 "\"$1\" - prefix: \"$get_prefix\" - postfix: \"$get_postfix\""
    correct_name="$get_prefix""$3""$get_postfix"
    rename_cmd="mv \"$get_folder/$get_name\" \"$get_folder/$correct_name\""
    echo_chk_clrd 1 35 "$rename_cmd"
    eval "$rename_cmd"


}

# check_rename_2 "main_module" "main_name" "d"
# check_rename_2 "main_module" "main_name" "f"
# check_rename_2 "main_module" "apps_name" "d"
# check_rename_2 "main_module" "apps_name" "f"
# check_rename_2 "apps_module" "main_name" "d"
# check_rename_2 "apps_module" "main_name" "f"
# check_rename_2 "apps_module" "apps_name" "d"
# check_rename_2 "apps_module" "apps_name" "f"
function check_rename_2 {

    [ "$1" = "main_module" ] && find_dir="main/mpfw_code_main_$main_name"
    [ "$1" = "apps_module" ] && find_dir="apps/mpfw_code_apps_$apps_name"
    [ "$2" = "main_name" ]   && { old_name="$frommain_name"; new_name="$main_name"; }
    [ "$2" = "apps_name" ]   && { old_name="$fromapp_name"; new_name="$apps_name"; }

    echo_chk_clrd 1 33 "in \"$find_dir\" seraching \"$old_name\" of type \"$3\""
    empty_list=
    while IFS= read -r item; do
        check_rename "$item" "$old_name" "$new_name"
    done < <(find "$find_dir"  -type $3 -name "*$old_name*")
    [ "$empty_list" ] || {
        [ "$3" = "d" ] && echo_chk_clrd 1 32 "OK - \"$1\" - \"$2\" directories/ no directories to manage"
        [ "$3" = "f" ] && echo_chk_clrd 1 32 "OK - \"$1\" - \"$2\" files / no files to manage"
    }
    echo

}

function check_cmake_public_file {
    cmake_public_file_prefix=$(git config -f "$scrip_config_file_path" --get-all fromtemplate.cmake_module.fileprefix)
    cmake_public_file_postfix=$(git config -f "$scrip_config_file_path" --get-all fromtemplate.cmake_module.filepostfix)
    cmake_public_ver=$(git config -f "$scrip_config_file_path" --get-all apps.$apps_name.cmakepublicver)
    eval "cmake_public_file_prefix=\"$cmake_public_file_prefix\""
    cmake_public_file="$cmake_public_file_prefix""$apps_name""$cmake_public_file_postfix"
    echo_chk_clrd 1 33 "cmake_public_file:    \"$cmake_public_file\""
    [ -f "$cmake_public_file" ] && {
        echo_chk_clrd 1 32 "OK - the cmake public file \"$cmake_public_file\" exists"
    } || {
        cmake_public_file_from="$cmake_public_file_prefix""$fromapp_name""$cmake_public_file_postfix"
        [ -f "$cmake_public_file_from" ] && {
            echo_chk_clrd 1 33 "OK - the cmake public file from template \"$cmake_public_file_from\" exists"
            copy_cmd="cp \"$cmake_public_file_from\" \"$cmake_public_file\""
            echo_chk_clrd 1 35 "$copy_cmd"
            eval "$copy_cmd"
        } || {
            echo_chk_clrd 1 31 "ERROR - the cmake public file \"$cmake_public_file_from\" does not exist"
        }
        
    }
}

set_array_param=()
param_num=$#
while (( $# ))
do
    set_array_param+=("$1")
    shift
done

[ $param_num -gt 0 ] && {
    param_parsing "${set_array_param[@]}"
    param_getting_clear 
    param_display_clear
} || {
    echo_chk_clrd 1 33 "help - below an example of possible parameters:"
    echo_chk_clrd 1 33 "help - $ new_app_from_old_app_ref.sh tst_20240317main tst_20240317app"
}


echo
echo "~~~~~"
echo
echo_chk_clrd 1 33 "main module - frommain directories"
check_rename_2 "main_module" "main_name" "d"

echo_chk_clrd 1 33 "main module - frommain files"
check_rename_2 "main_module" "main_name" "f"


echo "~~~~~"
echo
echo_chk_clrd 1 33 "main module - fromapp directories"
check_rename_2 "main_module" "apps_name" "d"

echo_chk_clrd 1 33 "main module - fromapp files"
check_rename_2 "main_module" "apps_name" "f"


echo "~~~~~"
echo
echo_chk_clrd 1 33 "apps module - frommain directories"
check_rename_2 "apps_module" "main_name" "d"

echo_chk_clrd 1 33 "apps module - frommain files"
check_rename_2 "apps_module" "main_name" "f"


echo "~~~~~"
echo
echo_chk_clrd 1 33 "apps module - fromapp directories"
check_rename_2 "apps_module" "apps_name" "d"

echo_chk_clrd 1 33 "apps module - fromapp files"
check_rename_2 "apps_module" "apps_name" "f"

echo "~~~~~"
echo

echo_chk_clrd 1 33 "Updating the content of files under \"main/mpfw_code_main_$main_name\" folder ..."
(
    cd main/mpfw_code_main_$main_name && { 
        echo_chk_clrd 1 33 "    -> replacing \"$frommain_name\" with \"$main_name\""
        while IFS= read -r item; do
            echo_chk_clrd 1 35 "modifing file $item - (main module) - from \"$frommain_name\" to \"$main_name\""
            sed -i '' "s/$frommain_name/$main_name/g" "$item"
        done < <(grep "$frommain_name" . -lr --binary-files=without-match --exclude-dir ./wsp/cmake/build_as_lib)
        grep "$frommain_name" . -lr --binary-files=without-match --exclude-dir ./wsp/cmake/build_as_lib || {
            echo_chk_clrd 1 32 "replacing procedure OK - no files have \"$frommain_name\" string"
        }
        echo_chk_clrd 1 33 "    -> replacing \"$fromapp_name\"  with \"$apps_name\""
        while IFS= read -r item; do
            echo_chk_clrd 1 35 "modifing file $item - (main module) - from \"$fromapp_name\" to \"$apps_name\""
            sed -i '' "s/$fromapp_name/$apps_name/g" "$item"
        done < <(grep "$fromapp_name" . -lr --binary-files=without-match --exclude-dir ./wsp/cmake/build_as_lib)
        grep "$fromapp_name" . -lr --binary-files=without-match --exclude-dir ./wsp/cmake/build_as_lib || {
            echo_chk_clrd 1 32 "replacing procedure OK - no files have \"$fromapp_name\" string"
        }
    }
)

echo
echo "~~~~~"
echo

echo_chk_clrd 1 33 "Updating the content of files under \"apps/mpfw_code_apps_$apps_name\" folder..."
(
    cd apps/mpfw_code_apps_$apps_name && { 
        echo_chk_clrd 1 33 "    -> replacing \"$frommain_name\" with \"$main_name\""
        while IFS= read -r item; do
            echo "modifing file $item - (app module) - from \"$frommain_name\" to \"$main_name\""
            sed -i '' "s/$frommain_name/$main_name/g" "$item"
        done < <(grep "$frommain_name" . -lr --binary-files=without-match )
        grep "$frommain_name" . -lr --binary-files=without-match || {
            echo_chk_clrd 1 32 "replacing procedure OK - no files have \"$frommain_name\" string"
        }
        echo_chk_clrd 1 33 "    -> replacing \"$fromapp_name\"  with \"$apps_name\""
        while IFS= read -r item; do
            echo "modifing file     $item - (app module) - from \"$fromapp_name\" to \"$apps_name\""
            sed -i '' "s/$fromapp_name/$apps_name/g" "$item"
        done < <(grep "$fromapp_name" . -lr --binary-files=without-match )
        grep "$fromapp_name" . -lr --binary-files=without-match || {
            echo_chk_clrd 1 32 "replacing procedure OK - no files have \"$fromapp_name\" string"
        }
    }
)

echo
