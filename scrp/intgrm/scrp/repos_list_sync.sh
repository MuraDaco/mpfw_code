#!/bin/bash

    current_script_dir=$(dirname "${BASH_SOURCE[0]}")
    main_script="${BASH_SOURCE[0]}"
    source $current_script_dir/func_echo.sh
    source $current_script_dir/func_help.sh
    source $current_script_dir/func_param_mng.sh

    current_dir=$PWD

    script_params="$@"

    [ -p /dev/stdin ] && {
        echo_clrd 1 32 "READING PIPE ..."
        while IFS= read item; do
            ((item_id++))
            ## echo "$item_id - $item"
            repos_list+=( "$item" )

        done
        true
    } || {
        developr_real_remote_repos_folder="/Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs"
        echo_clrd 1 33 "READING \"$developr_real_remote_repos_folder\" folder ... "
        [ -d "$developr_real_remote_repos_folder" ] && {
            while IFS= read -r item; do
                ((item_id++))
                ## echo "$item_id - $item"
                repos_list+=( "$item" )

            done < <(ls "$developr_real_remote_repos_folder" 2>/dev/null | grep "mpfw_code"; ls "$developr_real_remote_repos_folder" 2>/dev/null | grep "mpfw_fw2")
        } || {
            echo_clrd 1 31 "WARNING - the \"$developr_real_remote_repos_folder\" folder does not exist."
        }
    }

    parse_input_param $script_params
    help

    item_id=0
    for item in ${repos_list[@]}; do
        {
            [ $item_id -ge $range_dw ] &&
            [ $item_id -le $range_up ] 
        } && {
            echo_clrd_2 1 35 "$item_id: " 1 33 "$item"

            [ "$public_intgrm" = "local" ] && {
                worksation_intgrm_opt="--ws-intgrm test1"
                public_repo="$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_reale/remote/public/https/github/$item"
                public_protocol="file://"
            }
            [ "$public_intgrm" = "github" ] && {
                worksation_intgrm_opt="--ws-intgrm github"
                public_repo="github.com/MuraDaco/$item"
                public_protocol="https://"
            }
            public_repo_with_protocol="$public_protocol$public_repo"

            [ "$public_dvlpr" = "real" ] && {
                scenario_intgrm_opt="--scn-intgrm reale"
                developer_repo="/Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs/$item"
                developer_repo_with_protocol="file://$developer_repo"
            }

            {
                [ -d "$public_repo" ] &&
                [ -d "$developer_repo" ]
            } && {
                ## $current_script_dir/repos_sync.sh --publc "file://$public_repo" --dvlpr "file://$developer_repo" --rel-name First_Release --rel-null 1 3  --rel-inc 2
                echo_clrd 1 32 "PERFORMING synchro command about $item repository"
                perform_syncro="yes"
            } || {
                echo_clrd 1 32 "INFO - step 1"
                [ "$public_protocol" = "file://" ]   && {
                    echo_clrd 1 32 "INFO - step 1.1"
                    [ ! -d "$public_repo" ] && {
                        echo_clrd 1 32 "INFO - step 1.1.1"
                        echo_clrd 1 36 "WARNING - \"$public_repo\" repository (public repo) does not exist"
                        [ "$create_local_public_repos" = "yes" ] && {
                            echo_clrd 1 33 "CREATING \"$public_repo\" repository (public repo) ..."
                            mkdir "$public_repo" && {
                                cd "$public_repo" && {
                                    git init --bare && {
                                        perform_syncro="yes"
                                        repos_list_log_1[$item_id]="INFO - repo \"$item\": create repository"
                                    }
                                    cd $current_dir
                                }
                            }
                        }
                    }
                }
                [ "$public_protocol" = "https://" ]   && {
                    echo_clrd 1 32 "INFO - step 1.2"
                    echo_clrd 1 32 "PERFORMING synchro command about $item repository"
                    perform_syncro="yes"
                    repos_list_log_1[$item_id]="INFO - Connecting to \"$item\" repo"
                    echo_clrd 1 33 "${repos_list_log_1[$item_id]}"
                }
                true

                [ ! -d "$developer_repo" ]  && echo_clrd 1 36 "WARNING - \""$developer_repo"\" repository (developer repo) does not exist"
                true
            }

            [ "$perform_syncro" = "yes" ] && {
                perform_syncro="no"
                
                repos_list_log_2[$item_id]="./scrp/intgrm/scrp/repos_sync.sh $scenario_intgrm_opt $worksation_intgrm_opt --publc \"$public_repo_with_protocol\" --dvlpr \"$developer_repo_with_protocol\" --rel-name First_Release --rel-null 1 3  --rel-inc 2"
                repos_list_chk_1[$item_id]="./scrp/intgrm/scrp/repos_sync.sh $scenario_intgrm_opt $worksation_intgrm_opt --env-intgrm \"${item%.git}\" git:log"
                echo_clrd 1 35 "repos_list_log_2[$item_id]"
                ./scrp/intgrm/scrp/repos_sync.sh $scenario_intgrm_opt $worksation_intgrm_opt --publc "$public_repo_with_protocol" --dvlpr "$developer_repo_with_protocol" --rel-name First_Release --rel-null 1 3  --rel-inc 2
            }
            true

        }
        ((item_id++))
    done

    echo_clrd 1 33 "START "

    item_id=0
    log_file="$current_script_dir/repo_lists_log_$range_dw""_$range_up.txt"
    date > $log_file
    echo "---------------" >> $log_file
    for item in ${repos_list[@]}; do
        {
            [ $item_id -ge $range_dw ] &&
            [ $item_id -le $range_up ] 
        } && {
            echo_clrd 1 33 "$item_id - $item"
            echo_clrd 1 31 "    ${repos_list_log_1[$item_id]}"
            echo_clrd 1 35 "    ${repos_list_log_2[$item_id]}"
            echo_clrd 1 36 "    ${repos_list_chk_1[$item_id]}"
            echo "******************************************************************" >> $log_file
            echo "***                                                            ***" >> $log_file
            echo "$item_id - $item" >> $log_file
            echo "    ${repos_list_log_1[$item_id]}" >> $log_file
            echo "    ${repos_list_log_2[$item_id]}" >> $log_file
            echo "    ${repos_list_chk_1[$item_id]}" >> $log_file

            eval "${repos_list_chk_1[$item_id]}" >> $log_file

            echo "***                                                            ***" >> $log_file
            echo "******************************************************************" >> $log_file
        }
        ((item_id++))
    done

    display_global_variables_list

    exit 0 
