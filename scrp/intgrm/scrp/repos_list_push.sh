#!/bin/bash

    current_script_dir=$(dirname "${BASH_SOURCE[0]}")
    main_script="${BASH_SOURCE[0]}"
    source $current_script_dir/func_echo.sh
    source $current_script_dir/func_help.sh
    source $current_script_dir/func_param_mng.sh

    current_dir=$PWD

    script_params="$@"

    parse_input_param $script_params

    [ -p /dev/stdin ] && {
        echo_clrd 1 32 "READING PIPE ..."
        while IFS= read item; do
            ((item_id++))
            ## echo "$item_id - $item"
            repos_list+=( "$item" )

        done
        true
    } || {
        [ "$public_intgrm" = "local" ] && {
            integration_manager_working_folder="$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_reale/manager/intgrm_test3"
        }
        [ "$public_intgrm" = "github" ] && {
            integration_manager_working_folder="$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_reale/manager/intgrm_github"
        }

        ## integration_manager_working_folder="$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_reale/manager/intgrm_github"
        echo_clrd 1 33 "READING \"$integration_manager_working_folder\" folder ... "
        [ -d "$integration_manager_working_folder" ] && {
            while IFS= read -r item; do
                ((item_id++))
                echo "$item_id - $item"
                repos_list+=( "$item" )

            done < <(ls "$integration_manager_working_folder" 2>/dev/null | grep "mpfw_code" | sort; ls "$integration_manager_working_folder" 2>/dev/null | grep "mpfw_fw2" | sort)
        } || {
            echo_clrd 1 31 "WARNING - the \"$integration_manager_working_folder\" folder does not exist."
        }
    }


    item_id=0
    for item in ${repos_list[@]}; do
        {
            [ $item_id -ge $range_dw ] &&
            [ $item_id -le $range_up ] 
        } && {
            echo_clrd_2 1 35 "$item_id: " 1 33 "$item"
            cd "$integration_manager_working_folder/$item" && {
                git status
                git push github github_main:main
            }
        }
        true

        ((item_id++))
    done

    display_global_variables_list

    ## help
    exit 0
