#!/bin/bash

function echo_chk_clrd {
    echo -e "\033[$1;$2m""dbg msg - `basename $0` -> $3""\033[0;0m" > /dev/stderr
}

build_type=$1
[ "$build_type" ] && {
    [ "$build_type" == "dbg" ] || {
        echo_chk_clrd "ERROR - \"build type\" parameter, \"$build_type\", is wrong - do you mean \"dbg\"? "
        exit 1
    }
} || {
    build_type="rls"
}

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



while IFS= read -r item; do
    main_list+=("$item")
done < <(git config -f "$scrip_config_file_path" -l | grep "^main." | cut -d. -f2 | uniq)

for main in "${main_list[@]}";
do
    echo_chk_clrd 1 36 "$main"
    while IFS= read -r platform; do
        apps_name=$(git config -f "$scrip_config_file_path" --get main.$main.apps) && {
            echo_chk_clrd 1 33 "- $platform -> $build_type / apps -> $apps_name"
        } || {
            echo_chk_clrd 1 33 "- $platform -> $build_type"
        }
        build_total.sh $platform  $main $apps_name $build_type > /dev/null 2>&1 && {
            echo_chk_clrd 1 32 "OK"
        } || {
            build_total.sh $platform $main $apps_name $build_type
            exit 1
        }
    done < <(git config -f "$scrip_config_file_path" --get-all main.$main.check)
done

