#!/bin/bash

    current_script_dir=$(dirname "${BASH_SOURCE[0]}")
    main_script="${BASH_SOURCE[0]}"
    source $current_script_dir/func_echo.sh
    source $current_script_dir/func_help.sh
    source $current_script_dir/func_param_mng.sh

    current_dir=$PWD

    script_params="$@"
    parse_input_param $script_params
    help

    ## start - options & params analysis

    intgrm_scenario=$(echo "$public_intgrm" | cut -d' ' -f1)
    intgrm_scenario_root_dir=$(echo "$public_intgrm" | cut -d' ' -f2)
    intgrm_root_dir=$(echo "$public_intgrm" | cut -d' ' -f3)
    [ "test" = "$intgrm_scenario" ] && intgrm_remote_root_dir=$(echo "$public_intgrm" | cut -d' ' -f4)

    scenario_intgrm_opt="--scn-intgrm $intgrm_scenario_root_dir"
    worksation_intgrm_opt="--ws-intgrm $intgrm_root_dir"

    dvlpr_scenario=$(echo "$public_dvlpr" | cut -d' ' -f1)
    dvlpr_scenario_root_dir=$(echo "$public_dvlpr" | cut -d' ' -f2)
    [ "test" = "$dvlpr_scenario" ] && dvlpr_remote_root_dir=$(echo "$public_dvlpr" | cut -d' ' -f3)

    
    [ "test" = "$intgrm_scenario" ] && {
        public_protocol="file://"
        public_remote_repos_folder="$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_$intgrm_scenario_root_dir/remote/public/https/$intgrm_remote_root_dir"
        public_repo_with_protocol="$public_protocol$public_remote_repos_folder"
    } 
    [ "reale" = "$intgrm_scenario" ] && {
        public_protocol="https://"
        public_remote_repos_folder="github.com/MuraDaco"
        public_repo_with_protocol="$public_protocol$public_remote_repos_folder"
    }
    
    [ "test" = "$dvlpr_scenario" ] && {
        [ "reale" = "$intgrm_scenario" ] && {
            echo_clrd 1 31 "ERROR - intgrm_scenario = reale && dvlpr_scenario = test is not possible!"
            exit 1
        }
        dvlpr_remote_repo_protocol="file://"
        developer_remote_repos_folder="$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_$dvlpr_scenario_root_dir/remote/developer/$dvlpr_remote_root_dir"
        developer_repo_with_protocol="$dvlpr_remote_repo_protocol$developer_remote_repos_folder"
    }
    [ "reale" = "$dvlpr_scenario" ] && {
        dvlpr_remote_repo_protocol="file://"
        developer_remote_repos_folder="/Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs"
        developer_repo_with_protocol="$dvlpr_remote_repo_protocol$developer_remote_repos_folder"
    }

    [ -n "$command" ]  && {
        developer_remote_root_repos_to_read=$(./repos_sync.sh $scenario_intgrm_opt $worksation_intgrm_opt --env-intgrm cmd get_root | tail -1)
    } || {
        developer_remote_root_repos_to_read=$developer_remote_repos_folder
    }

    ## end - options & params analysis

    logs_folder=$(date +%Y%m%d)

    [ "test" = "$dvlpr_scenario" ] && {
        [ "test" = "$intgrm_scenario" ] && {
            logs_folder="/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/intmgr/logs/test/logs_$logs_folder"
        }
    }

    [ "reale" = "$dvlpr_scenario" ] && {
        [ "test" = "$intgrm_scenario" ] && {
            logs_folder="/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/intmgr/logs/reale/locale/logs_$logs_folder"
        }
    }

    [ "reale" = "$dvlpr_scenario" ] && {
        [ "reale" = "$intgrm_scenario" ] && {
            logs_folder="/Users/work/ObsiData/repo__main/smdl/repo__prjs/smdl/mpfw/code/mpfw_code/intmgr/logs/reale/github/logs_$logs_folder"
        }
    }

    [ -d "$logs_folder" ] && {
        echo_clrd 1 32 "INFO - the logs folder (\"$logs_folder\") exists."
    } || {
        echo_clrd 1 31 "ERROR - the logs folder (\"$logs_folder\") does not exist."
        exit 1
    }

    [ -p /dev/stdin ] && {
        echo_clrd 1 32 "READING PIPE ..."
        while IFS= read item; do
            ((item_id++))
            ## echo "$item_id - $item"
            repos_list+=( "$item" )

        done
        true
    } || {
        echo_clrd 1 33 "READING \"$developer_remote_root_repos_to_read\" folder ... "
        [ "reale" = "$dvlpr_scenario" ] && {

            [ -d "$developer_remote_root_repos_to_read" ] && {
                while IFS= read -r item; do
                    ((item_id++))
                    ## echo "$item_id - $item"
                    repos_list+=( "$item" )

                done < <(ls "$developer_remote_root_repos_to_read" 2>/dev/null | grep "mpfw_code"; ls "$developer_remote_root_repos_to_read" 2>/dev/null | grep "mpfw_fw2")
            } || {
                echo_clrd 1 31 "WARNING - the \"$developer_remote_root_repos_to_read\" folder does not exist. ($public_dvlpr)"
            }
        }

        [ "test" = "$dvlpr_scenario" ] && {

            [ -d "$developer_remote_root_repos_to_read" ] && {
                while IFS= read -r item; do
                    ((item_id++))
                    ## echo "$item_id - $item"
                    repos_list+=( "$item" )

                done < <(ls "$developer_remote_root_repos_to_read")
            } || {
                echo_clrd 1 31 "WARNING - the \"$developer_remote_root_repos_to_read\" folder does not exist. ($public_dvlpr)"
            }
        }

    }

    ## parse_input_param $script_params
    ## help

    item_id=0
    for item in ${repos_list[@]}; do
        {
            [ $item_id -ge $range_dw ] &&
            [ $item_id -le $range_up ] 
        } && {
            echo_clrd_2 1 35 "$item_id: " 1 33 "$item"

            [ -n "$command" ]  && {

                [ "push" = "$command" ]  && {
                    repos_list_chk_1[$item_id]="./repos_sync.sh $scenario_intgrm_opt $worksation_intgrm_opt --env-intgrm $item git:log"
                    repos_list_log_2[$item_id]="./repos_sync.sh $scenario_intgrm_opt $worksation_intgrm_opt --env-intgrm $item git:push"
                    echo_clrd 1 35 "repos_list_log_2[$item_id]:    ${repos_list_log_2[$item_id]}"
                    ./repos_sync.sh $scenario_intgrm_opt $worksation_intgrm_opt --env-intgrm $item git:push
                } 
                [ "log" = "$command" ]  && {
                    repos_list_chk_1[$item_id]="./repos_sync.sh $scenario_intgrm_opt $worksation_intgrm_opt --env-intgrm $item git:log"
                    repos_list_log_2[$item_id]="./repos_sync.sh $scenario_intgrm_opt $worksation_intgrm_opt --env-intgrm $item git:status"
                }
                true

            } || {


                public_repo="$public_remote_repos_folder/$item"
                developer_repo="$developer_remote_repos_folder/$item"

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

                    repos_list_chk_1[$item_id]="./repos_sync.sh $scenario_intgrm_opt $worksation_intgrm_opt --env-intgrm \"${item%.git}\" git:log"
                    repos_list_log_2[$item_id]="./repos_sync.sh $scenario_intgrm_opt $worksation_intgrm_opt --publc \"$public_repo_with_protocol/$item\" --dvlpr \"$developer_repo_with_protocol/$item\" --rel-name $release_name --rel-null $release_null  --rel-inc $release_inc"
                    echo_clrd 1 35 "repos_list_log_2[$item_id]:    ${repos_list_log_2[$item_id]}"
                    ./repos_sync.sh $scenario_intgrm_opt $worksation_intgrm_opt --publc "$public_repo_with_protocol/$item" --dvlpr "$developer_repo_with_protocol/$item" --rel-name $release_name --rel-null $release_null  --rel-inc $release_inc

                }
                true
            }
        }
        ((item_id++))
    done
    
    echo_clrd 1 33 "START LOG"


    item_id=0
    log_file="$logs_folder/repo_lists_log_$range_dw""_$range_up.txt"
    date > $log_file
    echo "---------------" >> $log_file
    echo "command: $command" >> $log_file
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
