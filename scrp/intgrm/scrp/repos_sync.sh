#!/bin/bash

    ## ${BASH_SOURCE[0]} --publc "file://$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/https/github.com/project_NEW_test_2.git" --dvlpr "file://$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/local/dvlpr1_pub_local1/project_NEW_test_2.git" --rel-name Neinth --rel-null 1 3  --rel-inc 2
    ## ${BASH_SOURCE[0]} --reset "file://$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/https/github.com/project_NEW_test_2.git" 
    
    ## ${BASH_SOURCE[0]} --publc "file://$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/public/https/github/Module_02.git" --dvlpr "file://$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/developer/mypass2_repo/Module_02.git" --rel-name First_Release --rel-null 1 3  --rel-inc 2

    current_script_dir=$(dirname "${BASH_SOURCE[0]}")
    source $current_script_dir/func_echo.sh

    ## while IFS= read -r item; do
    ##     array_line+=(
    ##         "$item"
    ##     )
    ##     [ -d "$item" ] && echo "$item is a directory"
    ##     [ -f "$item" ] && echo "$item is a file"
    ##     
    ## done < <( ls )

## # ********************************************************
## function step_10_git_branch_check {
##     echo_clrd 1 33 "Starting git branch check procedure ..."
##     echo_clrd 1 34 "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
##     echo_clrd 1 34 "step 0 - git status"
##     git status
##     branch_current=$(git symbolic-ref --short -q HEAD) && {
##         echo_clrd 1 32 "Current branch is: \"$branch_current\""
##     }
##     array_branches=()
##     while IFS= read -r item; do
##         array_branches+=(
##             "${item:2}"
##         )
##     done < <( git branch )
##     
##     for item in ${array_branches[@]}; do
##         echo_clrd 1 35 "$item"
##     done
## 
##     get_repo_nick_name  dvlpr
##     get_branch_name     dvlpr
## 
##     get_repo_nick_name  github
##     get_branch_name     github
## 
## }



# ********************************************************
# ********************************************************

function chk_repo_local   {

    sync_proc_step="SYNC_MKDIR"
    
    [ "$sync_proc_step" = "SYNC_MKDIR" ] && {
        ## check local repostitory existence
        [ -d "$path_repo_intgrm" ] && {
            echo_clrd 1 32 "\"$path_repo_intgrm\" folder already exists"
            sync_proc_step="SYNC_GIT_INIT"
            cd "$path_repo_intgrm"
        } || {
            echo_clrd 1 33 "INFO - \"$path_repo_intgrm\" folder does not exists and will be created & initialized"
        }
    }

    ## start sync procedure
    [ "$sync_proc_step" = "SYNC_GIT_INIT" ] && {
        ## check .git repository existence
        [ -d ".git" ] && {
            echo_clrd 1 33 "INFO - git repository is already initialized"
            sync_proc_step="SYNC_CHECK_MAIN_BRANCHES_INIT"
        } || {
            echo_clrd 1 33 "INFO - git repository is not initialized yet and will be initialized"
        }
    }

    [ "$sync_proc_step" = "SYNC_CHECK_MAIN_BRANCHES_INIT" ] && {
        local l_branch_current=$(git symbolic-ref --short -q HEAD)

        ## check "public main" branch existence
        [ "$l_branch_current" = "main" ] && {
            echo_clrd 1 33 "INFO - \"public & developer main\" branches are NOT initialized; there is still \"main\" branch"
        } || {
            echo_clrd 1 33 "INFO - \"public & developer main\" branches should be already initialized (current branch is different from 'main' branch) but to be secure about it another check step is necessary"
            sync_proc_step="SYNC_CHECK_CONFIG_REMOTE_REPOS"
        }
    }

    [ "$sync_proc_step" = "SYNC_CHECK_CONFIG_REMOTE_REPOS" ] && {
        sync_proc_step="SYNC_CHECK_CONFIG_REMOTE_REPO_publc"

        sync_chk_remote_repo publc
        sync_chk_branch_main publc
        [ "$sync_proc_step" = "SYNC_CHECK_BRANCH_publc_OK" ] && sync_proc_step="SYNC_CHECK_CONFIG_REMOTE_REPO_dvlpr"

        sync_chk_remote_repo dvlpr
        sync_chk_branch_main dvlpr
        [ "$sync_proc_step" = "SYNC_CHECK_BRANCH_dvlpr_OK" ] && sync_proc_step="SYNC_CHECK_END"

    }


}

## ************************************************************ ************************************************************
## ************************************************************ ************************************************************
## ************************************************************ ************************************************************
## ************************************************************ ************************************************************
## ************************************************************ ************************************************************
## ************************************************************ ************************************************************
## ************************************************************ ************************************************************
## ************************************************************ ************************************************************


# ********************************************************
function get_array_id {

    local item_id=0
    local result=-1
    for item in ${glovars_list[@]}; do
        ## echo_clrd 1 35 "$item_id -> $item"
        [ "${glovars_list[$item_id]}" = "$1" ] && result=$item_id || true
        ((item_id++))
    done
    echo "$result"
}

function glovars_upd    {
    local par_name_id=$(get_array_id "$1")
    [ $par_name_id -eq -1 ] && {
        glovars_list+=( "$1" )
        par_name_id=$(get_array_id "$1")
    }
    local par_name=$1
    ## glovars[$par_name_id]="$protocol_repo_dvlpr"
    [ -z "$2" ] && {
        ## update
        eval "glovars[$par_name_id]=\$$par_name"
    } || {
        ## init
        glovars[$par_name_id]="$2"
        eval "$par_name=\"${glovars[$par_name_id]}\""
    }
}

function glovars_upd_v2    {
    local par_name=$1
    [ -z "$2" ] && {
        ## update
        eval "glovars[$par_name]=\$$par_name"
    } || {
        ## init
        glovars[$par_name]="$2"
        eval "$par_name=\"${glovars[$par_name]}\""
    }
}

function glovars_display    {

    local item_id=0
    for item in ${glovars_list[@]}; do
        echo_clrd_2 1 35 "$item: " 1 33 "${glovars[$item_id]}"
        ((item_id++))
    done

}

function glovars_display_v2    {

    local item_id=0
    for item in ${glovars_list[@]}; do
        echo_clrd_2 1 35 "$item: " 1 33 "${glovars[$item_id]}"
        ((item_id++))
    done

}



function init_script_params {
    parse_input_param   $script_params

    step_result=0
    [ -n "$repo_to_reset" ]         && step_result=1
    [ -n "$g_test_var" ]            && step_result=2
    [ -n "$env_intgrm" ]            && step_result=3
    [ -n "$env_dvlpr" ]             && step_result=4
    [ -n "$env_dvlpr_remote" ]      && step_result=5
    [ -n "$env_publc_remote" ]      && step_result=6
    [ -n "$g_help" ]                && step_result=7

    [ $step_result -eq 0 ] && {
        [ -z "$script_params" ] && { help; exit 0; }
    }

    input_param_default
    chk_input_params
    get_project_name

    echo_clrd 1 33 "get_input_params ... step_result: $step_result"

}


function parse_input_param  {

    echo_clrd 1 33 "get_input_params ..."
    echo_clrd 1 34 "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    local l_par_string=
    glovars=()
    for par_item
    do

        ## echo "par_item: $par_item - first character ${par_item:0:1}"
        [ "${par_item:0:2}" = "--" ] && {
            param_type=$par_item
            l_par_string=
            case "$param_type" in
                ("--help")
                    par_name="g_help"
                    glovars_upd "$par_name" "yes"
                    ;;
                ("--test-var")
                    par_name="g_test_var"
                    glovars_upd "$par_name" "default_value"
                    ;;
                ("--reset")
                    par_name="repo_to_reset"
                    glovars_upd "$par_name" "default_value"
                    ;;
            esac
            true
        } || {
            [ -n "$param_type" ] && {
                case "$param_type" in
                    ("--scn-intgrm")
                        par_name="scenario_intgrm"
                        [ -z "$l_par_string" ] && l_par_string="$par_item" || l_par_string="$l_par_string"" $par_item"
                        glovars_upd "$par_name" "$l_par_string"
                        ;;
                    ("--ws-intgrm")
                        par_name="workstation_intgrm"
                        [ -z "$l_par_string" ] && l_par_string="$par_item" || l_par_string="$l_par_string"" $par_item"
                        glovars_upd "$par_name" "$l_par_string"
                        ;;
                    ("--env-intgrm")
                        par_name="env_intgrm"
                        [ -z "$l_par_string" ] && l_par_string="$par_item" || l_par_string="$l_par_string"" $par_item"
                        glovars_upd "$par_name" "$l_par_string"
                        ;;
                    ("--env-dvlpr")
                        par_name="env_dvlpr"
                        [ -z "$l_par_string" ] && l_par_string="$par_item" || l_par_string="$l_par_string"" $par_item"
                        glovars_upd "$par_name" "$l_par_string"
                        ;;
                    ("--env-dvlpr-remote")
                        par_name="env_dvlpr_remote"
                        [ -z "$l_par_string" ] && l_par_string="$par_item" || l_par_string="$l_par_string"" $par_item"
                        glovars_upd "$par_name" "$l_par_string"
                        ;;
                    ("--env-publc-remote")
                        par_name="env_publc_remote"
                        [ -z "$l_par_string" ] && l_par_string="$par_item" || l_par_string="$l_par_string"" $par_item"
                        glovars_upd "$par_name" "$l_par_string"
                        ;;
                    ("--test-var")
                        par_name="g_test_var"
                        [ -z "$l_par_string" ] && l_par_string="$par_item" || l_par_string="$l_par_string"" $par_item"
                        glovars_upd "$par_name" "$l_par_string"
                        ;;
                    ("--reset")
                        par_name="repo_to_reset"
                        glovars_upd "$par_name" "$par_item"
                        ;;
                    ("--dvlpr" | "--publc")
                        par_name="repo_${param_type:2}"
                        glovars_upd "$par_name" "$par_item"
                        ;;
                    ("--rel-name")
                        par_name="release_name"
                        [ -z "$l_par_string" ] && l_par_string="$par_item" || l_par_string="$l_par_string""_$par_item"
                        ## [ "${l_par_string:0:1}" = " " ] && l_par_string=${l_par_string:1}
                        local par_item_replace_space=${l_par_string// /_}
                        glovars_upd "$par_name" "$par_item_replace_space"
                        ;;
                    ("--rel-inc")
                        par_name="release_inc_field_$par_item"
                        glovars_upd "$par_name" "yes"
                        ;;
                    ("--rel-null")
                        par_name="release_null_field_$par_item"
                        glovars_upd "$par_name" "yes"
                        ;;
                esac
            }
        }


    done

}

function input_param_default    {

    ## ----------------------------
    rel_f_1_default="0"
    rel_f_2_default="0"
    rel_f_3_default="0"
    rel_f_4_default="[1234567]"
    ## ----------------------------
    repo_publc_nick_name_default="github"
    repo_dvlpr_nick_name_default="dvlpr1_local1"
    ## ----------------------------
    scenario_intgrm_default="1"
    workstation_intgrm_default="ws2"
    [ -z "$scenario_intgrm" ]       && scenario_intgrm="scenario_$scenario_intgrm_default"      || scenario_intgrm="scenario_$scenario_intgrm"
    [ -z "$workstation_intgrm" ]    && workstation_intgrm="intgrm_$workstation_intgrm_default"  || workstation_intgrm="intgrm_$workstation_intgrm"
    ## ----------------------------
    branch_publc_name_default="$repo_publc_nick_name_default""_main"
    branch_dvlpr_name_default="$repo_dvlpr_nick_name_default""_main"

}

function chk_input_params   {

    echo_clrd 1 33 "chk_input_params ..."
    echo_clrd 1 34 "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

    [ $step_result -eq 0 ] && {

        ## "dvlpr" repository check
        protocol_repo_dvlpr=${repo_dvlpr%%://*}
        path_repo_dvlpr=${repo_dvlpr#*://}
        [ -d "$path_repo_dvlpr" ] && {
            echo_clrd 1 33 "INFO - Protocol about \"DVLPR\" repo is $protocol_repo_dvlpr"
            echo_clrd 1 33 "INFO - \"DVLPR\" repository exists."
        } || {
            echo_clrd 1 31 "ERROR - \"Developer\" repository \"$path_repo_dvlpr\" does not exist - sync procedure is aborted."
            exit 1
        }

        ## "github" repository check
        protocol_repo_publc=${repo_publc%%://*}
        path_repo_publc=${repo_publc#*://}
        case "$protocol_repo_publc" in
            ("file")
                echo_clrd 1 33 "INFO - Protocol about \"github\" repo is file"
                [ -d "$path_repo_publc" ] && echo_clrd 1 33 "INFO - \"GITHUB\" repository exists." && {
                    echo_clrd 1 33 "INFO - \"PUBLC\" repository exists."
                } || {
                    echo_clrd 1 33 "INFO - \"Public/github\" repository \"$path_repo_publc\" does not exist."

                    echo_clrd 1 33 "INFO - creating $path_repo_publc folder/'remote repository'"
                    mkdir "$path_repo_publc" && {
                        ( cd "$path_repo_publc" && git init --bare )
                    }
                }
            ;;
            ("https")
                echo_clrd 1 33 "INFO - Protocol about \"public\" repo is https"
            ;;
            (*)
                echo_clrd 1 31 "ERROR - Protocol about \"public\" repo (\"$protocol_repo_publc\") is UNKNOWN"
                exit 1
            ;;
        esac

        path_repo_intgrm_root_folder_default="$HOME/ObsiData/distributed_git/integration_manager_workflow/$scenario_intgrm/manager/$workstation_intgrm"
        [ -d "$path_repo_intgrm_root_folder_default" ] && {
            echo_clrd 1 32 "INFO - \"Integration Manager workstation\" folder exists."
        } || {
            echo_clrd 1 31 "ERROR - \"Integration Manager workstation\" ($path_repo_intgrm_root_folder_default) folder DOES NOT exist."
            exit 1
        }
    }

    glovars_upd "protocol_repo_dvlpr"
    glovars_upd "path_repo_dvlpr"
    glovars_upd "protocol_repo_publc"
    glovars_upd "path_repo_publc"
    glovars_upd "scenario_intgrm"
    glovars_upd "workstation_intgrm"
    glovars_upd "path_repo_intgrm_root_folder_default"

}


function get_project_name   {
    [ $step_result -eq 0 ] && {

        ## draw out project name
        module_name=${path_repo_dvlpr##*/}
        module_name=${module_name%.git}
        module_name_chk=${path_repo_publc##*/}
        module_name_chk=${module_name_chk%.git}

        [ "$module_name" = "$module_name_chk" ] && {
            echo_clrd 1 32 "INFO - \"developer\" and \"public\" module names match and it is \"$module_name\"" 
        } || {
            echo_clrd 1 33 "WARNING - \"developer\" and \"public\" module names do not match"
        }
    }

}


function chk_mkdir    {
    ## check local repostitory existence
    path_repo_intgrm_root_folder=$path_repo_intgrm_root_folder_default
    path_repo_intgrm="$path_repo_intgrm_root_folder/$module_name"
    [ -d "$path_repo_intgrm" ] && {
        echo_clrd 1 32 "INFO - \"$path_repo_intgrm\" folder already exists"
        cd "$path_repo_intgrm"
        step_result=1
    } || {
        echo_clrd 1 33 "INFO - \"$path_repo_intgrm\" folder does not exists and will be created & initialized"
        step_result=0
    }
}

function set_mkdir    {
    ## create project folder
    mkdir $path_repo_intgrm && {
        cd $path_repo_intgrm
        step_result=0
        echo_clrd 1 32 "INFO - \"$path_repo_intgrm\" folder has been just created"
    }
}


function chk_git_init 
{
    ## check .git repository existence
    [ -d ".git" ] && {
        echo_clrd 1 32 "INFO - git repository is already initialized"
        step_result=1
    } || {
        echo_clrd 1 33 "INFO - git repository is not initialized yet and will be initialized"
        step_result=0
    }

}

function set_git_init 
{
    ## initialize git repository
    module_name_chk=$(basename $PWD)
    [ "$module_name_chk" = "$module_name" ] && {
        git init
        git status
        echo_clrd 1 32 "INFO - git repository has been just initialized"
        step_result=0
    } || {
        echo_clrd 1 31 "ERROR - Current folder \"$PWD\" is wrong ... exit 1"
        exit 1
    }
}

function chk_config_main_branches {
    ## check "public main" branch existence
    local l_cmd_ls=$(ls)
    [ -z "$l_cmd_ls" ] && {
        echo_clrd 1 33 "INFO - the current folder is EMPTY: there is not any project file"
    } || {
        echo_clrd 1 33 "INFO - the curent local repository is NOT empty, there are already some files"
    }
    local l_branch_current=$(git symbolic-ref --short -q HEAD)
    [ "$l_branch_current" = "main" ] && {
        echo_clrd 1 33 "INFO - \"public & developer main\" branches are NOT initialized; there is still \"main\" branch"
    } || {
        local chk_log=$(git log --all)
        [ -z "$chk_log" ] && {
            echo_clrd 1 33 "INFO - \"public & developer main\" branches should be already initialized. No commit is present."
        } || {
            echo_clrd 1 31 "INFO - the current repo has already some commits. These commits may be local and/or remote, for an info more precise another check step is necessary"
            echo_clrd 1 33 "INFO - the current branch is different from 'main' branch therefore \"public & developer main\" branches should be already initialized but to be secure about it another check step is necessary"
        }
    }
    step_result=0

}

# ********************************************************
function get_repo_nick_name    {

    eval "local repo_xxx=\$repo_$1"

    local repo_xxx_nick_name=$(git config -l | grep "^remote\." | grep "\.url=$repo_xxx" ) 
    [ -n "$repo_xxx_nick_name" ] && {
        repo_xxx_nick_name=${repo_xxx_nick_name%%\.url=$repo_xxx}
        repo_xxx_nick_name=${repo_xxx_nick_name#remote\.}

        echo_clrd 1 32 "INFO - \"$1\" remote repo is configured (repo_$1_nick_name: $repo_xxx_nick_name)"
        glovars_upd "repo_$1_nick_name" $repo_xxx_nick_name
        step_result=0
    } || {
        echo_clrd 1 31 "INFO - \"$1\" remote repo is NOT configured yet"
        step_result=1
    }
}

function chk_config_remote_repo_publc   {
    get_repo_nick_name publc
}

function set_config_remote_repo {

    ## ## add remote repo
    eval "local l_repo_xxx_nick_name_default=\$repo_$1_nick_name_default"
    eval "local l_repo_xxx=\$repo_$1"
    glovars_upd "repo_$1_nick_name" "$l_repo_xxx_nick_name_default"
    echo_clrd 1 31 "INFO - Configuring \"$1\" remote repo ..."
    local l_option=
    [ "$1" = "dvlpr" ] && {
        local l_option="-t main"
    }
    git remote add $l_option $l_repo_xxx_nick_name_default "$l_repo_xxx" && {
        echo_clrd 1 31 "INFO - The 'git remote add $l_option $l_repo_xxx_nick_name_default \"$l_repo_xxx\"' command has just been performed."
    } || {
        echo_clrd 1 31 "ERROR - The 'git remote add $l_option $l_repo_xxx_nick_name_default \"$l_repo_xxx\"' command FAILED."
        display_global_variables_list
        exit 1
    }

    step_result=0

}

function set_config_remote_repo_publc {

    ## ## add remote repo
    set_config_remote_repo publc

}

function chk_status_remote_repo_publc   {

    git fetch $repo_publc_nick_name && {
    ## git fetch $repo_publc_nick_name main && {

        local fetch_result=$(git show-branch --sha1-name $repo_publc_nick_name/main | wc -l) && {
            [ $fetch_result -eq 0 ] && {
                echo_clrd 1 33 "INFO - the remote repo is new and so empty"
            } || {
                echo_clrd 1 33 "INFO - the remote repo has already some commits"
            }
            glovars_upd "repo_remote_status_publc" "$fetch_result"
            step_result=0
        } || {
            echo_clrd 1 33 "ERROR - the  'git show-branch --sha1-name $repo_publc_nick_name/main | wc -l' command failed"
            exit 1
        }
    } || {
        echo_clrd 1 33 "ERROR - the  'git fetch $repo_publc_nick_name' command failed"
        exit 1
    }

}


function chk_status_remote_repo   {

    eval "local l_repo_xxx_nick_name=\$repo_$1_nick_name"
    git fetch $l_repo_xxx_nick_name main && {
        local fetch_result=$(git show-branch --sha1-name $l_repo_xxx_nick_name/main | wc -l) && {
            [ $fetch_result -eq 0 ] && {
                echo_clrd 1 33 "INFO - the '$1' remote repo is new and so empty"
            } || {
                echo_clrd 1 33 "INFO - the '$1' remote repo has already some commits"
            }
            glovars_upd "repo_remote_status_$1" "$fetch_result"
            step_result=0
        } || {
            echo_clrd 1 33 "ERROR - the  \"git show-branch --sha1-name $l_repo_xxx_nick_name/main | wc -l\" command failed"
            exit 1
        }
    } || {
        echo_clrd 1 33 "ERROR - the  \"git fetch $l_repo_xxx_nick_name\" command failed"
        exit 1
    }

}


function    get_branch_name
{

    eval "local repo_xxx_nick_name=\$repo_$1_nick_name"
    local branch_xxx_name
    branch_xxx_name=$(git config -l | grep "^branch\." | grep "\.remote=$repo_xxx_nick_name" )
    branch_xxx_name=${branch_xxx_name%%\.remote=$repo_xxx_nick_name}
    branch_xxx_name=${branch_xxx_name#branch\.}

    glovars_upd "branch_$1_name" $branch_xxx_name

}

function chk_config_main_branch   {

    get_branch_name $1
    eval "local branch_xxx_name=\$branch_$1_name"
    ## check tracking status between "$1 main" branches (local & remote) 
    [ -z "$branch_xxx_name" ] && {
        ## LOCAL_TRACK_NO
        echo_clrd 1 33 "INFO - \"$1 main\" branch is NOT correctly initialized; there is not any correspondence with its \"$1\" remote repo config"
        ## set default main_branch
        eval "local branch_xxx_name=\$branch_$1_name_default"
        branch_current=$(git symbolic-ref --short -q HEAD) && {
            echo_clrd 1 32 "Current branch is: \"$branch_current\""
        }

        ## check local "$1 main" branch commits
        git checkout "$branch_xxx_name" 2> /dev/null && {
            ## LOCAL_COMMIT_OK
            echo_clrd 1 33 "INFO - default \"$1 main\" branch was already created and has some commit but the tracking to its \"$1\" remote branch has to be performed yet"
            step_result=0
            glovars_upd "branch_$1_name" "$branch_xxx_name"
        } || {
            ## LOCAL_COMMIT_NO

            ## ## check local "$1 main" branch existence
            local branch_current=$(git symbolic-ref --short -q HEAD) && {
                [ "$branch_xxx_name" = "$branch_current" ] && {
                    ## LOCAL_EXIST
                    echo_clrd 1 33 "INFO - default '$1 main' branch was already created but does not have any commits yet"
                    step_result=1
                } || {
                    ## LOCAL_NO_EXIST
                    echo_clrd 1 33 "INFO - Current branch is '$branch_current' but does not match with the default '$1 main' one; the '$1 main' branch will be create with default name, that is '$branch_xxx_name'"
                    step_result=2
                }
            } || {
                echo_clrd 1 31 "ERROR - the following git command failed -> \"git symbolic-ref --short -q HEAD\" "
                exit 1
            }
            glovars_upd "branch_$1_name" "$branch_xxx_name"

        }
    } || {
        ## LOCAL_TRACK_OK
        echo_clrd 1 33 "INFO - \"$1 main\" branch is correctly initialized (branch_$1_name: $branch_xxx_name); the tracking to its remote branch is already configured"
        step_result=3
    }

}

function chk_config_main_branch_publc   {

    chk_config_main_branch publc

}

function create_main_branch_publc   {
    git checkout -b $branch_publc_name
    git status
    step_result=0
}

function create_main_branch   {
    eval "git checkout -b \$branch_$1_name"
    git status
    step_result=0
}

function get_commits   {
    [ $repo_remote_status_publc -eq 0 ] && {
        ## REMOTE_COMMIT_NO
        echo_clrd 1 33 "INFO - the remote repo is new and so empty; an empty commit has to be performed and after the 'merge --squash' command from 'dvlpr main' branch too"
        step_result=0
    } || {
        ## REMOTE_COMMIT_OK
        echo_clrd 1 33 "INFO - the remote repo has already some commits, it is not empty; the current local branch does not have any commits therefore a merge command has to be performed with its publc remote branch"
        step_result=1
    }
}

function perform_empty_commit  {
    git log  >/dev/null 2>&1 && {
        echo_clrd 1 31 "DEVELOPER ERROR - there is a BUG: the local current branch has already some commits therefore the current procedure must not be performed"
        exit 1
    } || {
        echo_clrd 1 33 "INFO - creating empty commit"
        git commit --allow-empty -m "Empty commit"
        step_result=0
    }
}

function get_commits_by_fetch_publc  {
    git merge "$repo_publc_nick_name/main" && {
        echo_clrd 1 33 "INFO - setting up the tracking between local & remote branches"
        git branch --set-upstream-to=$repo_publc_nick_name/main $branch_publc_name
        git status
        step_result=0
    } || {
        echo_clrd 1 33 "ERROR - 'git merge \"$repo_publc_nick_name/main\"' command failed"
        exit 1
    }
}

function get_commits_by_fetch  {
    eval "local l_repo_xxx_nick_name=\$repo_$1_nick_name"
    eval "local l_branch_xxx_name=\$branch_$1_name"
    git fetch $l_repo_xxx_nick_name main:$l_branch_xxx_name && {
        echo_clrd 1 33 "INFO - setting up the tracking between local & remote branches"
        git branch --set-upstream-to=$l_repo_xxx_nick_name/main $l_branch_xxx_name
        git status
        step_result=0
    } || {
        echo_clrd 1 33 "ERROR - 'git merge \"$l_repo_xxx_nick_name/main\"' command failed"
        exit 1
    }
}

function set_remote_branch_tracking_publc  {
    [ $repo_remote_status_publc -eq 0 ] && {
        ## REMOTE_COMMIT_NO
        step_result=0
    } || {
        ## REMOTE_COMMIT_OK
        git branch --set-upstream-to=$repo_publc_nick_name/main $branch_publc_name
        step_result=1
    }

}

function set_remote_branch_tracking  {
    eval "local l_repo_xxx_nick_name=\$repo_$1_nick_name"
    eval "local l_repo_remote_status_xxx=\$repo_remote_status_$1"
    [ $l_repo_remote_status_xxx -eq 0 ] && {
        ## REMOTE_COMMIT_NO
        [ "$1" = "dvlpr" ] && echo_clrd 1 31 "ERROR - '$l_repo_xxx_nick_name/main' remote branch has not any commits"
        step_result=0
    } || {
        ## REMOTE_COMMIT_OK
        git branch --set-upstream-to=$l_repo_xxx_nick_name/main $l_branch_xxx_name
        step_result=1
    }

}

function push_set_upstream_to_remote_repo    {
    git push --set-upstream $repo_publc_nick_name $branch_publc_name:main
    step_result=0
}

function chk_config_remote_repo_dvlpr   {
    get_repo_nick_name dvlpr
}

function set_config_remote_repo_dvlpr   {
    ## ## add remote repo
    set_config_remote_repo dvlpr
}

function chk_status_remote_repo_dvlpr   {
    chk_status_remote_repo dvlpr
}

function chk_config_main_branch_dvlpr   {
    chk_config_main_branch dvlpr
}

function create_main_branch_dvlpr {
    create_main_branch dvlpr
}

function get_commits_by_fetch_dvlpr {
    get_commits_by_fetch dvlpr
}

function set_remote_branch_tracking_dvlpr    {
    set_remote_branch_tracking dvlpr
}

# ********************************************************
# ********************************************************
## ## SYNCRONIZATION SECTION
# ********************************************************
# ********************************************************
function chk_branch_sync {

    [ -z "$2" ] && {
        ## check sync among local & remote repositories

        eval "local l_branch_xxx_name=\$branch_$1_name"
        local l_branch_xxx_local_commit=$(git show-branch --sha1-name $l_branch_xxx_name | cut -d' ' -f1)
        glovars_upd "branch_$1_commit" $l_branch_xxx_local_commit


        eval "local l_repo_xxx_nick_name=\$repo_$1_nick_name"
        git fetch $l_repo_xxx_nick_name && {
            echo_clrd 1 32 "OK - Succesful fetching [$1] remote branch"
        } || {
            echo_clrd 1 33 "WARNING - Some issues in fetching ($l_repo_xxx_nick_name $l_branch_xxx_name:main) remote branch"
        }

        local l_branch_xxx_remote_name="$l_repo_xxx_nick_name/main"
        local l_branch_xxx_remote_commit=$(git show-branch --sha1-name $l_branch_xxx_remote_name | cut -d' ' -f1)
        glovars_upd "branch_$1_remote_commit" $l_branch_xxx_remote_commit

        local l_branch_xxx_sync_status=
        [ "$l_branch_xxx_local_commit" = "$l_branch_xxx_remote_commit" ] &&    {
            echo_clrd 1 32 "Local & Remote repos about \"$1\" are sync"
            l_branch_xxx_sync_status="OK"
            step_result=0
        } || {
            echo_clrd 1 35 "Local ($l_branch_xxx_local_commit) & Remote ($l_branch_xxx_remote_commit) repos branches about \"$1\" are NOT synchronized"
            l_branch_xxx_sync_status="NO_SYNC"
            step_result=1
        }
        glovars_upd "branch_$1_sync_status" $l_branch_xxx_sync_status
    } || {
        ## check sync among developer [dvlpr] & integration manager [github](intgrm)

        eval "local l_branch_xxx_1_name=\$branch_$1_name"
        eval "local l_branch_xxx_2_name=\$branch_$2_name"

        local l_diff_result=$(git diff $l_branch_xxx_1_name $l_branch_xxx_2_name)

        local l_branch_local_sync_status=
        [ -z "$l_diff_result" ]  && {
            echo_clrd 1 32 "OK - developer & integration manager local repositories are sync"
            l_branch_local_sync_status="OK"
            step_result=0
        } || {
            echo_clrd 1 35 "WARNING !!! - developer & integration manager local repositories differ"
            l_branch_local_sync_status="NO_SYNC"
            step_result=0
        }
        glovars_upd "branch_local_sync_status" $l_branch_local_sync_status
    }


}

function chk_branch_new_update {

    branch_new_update_status="NO_EXIST"
    while IFS= read -r item; do
        local l_branch_name=${item:2}
        [ "$l_branch_name" = "new_update" ] && {
            branch_new_update_status="EXISTS"
        }
    done < <( git branch )

    glovars_upd "branch_new_update_status" "$branch_new_update_status"

    [ "$branch_new_update_status" = "EXISTS" ] && {
        local l_branch_xxx_commit=$(git show-branch --sha1-name new_update | cut -d' ' -f1)
        glovars_upd "branch_new_update_commit" $l_branch_xxx_commit

        branch_new_update_sync_status="NO_SYNC"
        [ "$branch_new_update_commit" = "$branch_publc_commit" ] && {
            [ -z "$(ls)" ] && {
                branch_new_update_sync_status="EMPTY_COMMIT"
            } || {
                branch_new_update_sync_status="OK"
            }
        } || {
            local l_branch_new_update_parent_commit=$(git show-branch --sha1-name new_update^ | cut -d' ' -f1)
            [ "$l_branch_new_update_parent_commit" = "$branch_publc_commit" ] && {
                echo_clrd 1 33 "\"l_branch_new_update_parent_commit\" ($l_branch_new_update_parent_commit) matches \"branch_publc_commit\" ($branch_publc_commit)"
                [ -z "$(ls)" ] && {
                    branch_new_update_sync_status="EMPTY_DIR"
                } || {
                    [ "$branch_new_update_sync_status" = "EMPTY_COMMIT" ] && {
                        branch_new_update_sync_status="SYNC_WITH_DVLPR_BRANCH"
                    } || {
                        branch_new_update_sync_status="SYNC_WITH_DVLPR_BRANCH"
                    }
                }

            } || {
                echo_clrd 1 33 "\"l_branch_new_update_parent_commit\" ($l_branch_new_update_parent_commit) does NOT match \"branch_publc_commit\" ($branch_publc_commit)"
                local l_branch_new_update_grandparent_commit=$(git show-branch --sha1-name new_update^^ | cut -d' ' -f1)
                local l_diff_result
                [ "$l_branch_new_update_grandparent_commit" = "$branch_publc_commit" ] && {
                    l_diff_result=$(git diff new_update $branch_dvlpr_name)
                    [ -z "$l_diff_result" ] && {
                        branch_new_update_sync_status="SYNC_WITH_DVLPR_BRANCH"
                    } || {
                        branch_new_update_sync_status="OLD_TO_DELETE"
                    }
                } || {
                    l_diff_result=$(git diff new_update $branch_publc_name)
                    [ -z "$l_diff_result" ] && {
                        branch_new_update_sync_status="SYNC_WITH_GITHUB_BRANCH_AFTER_MERGE_SQUASH"
                    } || {
                        branch_new_update_sync_status="UNKNOWN_2"
                    }
                }
            }
        }
        glovars_upd "branch_new_update_sync_status" "$branch_new_update_sync_status"
    }
}

function chk_branch_sync_dvlpr  {
    chk_branch_sync dvlpr
    ## step_result=0
}

function chk_branch_sync_publc  {
    chk_branch_sync publc
    ## step_result=0
}

function chk_branch_sync_new_update  {
    chk_branch_new_update
    step_result=0
}

function chk_branch_sync_locals  {
    chk_branch_sync dvlpr publc
    ## step_result=0
}

function chk_branch_sync_status {
    echo_clrd 1 34 "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo_clrd 1 33 "Starting check branches sync status procedure ..."
    echo_clrd 1 34 "~~~~~~~~"

    chk_branch_sync dvlpr
    chk_branch_sync publc
    chk_branch_new_update
    chk_branch_sync dvlpr publc

    [ "$l_branch_local_sync_status" = "NO_SYNC" ] && step_result=0 || step_result=1
    

}

# ********************************************************
function sync_branch_dvlpr { 
    sync_dvlpr_branch
    step_result=0
}

function sync_dvlpr_branch {
    echo_clrd 1 34 "|^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^|"
    echo_clrd 1 33 "Starting git [dvlpr] (local & remote) branches synchronization procedure ..."
    echo_clrd 1 34 "|~~~~~"

    [ "$branch_dvlpr_sync_status" = "NO_SYNC" ] && {
        ## git checkout $branch_dvlpr_name && git pull $repo_dvlpr_nick_name main:$branch_dvlpr_name
        git checkout $branch_dvlpr_name && git pull
    }

    ## update [dvlpr] branch status
    chk_branch_sync dvlpr
}

function get_github_version_numbers {
    local l_default_release=0
    for((id=1;id<5;id++)); do
        local release_field
        eval "release_field=$(git show-branch --sha1-name $branch_publc_name | cut -d' ' -f5 | cut -d'.' -f$id)"
        ## eval "local release_field=\$rel_f_$id"
        ## [ $id -eq 2 ] && release_field="xxx"
        glovars_upd "rel_f_$id" "$release_field"
        [ $id -eq 4 ] && {
            ## echo_clrd 1 31 "${rel_f_4:0:1}--${rel_f_4:8}--"
            {
                [ "${rel_f_4:0:1}" = "[" ] && [ "${rel_f_4:8}" = "]" ] 
            } && {
                ## test_hex_number ${rel_f_4:1:7} && echo_clrd 1 31 "commit ref OK" || echo_clrd 1 31 "commit ref WRONG"
                test_hex_number ${rel_f_4:1:7} || l_default_release=1
                true
            } || {
                ## echo_clrd 1 31 "commit ref WRONG (it has not square parenthesis)"
                l_default_release=1
            }
        } || {
            ## test_number $release_field && echo_clrd 1 31 "commit ref OK" || echo_clrd 1 31 "commit ref WRONG"
            test_number $release_field || l_default_release=1
        }
    done

    [ $l_default_release -eq 1 ] && {
        for((id=1;id<5;id++)); do
            eval "local l_release_field=\$rel_f_$id""_default"
            ## eval "local l_release_field=\$rel_f_$id"
            glovars_upd "rel_f_$id" "$l_release_field"
        done
    }

}

function set_github_version_numbers {
    for((id=1;id<4;id++)); do
        eval "local release_inc_field=\$release_inc_field_$id"
        eval "local release_null_field=\$release_null_field_$id"
        eval "local release_field=\$rel_f_$id"
        [ -n "$release_inc_field" ] && {
            ((release_field++))
        }
        [ -n "$release_null_field" ] && {
            release_field=0
        }
        glovars_upd "rel_f_$id" "$release_field"
    done
}

function sync_new_update_with_dvlpr {
    sync_github_branch_step_1
    step_result=0
}

function sync_github_branch_step_1 {
    echo_clrd 1 34 "|^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^|"
    echo_clrd 1 33 "Starting step 1 of git local ([github] & [dvlpr]) branches synchronization procedure ..."
    echo_clrd 1 33 "\"new_update\" & \"$branch_dvlpr_name\" branches synchronization procedure ..."
    echo_clrd 1 34 "|~~~~~"

    get_github_version_numbers
    set_github_version_numbers
    commit_message="$release_name release ver. $rel_f_1.$rel_f_2.$rel_f_3.$branch_dvlpr_commit"
    glovars_upd "commit_message" "$commit_message"

    [ "$branch_local_sync_status" = "NO_SYNC" ] && {

        ## step 1
        ## removing  "new_update" branch
        [ "$branch_new_update_sync_status" = SYNC_WITH_GITHUB_BRANCH_AFTER_MERGE_SQUASH ]   &&  {
            ## remove "new_update" branch
            git checkout $branch_publc_name && {
                git branch -D new_update && {
                    echo_clrd 1 33 "INFO - OK - \"new_up_date\" branch has been removed correctly."
                } || {
                    echo_clrd 1 33 "ERROR - some issues in removing \"new_up_date\" branch ..."
                }

                ## update "new_update" branch status
                chk_branch_new_update
            }
        }

        ## step 2
        ## create "new_update" branch from [github] (that is "github_main") branch
        [ "$branch_new_update_status" = "NO_EXIST" ] && {
            echo_clrd 1 33 "creating \"new_up_date\" branch ..."
            git checkout $branch_publc_name && {
                git branch new_update && chk_branch_new_update
            }
            ## update "new_update" branch status
            chk_branch_new_update
        }

        ## step 3
        ## empty "new_update" branch
        [ "$branch_new_update_sync_status" = "OK" ] && {
            ## empty new_update branch & commit
            git checkout new_update && {

                ## remove standard files & folders
                while IFS= read -r item; do
                    [ -f "$item" ] && {
                        echo "\"$item\" is a file"
                        rm "$item"
                    }

                    [ -d "$item" ] && {
                        echo "\"$item\" is a folder"
                        rm -rf "$item"
                    }
                done < <( ls )

                ## remove hidden files
                rm .gitignore
                rm .gitmodules

                ## start commit proecedure 
                git add .
                git commit -m "Empty branch"

                ## update "branch_new_update_sync_status"
                chk_branch_new_update
            } 
        }

        ## step 4
        ## sync (merge --squash) "new_update" branch with [dvlpr] branch
        [ "$branch_dvlpr_sync_status" = "OK" ] && {
            {
                [ "$branch_new_update_sync_status" = "EMPTY_DIR" ] ||
                [ "$branch_new_update_sync_status" = "EMPTY_COMMIT" ] 
            } && {
                git checkout new_update && {
                    ## git merge --squash --allow-unrelated-histories $repo_dvlpr_nick_name/main
                    git merge --squash --allow-unrelated-histories $branch_dvlpr_name && {
                        git add .
                        git commit -m "$commit_message"

                        ## update "branch_new_update_sync_status"
                        chk_branch_new_update
                    }
                }
            }
        }
    }
}

function sync_publc_with_new_update {
    sync_github_branch_step_2
    step_result=0
}


function sync_github_branch_step_2 {
    [ "$branch_local_sync_status" = "NO_SYNC" ] && {
        echo_clrd 1 34 "|^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^|"
        echo_clrd 1 33 "Starting step 2 of git local ([github] & [dvlpr]) branches synchronization procedure ..."
        echo_clrd 1 33 "\"$branch_publc_name\" & \"$branch_dvlpr_name\" branches synchronization procedure ..."
        echo_clrd 1 34 "|~~~~~"
        [ "$branch_new_update_sync_status" = "SYNC_WITH_DVLPR_BRANCH" ] && {
            git checkout $branch_publc_name && {
                git merge --squash new_update && {
                    git add .
                    git commit -m "$commit_message"
                }
            }
        }
    }
}

function exit_with_error    {
    step_result=0
}

function display_global_variables_list {
    echo_clrd 1 34 "|^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^|"
    echo_clrd 1 33 "Global variables summary ..."
    echo_clrd 1 34 "|~~~~~"

    glovars_display
    step_result=0

}

function config_end   {
    step_result=0

}


function test_number    {
    [ "$1" -eq "$1" ] 2>/dev/null
}

function test_hex_number    {
    local l_check_par=$1
    [ ! "${l_check_par:0:2}" = "0x" ] && l_check_par="0x$1"
    local l_test_hex_num
    ((l_test_hex_num=$l_check_par)) 2>/dev/null
    [ "$l_test_hex_num" -eq "$l_test_hex_num" ] 2>/dev/null
}

function test_func {

    parse_input_param   $script_params

    local l_string="$g_test_var"
    [ -z "$l_string" ] && l_string="djdhcnb jhdh.djfdjh.dfhdfj.[kdfdjk]"
    local l_test_var=$(echo "$l_string" | cut -d' ' -f2 | cut -d'.' -f2)
    echo "l_string: $l_string"
    echo "l_test_var: $l_test_var"

    [ "$l_test_var" -eq "$l_test_var" ] 2>/dev/null && echo_clrd 1 32 "OK - 'l_test_var' is a number" || echo_clrd 1 31 "ER - 'l_test_var' is NOT a number"

    test_number "$l_test_var" && echo_clrd 1 32 "OK - 'l_test_var' is a number" || echo_clrd 1 31 "ER - 'l_test_var' is NOT a number"
    local l_test_hex_num_0=0x1f85617
    local l_test_hex_num
    ((l_test_hex_num=$l_test_hex_num_0)) 2>/dev/null
    ## local l_test_hex_num=$l_test_hex_num_0
    ## ((l_test_hex_num=l_test_hex_num + 0))

    test_number     "$l_test_hex_num" && echo_clrd 1 32     "OK - 'l_test_hex_num: $l_test_hex_num' is a hexadecimal number"        || echo_clrd 1 31 "ER - 'l_test_hex_num: $l_test_hex_num' is NOT a hexadecimal number"
    test_hex_number "$l_test_var" && echo_clrd 1 32         "OK - 'l_test_var: $l_test_var' is a hexadecimal number"                || echo_clrd 1 31 "ER - 'l_test_var: $l_test_var' is NOT a hexadecimal number"
    test_hex_number "$l_test_hex_num_0" && echo_clrd 1 32   "OK - 'l_test_hex_num_0: $l_test_hex_num_0' is a hexadecimal number"    || echo_clrd 1 31 "ER - 'l_test_hex_num_0: $l_test_hex_num_0' is NOT a hexadecimal number"


    exit 0

 }
 
function reset_repo {

    [ -n "$repo_to_reset" ] &&  {

        protocol_repo_to_reset=${repo_to_reset%%://*}
        path_repo_to_reset=${repo_to_reset#*://}
        [ -d "$path_repo_to_reset" ] && {
            echo_clrd 1 33 "INFO - Protocol about repo to reset is \"$protocol_repo_to_reset\""
            echo_clrd 1 33 "INFO - repo to reset exists."
            echo "$path_repo_to_reset" | grep "$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/https/github.com/" > /dev/null 2>&1 && {
                [ "${repo_to_reset##*.}" = "git" ] && {
                    repo_to_reset_name=$(basename "$path_repo_to_reset")
                    echo_clrd 1 33 "INFO - the \"$repo_to_reset_name\" repo  will be reset (remove & re-initialize)."
                    echo zzz_rm -rf "$repo_to_reset"
                }
            }
        } || {
            echo_clrd 1 31 "ERROR - repo to reset does not exist"
            exit 1
        }
    }
    step_result=0
    exit 0

}

function env_public_remote  {
    echo_clrd 1 32 "Start - environment of public remote configuration (--env-publc-remote) "
    echo_clrd 1 31 "environment of public params: $env_publc_remote"

    root_folder_path_dvlpr=$(echo "$env_publc_remote" | cut -d' ' -f1)
    project_name=$(echo "$env_publc_remote" | cut -d' ' -f2)
    env_publc_cmd=$(echo "$env_publc_remote" | cut -d' ' -f3)
    env_publc_cmd_param_1=$(echo "$env_publc_cmd" | cut -d':' -f1)
    ## create local repository
    local l_root_remote_repos_folder="$HOME/ObsiData/distributed_git/integration_manager_workflow/$scenario_intgrm/remote/public/https/$root_folder_path_dvlpr"
    local l_repo_to_create="$l_root_remote_repos_folder/$project_name.git"
    echo "$l_repo_to_create" | grep "$l_root_remote_repos_folder/" >/dev/null && {

        [ -d "$l_root_remote_repos_folder" ] && {
            echo_clrd 1 33 "INFO - root folder of remote repos existS - l_root_remote_repos_folder: $l_root_remote_repos_folder"
            [ -n "$project_name" ] && {
                [ -d "$l_repo_to_create" ] && {
                    echo_clrd 1 33 "INFO - $l_repo_to_create folder/'remote repository' already exist"
                    cd "$l_repo_to_create"
                } || {
                    echo_clrd 1 33 "INFO - creating $l_repo_to_create folder/'remote repository'"
                    mkdir "$l_repo_to_create" && {
                        cd "$l_repo_to_create" && git init --bare
                    }
                }
            }
        } || {
            echo_clrd 1 31 "ERROR - root folder of remote repos DOES NOT exist - l_root_remote_repos_folder: $l_root_remote_repos_folder"
            exit 1
        }

        ## echo_clrd 1 33 "INFO - env_publc_cmd: $env_publc_cmd - env_publc_cmd_param_1: $env_publc_cmd_param_1"
        [ "$env_publc_cmd_param_1" = "remove_repo" ] && {
            cd ..
            echo_clrd 1 33 "INFO - current folder is $PWD"
            env_publc_cmd_param_2=$(echo "$env_publc_cmd" | cut -d':' -f2)
            echo_clrd 1 33 "INFO - performing rm -rf '$l_repo_to_create' folder"
            [ "$env_publc_cmd_param_2" = "ok" ] && {
                rm -rf "$l_repo_to_create"
                echo_clrd 1 31 "INFO - rm -rf '$l_repo_to_create' command has just been performed"
            }
        }

        true

    } || {
        echo_clrd 1 31 "ERROR - root_folder_path_dvlpr: $root_folder_path_dvlpr is a wrong PATH"
        exit 1
    }

}

function env_developer_remote  {
    echo_clrd 1 32 "Start - environment of developer remote configuration (--env-dvlpr-remote) "
    echo_clrd 1 31 "environment of developer params: $env_dvlpr_remote"

    root_folder_path_dvlpr=$(echo "$env_dvlpr_remote" | cut -d' ' -f1)
    project_name=$(echo "$env_dvlpr_remote" | cut -d' ' -f2)
    env_dvlpr_cmd=$(echo "$env_dvlpr_remote" | cut -d' ' -f3)
    env_dvlpr_cmd_param_1=$(echo "$env_dvlpr_cmd" | cut -d':' -f1)
    ## create local repository
    local l_root_remote_repos_folder="$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/developer/$root_folder_path_dvlpr"
    local l_repo_to_create="$l_root_remote_repos_folder/$project_name.git"
    echo "$l_repo_to_create" | grep "$l_root_remote_repos_folder/" >/dev/null && {

        [ -d "$l_root_remote_repos_folder" ] && {
            echo_clrd 1 33 "INFO - root folder of remote repos existS - l_root_remote_repos_folder: $l_root_remote_repos_folder"
            [ -n "$project_name" ] && {
                [ -d "$l_repo_to_create" ] && {
                    echo_clrd 1 33 "INFO - $l_repo_to_create folder/'remote repository' already exist"
                    cd "$l_repo_to_create"
                } || {
                    echo_clrd 1 33 "INFO - creating $l_repo_to_create folder/'remote repository'"
                    mkdir "$l_repo_to_create" && {
                        cd "$l_repo_to_create" && git init --bare
                    }
                }
            }
        } || {
            echo_clrd 1 31 "ERROR - root folder of remote repos DOES NOT exist - l_root_remote_repos_folder: $l_root_remote_repos_folder"
            exit 1
        }

        [ "$env_dvlpr_cmd" = "remove_repo" ] && {
            cd ..
            echo_clrd 1 33 "INFO - current folder is $PWD"
            echo_clrd 1 33 "INFO - performing rm -rf '$l_repo_to_create' folder"
            ## rm -rf "$l_repo_to_create"
        }

        true

    } || {
        echo_clrd 1 31 "ERROR - root_folder_path_dvlpr: $root_folder_path_dvlpr is a wrong PATH"
        exit 1
    }

}

function env_integration_manager  {
    echo_clrd 1 32 "Start - environment of integration manager configuration (--env-intgrm) "
    echo_clrd 1 31 "environment of integration manager params: $env_intgrm"

    first_param=$(echo "$env_intgrm" | cut -d' ' -f1)
    env_intgrm_cmd=$(echo "$env_intgrm" | cut -d' ' -f2)
    
    [ "cmd" = "$first_param" ] &&   {
        [ "get_root" = "$env_intgrm_cmd" ]  &&  {
            echo "$HOME/ObsiData/distributed_git/integration_manager_workflow/$scenario_intgrm/manager/$workstation_intgrm"
        }
        true
    } || {
        project_name="$first_param"

        env_intgrm_cmd_param_1=$(echo "$env_intgrm_cmd" | cut -d':' -f1)
        ## create local repository
        local l_repo_to_create="$HOME/ObsiData/distributed_git/integration_manager_workflow/$scenario_intgrm/manager/$workstation_intgrm/$project_name"

        [ -n "$project_name" ] && {
            [ -d "$l_repo_to_create" ] && {
                echo_clrd 1 32 "INFO - $l_repo_to_create folder already exist"
                cd "$l_repo_to_create"
            } || {
                echo_clrd 1 31 "INFO - $l_repo_to_create folder DOES NOT exist"
                exit 1
            }
        }

        ## check .git folder existence
        [ "$PWD" = "$l_repo_to_create" ] && {
            [ -d ".git" ] && {
                echo_clrd 1 32 "INFO - git repository is already initialized"
            } || {
                echo_clrd 1 31 "INFO - git repository has to be initialized yet"
            }
        }

        [ "$env_intgrm_cmd_param_1" = "git" ] && {
            env_intgrm_cmd_param_2=$(echo "$env_intgrm_cmd" | cut -d':' -f2)
            [ "$env_intgrm_cmd_param_2" = "status" ] && {
                echo_clrd 1 33 "INFO - performing 'git status' command"
                git status
            }
            [ "$env_intgrm_cmd_param_2" = "log" ] && {
                echo_clrd 1 33 "INFO - performing 'git log' command"
                git logpretty
            }
            [ "$env_intgrm_cmd_param_2" = "remote" ] && {
                env_intgrm_cmd_param_3=$(echo "$env_intgrm_cmd" | cut -d':' -f3)
                [ -z "$env_intgrm_cmd_param_3" ] && {
                    echo_clrd 1 33 "INFO - performing 'git remote' command"
                    git remote
                } || {
                    echo_clrd 1 33 "INFO - performing 'git remote show \"$env_intgrm_cmd_param_3\"' command"
                    git remote show "$env_intgrm_cmd_param_3"
                }
            }

            [ "$env_intgrm_cmd_param_2" = "push" ] && {
                env_intgrm_cmd_param_3=$(echo "$env_intgrm_cmd" | cut -d':' -f3)
                [ -z "$env_intgrm_cmd_param_3" ] && {
                    echo_clrd 1 33 "INFO - performing 'git push github github_main:main' command"
                    git push github github_main:main
                    true
                } || {
                    [ "$env_intgrm_cmd_param_3" = "set-upstream" ] && {
                        env_intgrm_cmd_param_4=$(echo "$env_intgrm_cmd" | cut -d':' -f4)
                        [ -z "$env_intgrm_cmd_param_4" ] && {
                            echo_clrd 1 33 "INFO - performing 'git push --set-upstream github github_main' command"
                            git push --set-upstream github github_main:main
                        }
                    }
                    true
                }
            }
        }
    }
    exit 0

}

function env_developer  {
    echo_clrd 1 32 "Start - environment of developer configuration (--env-dvlpr) "
    echo_clrd 1 31 "environment of developer params: $env_dvlpr"

    root_folder_path_dvlpr=$(echo "$env_dvlpr" | cut -d' ' -f1)
    project_name=$(echo "$env_dvlpr" | cut -d' ' -f2)
    env_dvlpr_cmd=$(echo "$env_dvlpr" | cut -d' ' -f3)
    env_dvlpr_cmd_param_1=$(echo "$env_dvlpr_cmd" | cut -d':' -f1)
    ## create local repository
    local l_repo_to_create="$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/developers/$root_folder_path_dvlpr/$project_name"
    echo "$l_repo_to_create" | grep "$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/developers/" && {

        [ -n "$project_name" ] && {
            [ -d "$l_repo_to_create" ] && {
                echo_clrd 1 33 "INFO - $l_repo_to_create folder already exist"
                cd "$l_repo_to_create"
            } || {
                echo_clrd 1 33 "INFO - creating $l_repo_to_create folder"
                mkdir "$l_repo_to_create" && {
                    cd "$l_repo_to_create" && git init
                }
            }
        }

        ## check .git folder existence
        [ "$PWD" = "$l_repo_to_create" ] && {
            [ -d ".git" ] && {
                echo_clrd 1 33 "INFO - git repository is already initialized"

            } || {
                echo_clrd 1 33 "INFO - performing 'git init' in $l_repo_to_create folder"
                git init
            }
        } || {
            echo_clrd 1 31 "ERROR - current folder  ($PWD) is wrong; the right folder is '$l_repo_to_create'"
            exit 1
        }

        ## check command
        [ "$env_dvlpr_cmd_param_1" = "remote_config" ] && {
            echo_clrd 1 33 "INFO - configuring remote repository ..."
            env_dvlpr_cmd_param_2=$(echo "$env_dvlpr_cmd" | cut -d':' -f2)
            echo_clrd 1 33 "INFO - env_dvlpr_cmd_param_2: $env_dvlpr_cmd_param_2"
            [ "$env_dvlpr_cmd_param_2" = "public" ] && {
                env_dvlpr_cmd_param_3=$(echo "$env_dvlpr_cmd" | cut -d':' -f3)
                echo_clrd 1 33 "INFO - env_dvlpr_cmd_param_3: $env_dvlpr_cmd_param_3"
                [ -n "$env_dvlpr_cmd_param_3" ] && {
                    [ "$env_dvlpr_cmd_param_3" = "remove" ] && {
                        echo_clrd 1 33 "performing 'git remote remove https_public_repo' command"
                        git remote remove https_public_repo
                        true
                    } || {
                        local l_remote_repo_path="$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/public/https/$env_dvlpr_cmd_param_3/$project_name.git"
                        [ -d "$l_remote_repo_path" ] && {
                            echo_clrd 1 32 "INFO -  remote repo folder exists"
                            echo "performing 'git remote add https_public_repo \"file://$l_remote_repo_path\"' command"
                            git remote add https_public_repo "file://$l_remote_repo_path"
                            true
                        } || {
                            echo_clrd 1 31 "INFO - public https remote repo folder DOES NOT exist (l_remote_repo_path: $l_remote_repo_path)"
                        }
                    }
                }
            } || {
                [ -n "$env_dvlpr_cmd_param_2" ] && {
                    [ "$env_dvlpr_cmd_param_2" = "remove" ] && {
                        echo_clrd 1 33 "performing 'git remote remove my_public_repo' command"
                        git remote remove my_public_repo
                    } || {

                        local l_remote_repo_path="$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/developer/$env_dvlpr_cmd_param_2/$project_name.git"
                        [ -d "$l_remote_repo_path" ] && {
                            echo_clrd 1 32 "INFO -  remote repo folder exists"
                            echo "performing 'git remote add my_public_repo \"file://$l_remote_repo_path\"' command"
                            git remote add my_public_repo "file://$l_remote_repo_path"
                            true
                        } || {
                            echo_clrd 1 31 "INFO -  remote repo folder DOES NOT exist (l_remote_repo_path: $l_remote_repo_path)"
                        }
                    }
                }
            }
        }

        [ "$env_dvlpr_cmd_param_1" = "git" ] && {
            env_dvlpr_cmd_param_2=$(echo "$env_dvlpr_cmd" | cut -d':' -f2)
            [ "$env_dvlpr_cmd_param_2" = "status" ] && {
                echo_clrd 1 33 "INFO - performing 'git status' command"
                git status
            }
            [ "$env_dvlpr_cmd_param_2" = "add" ] && {
                echo_clrd 1 33 "INFO - performing 'git add' command"
                git add .
            }
            [ "$env_dvlpr_cmd_param_2" = "log" ] && {
                echo_clrd 1 33 "INFO - performing 'git log' command"
                git logpretty
            }
            [ "$env_dvlpr_cmd_param_2" = "remote" ] && {
                echo_clrd 1 33 "INFO - performing 'git remote' command"
                git remote
            }
            [ "$env_dvlpr_cmd_param_2" = "commit" ] && {
                env_dvlpr_cmd_param_3=$(echo "$env_dvlpr_cmd" | cut -d':' -f3)
                echo_clrd 1 33 "INFO - performing 'git commit' command"
                [ -n "$env_dvlpr_cmd_param_3" ] && {
                    git add .
                    git commit -m "$env_dvlpr_cmd_param_3"
                } || {
                    git add .
                    git commit -m "Standard message"
                }
            }
            [ "$env_dvlpr_cmd_param_2" = "fetch" ] && {
                env_dvlpr_cmd_param_3=$(echo "$env_dvlpr_cmd" | cut -d':' -f3)
                [ -z "$env_dvlpr_cmd_param_3" ] && {
                    echo_clrd 1 33 "INFO - performing 'git fetch' command"
                    git fetch
                } || {
                    [ "$env_dvlpr_cmd_param_3" = "public" ] && {
                        echo_clrd 1 33 "INFO - performing 'git fetch https_public_repo main' command"
                        git fetch https_public_repo main
                    }
                }
            }

            [ "$env_dvlpr_cmd_param_2" = "push" ] && {
                env_dvlpr_cmd_param_3=$(echo "$env_dvlpr_cmd" | cut -d':' -f3)
                [ -z "$env_dvlpr_cmd_param_3" ] && {
                    echo_clrd 1 33 "INFO - performing 'git push' command"
                    git push
                } || {
                    [ "$env_dvlpr_cmd_param_3" = "set-upstream" ] && {
                        env_dvlpr_cmd_param_4=$(echo "$env_dvlpr_cmd" | cut -d':' -f4)
                        [ -z "$env_dvlpr_cmd_param_4" ] && {
                            echo_clrd 1 33 "INFO - performing 'git push --set-upstream my_public_repo main' command"
                            git push --set-upstream my_public_repo main
                        } || {
                            [ "$env_dvlpr_cmd_param_4" = "public" ] && {
                                echo_clrd 1 33 "INFO - performing 'git push --set-upstream https_public_repo main' command"
                                git push --set-upstream https_public_repo main
                            }
                        }
                    }
                    [ "$env_dvlpr_cmd_param_3" = "public" ] && {
                        echo_clrd 1 33 "INFO - performing 'git push https_public_repo main' command"
                        git push https_public_repo main
                    }
                }
            }
        }

        [ "$env_dvlpr_cmd" = "remote_push" ] && {
            echo_clrd 1 33 "INFO - performing 'git push' command"
            ## git push --set-upstream my_public_repo main
        }

        [ "$env_dvlpr_cmd" = "new_files" ] && {
            echo_clrd 1 33 "INFO - creating new files & committing them"
            echo "up - prima riga" > file_up.txt
            echo "down - prima riga" > file_dw.txt
            { cat file_up.txt; cat file_dw.txt; } > file_ud.txt
            ## echo_clrd 1 33 "INFO - performing 'git add .' command"
            ## git add .
            ## echo_clrd 1 33 "INFO - performing 'git commit -m ...' command"
            ## git commit -m "Standard message"
            ## echo_clrd 1 33 "INFO - performing 'git push' command"
            ## git push --set-upstream my_public_repo
        }

        [ "$env_dvlpr_cmd_param_1" = "upd_files" ] && {
            echo_clrd 1 33 "INFO - updating new files & committing them"
            date >> file_up.txt
            date | cut -d' ' -f2-6 >> file_dw.txt
            { cat file_up.txt; date | cut -d' ' -f1; cat file_dw.txt; } > file_ud.txt
            env_dvlpr_cmd_param_2=$(echo "$env_dvlpr_cmd" | cut -d':' -f2)
            [ "$env_dvlpr_cmd_param_2" = "commit" ] && {
                env_dvlpr_cmd_param_3=$(echo "$env_dvlpr_cmd" | cut -d':' -f3)
                [ -n "$env_dvlpr_cmd_param_3" ] && {
                    [ "$env_dvlpr_cmd_param_3" = "push" ] && {
                        echo_clrd 1 33 "INFO - performing 'git commit -m \"Standard message\"' comand"
                        git add .
                        git commit -m "Standard message"
                        echo_clrd 1 33 "INFO - performing 'git push' command"
                        git push
                        true
                    } || {
                        echo_clrd 1 33 "INFO - performing 'git commit -m \"$env_dvlpr_cmd_param_3\"' command"
                        git add .
                        git commit -m "$env_dvlpr_cmd_param_3"
                        env_dvlpr_cmd_param_4=$(echo "$env_dvlpr_cmd" | cut -d':' -f4)
                        [ "$env_dvlpr_cmd_param_4" = "push" ] && {
                            echo_clrd 1 33 "INFO - performing 'git push' command"
                            git push
                        }
                        true
                    }
                } || {
                    echo_clrd 1 33 "INFO - performing 'git commit -m \"Standard message\"' comand"
                    git add .
                    git commit -m "Standard message"
                    true
                }
            }
        }

        [ "$env_dvlpr_cmd" = "reset_repo" ] && {
            echo_clrd 1 33 "INFO - performing reset repository"
        }

        [ "$env_dvlpr_cmd" = "remove_repo" ] && {
            cd ..
            echo_clrd 1 33 "INFO - current folder is $PWD"
            echo_clrd 1 33 "INFO - performing rm -rf '$l_repo_to_create' folder"
            ## rm -rf "$l_repo_to_create"
        }
        true
    } || {
        echo_clrd 1 31 "ERROR - root_folder_path_dvlpr: $root_folder_path_dvlpr is a wrong PATH"
        exit 1
    }

    exit 0
}

function env_public  {
    echo_clrd 1 32 "Start - environment of public configuration (--env-publc) "
    echo_clrd 1 31 "environment of public params: $env_publc"
    exit 0

}

function help   {

    echo_clrd 1 32 "HELP"
    echo_clrd 1 32 "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo_clrd 1 32 "- Test Environment"
    echo_clrd 1 33 "    --env-publc-remote"
    echo_clrd 1 33 "        ${BASH_SOURCE[0]} --env-publc-remote <root folder of repos> <project/module name>"
    echo_clrd 1 35 "            $ ${BASH_SOURCE[0]} --env-publc-remote \"github\" \"Module_02\""
    echo_clrd 1 33 "    --env-dvlpr-remote"
    echo_clrd 1 33 "        ${BASH_SOURCE[0]} --env-dvlpr-remote <root folder of repos> <project/module name>"
    echo_clrd 1 35 "            $ ${BASH_SOURCE[0]} --env-dvlpr-remote \"mypass2_repo\" \"Module_02\""
    echo_clrd 1 33 "    --env-dvlpr"
    echo_clrd 1 33 "        ${BASH_SOURCE[0]} --env-dvlpr <root folder of repos> <project/module name> <command>"
    echo_clrd 1 35 "            $ ${BASH_SOURCE[0]} --env-dvlpr \"dvlpr1_ws1\" \"Module_02\" <command>"
    echo_clrd 1 33 "        ~~~~~~~~~~~~~~~~~~~~~~"
    echo_clrd 1 33 "        <command> description:"
    echo_clrd 1 33 "        ~~~~~~~~~~~~~~~~~~~~~~"
    echo_clrd 1 33 "        - remote_config"
    echo_clrd 1 33 "            - remote_config:<root folder of remote repos>"
    echo_clrd 1 35 "                $ ${BASH_SOURCE[0]} --env-dvlpr \"dvlpr1_ws1\" \"Module_02\" remote_config:mypass2_repo"
    echo_clrd 1 34 "                $ git remote add my_public_repo \"file://<remote_repo_path>\""
    echo_clrd 1 33 "            - remote_config:remove"
    echo_clrd 1 35 "                $ ${BASH_SOURCE[0]} --env-dvlpr \"dvlpr1_ws1\" \"Module_02\" remote_config:remove"
    echo_clrd 1 34 "                $ git remote remove my_public_repo"
    echo_clrd 1 33 "            - remote_config:public:<root folder of remote repos>"
    echo_clrd 1 35 "                $ ${BASH_SOURCE[0]} --env-dvlpr \"dvlpr1_ws2\" \"Module_02\" remote_config:public:github"
    echo_clrd 1 34 "                $ git remote add https_public_repo \"file://<remote_repo_path>\""
    echo_clrd 1 33 "            - remote_config:public:remove"
    echo_clrd 1 35 "                $ ${BASH_SOURCE[0]} --env-dvlpr \"dvlpr1_ws2\" \"Module_02\" remote_config:public:remove"
    echo_clrd 1 34 "                $ git remote add https_public_repo"
    echo_clrd 1 33 "        - git"
    echo_clrd 1 33 "            - git:status"
    echo_clrd 1 34 "                $ git status"
    echo_clrd 1 33 "            - git:add"
    echo_clrd 1 34 "                $ git add ."
    echo_clrd 1 33 "            - git:log"
    echo_clrd 1 34 "                $ git logpretty"
    echo_clrd 1 33 "            - git:remote"
    echo_clrd 1 34 "                $ git remote"
    echo_clrd 1 33 "            - git:commit"
    echo_clrd 1 34 "                $ git add ."
    echo_clrd 1 34 "                $ git commit -m \"Standard message\""
    echo_clrd 1 33 "                - commit:<commit message>"
    echo_clrd 1 34 "                    $ git add ."
    echo_clrd 1 34 "                    $ git commit -m \"<commit message>\""
    echo_clrd 1 33 "            - git:push"
    echo_clrd 1 34 "                $ git push"
    echo_clrd 1 33 "                - push:set-upstream"
    echo_clrd 1 34 "                    $ git push --set-upstream my_public_repo main"
    echo_clrd 1 33 "                    - push:set-upstream:public"
    echo_clrd 1 34 "                        $ git push --set-upstream https_public_repo main"
    echo_clrd 1 33 "                - push:public"
    echo_clrd 1 34 "                    $ git push https_public_repo main"
    echo_clrd 1 33 "        - upd_files"
    echo_clrd 1 33 "            - upd_files:commit"
    echo_clrd 1 34 "                $ git add ."
    echo_clrd 1 34 "                $ git commit -m \"Standard message\""
    echo_clrd 1 33 "            - upd_files:commit:<commit message>"
    echo_clrd 1 34 "                $ git add ."
    echo_clrd 1 34 "                $ git commit -m \"<commit message>\""
    echo_clrd 1 33 "            - upd_files:commit:push"
    echo_clrd 1 34 "                $ git add ."
    echo_clrd 1 34 "                $ git commit -m \"Standard message\""
    echo_clrd 1 34 "                $ git push"
    echo_clrd 1 33 "            - upd_files:commit:<commit message>:push"
    echo_clrd 1 34 "                $ git add ."
    echo_clrd 1 34 "                $ git commit -m \"<commit message>\""
    echo_clrd 1 34 "                $ git push"
    echo_clrd 1 32 "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo_clrd 1 32 "- Integration Manager commands: synchronization & check commands"
    echo_clrd 1 33 "    - synchro and check commands & their common options"
    echo_clrd 1 33 "        - --scn-intgrm <integration scenario name>"
    echo_clrd 1 33 "        - --ws-intgrm <integration manager workstation name>"
    echo_clrd 1 33 "        - --ws-intgrm <integration manager name>"
    echo_clrd 1 33 "    - synchro commands & its options"
    echo_clrd 1 33 "        - ${BASH_SOURCE[0]} --publc \"<url public repository>\" --dvlpr \"<url public developer repository>\" --rel-name <release name> --rel-null [<release field position> ...] --rel-inc [<release field position> ...]"
    echo_clrd 1 33 "            - \"Test scenario\" example"
    echo_clrd 1 35 "                - ${BASH_SOURCE[0]} --publc \"file://$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/public/https/github/Module_02.git\" --dvlpr \"file://$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/developer/mypass2_repo/Module_02.git\" --rel-name First_Release --rel-null 1 3  --rel-inc 2"
    echo_clrd 1 33 "            - \"Real scenario\" example"
    echo_clrd 1 35 "                - ${BASH_SOURCE[0]} --publc \"file://$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/public/https/github/Module_02.git\" --dvlpr \"file://$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/developer/mypass2_repo/Module_02.git\" --rel-name First_Release --rel-null 1 3  --rel-inc 2"
    echo_clrd 1 35 "                - ${BASH_SOURCE[0]} --publc \"https://github.com/MuraDaco/mpfw_code_main_stm_20230424.git\"                                                            --dvlpr \"file:///Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs/mpfw_code_main_stm_20230424.git\"                               --rel-name First_Release --rel-null 1 3  --rel-inc 2 --scn-intgrm reale --ws-intgrm github"
    echo_clrd 1 35 "                - ${BASH_SOURCE[0]}  --scn-intgrm reale --ws-intgrm github --publc \"https://github.com/MuraDaco/mpfw_code_main_stm_20230424.git\"                     --dvlpr \"file:///Volumes/mypass2/ObsiDataRemote/Year_2023/repo__prjs/mpfw_code_main_stm_20230424.git\"                               --rel-name First_Release --rel-null 1 3  --rel-inc 2"
    echo_clrd 1 33 "    - check commands & its options"
    echo_clrd 1 33 "        --env-intgrm"
    echo_clrd 1 33 "            ${BASH_SOURCE[0]} --scn-intgrm <scenario name> --ws-intgrm <workstation name> --env-intgrm <project/module name> <command>"    
    echo_clrd 1 35 "                ${BASH_SOURCE[0]} --scn-intgrm reale --ws-intgrm ws1 --env-intgrm \"mpfw_code_apps_tst_20221206\" <command>"
    echo_clrd 1 33 "            ~~~~~~~~~~~~~~~~~~~~~~"
    echo_clrd 1 33 "            <command> description:"
    echo_clrd 1 33 "            ~~~~~~~~~~~~~~~~~~~~~~"
    echo_clrd 1 33 "            - git"
    echo_clrd 1 33 "                - git:status"
    echo_clrd 1 34 "                    $ git status"
    echo_clrd 1 33 "                - git:log"
    echo_clrd 1 34 "                    $ git logpretty"
    echo_clrd 1 33 "                - git:remote"
    echo_clrd 1 34 "                    $ git remote"
    echo_clrd 1 33 "                - git:push"
    echo_clrd 1 34 "                    $ git remote"
    echo_clrd 1 33 "                - git:push"
    echo_clrd 1 34 "                    $ git push github github_main:main"
    echo_clrd 1 33 "                    - push:set-upstream"
    echo_clrd 1 34 "                        $ git push --set-upstream github github_main:main"
    echo_clrd 1 32 "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo_clrd 1 32 "- Command sequence to prepare the test environment"
    echo_clrd 1 33 "    - step 1: repositories creation"
    echo_clrd 1 33 "        - remote"
    echo_clrd 1 33 "            - public \"github simulation\""
    echo_clrd 1 35 "                ${BASH_SOURCE[0]} --env-publc-remote \"github\" \"Module_xx\""
    echo_clrd 1 34 "                N.B.: the path of repo is \"$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/public/https/<1st par>/<2nd par>.git\""
    echo_clrd 1 31 "                      the path of repo is \"$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/public/https/github/Module_xx.git\""
    echo_clrd 1 33 "            - public developer \"mypass2 simulation\""
    echo_clrd 1 35 "                ${BASH_SOURCE[0]} --env-dvlpr-remote \"mypass2_repo\" \"Module_xx\""
    echo_clrd 1 34 "                N.B.: the path of repo is \"$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/developer/<1st par>/<2nd par>.git\""
    echo_clrd 1 31 "                      the path of repo is \"$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/developer/mypass2_repo/Module_xx.git\""
    echo_clrd 1 33 "        - local"
    echo_clrd 1 33 "            - main developer"
    echo_clrd 1 33 "                - scope: to simulate the developer repository with all its branches"
    echo_clrd 1 33 "                - example"
    echo_clrd 1 35 "                    ${BASH_SOURCE[0]} --env-dvlpr \"dvlpr1_ws1\" \"Module_xx\""
    echo_clrd 1 34 "                    N.B.: the path of repo is \"$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/developers/<1st par>/<2nd par>\""
    echo_clrd 1 31 "                          the path of repo is \"$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/developers/dvlpr1_ws1/Module_xx\""
    echo_clrd 1 33 "            - service developer"
    echo_clrd 1 33 "                - scope: (OPTIONAL) to create a NOT-empty \"remote public\" repository; it wll track the remote public branch \"main\"; see its remote configuration"
    echo_clrd 1 33 "                - example"
    echo_clrd 1 35 "                    ${BASH_SOURCE[0]} --env-dvlpr \"dvlpr1_ws2\" \"Module_xx\""
    echo_clrd 1 34 "                    N.B.: the path of repo is \"$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/developers/<1st par>/<2nd par>\""
    echo_clrd 1 31 "                          the path of repo is \"$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/developers/dvlpr1_ws2/Module_xx\""
    echo_clrd 1 33 "    - step 2: local repositories configuration: 'git remote add <remote repository>'"
    echo_clrd 1 33 "        - local MAIN developer repo"
    echo_clrd 1 35 "            ${BASH_SOURCE[0]} --env-dvlpr \"dvlpr1_ws1\" \"Module_xx\" remote_config:mypass2_repo"
    echo_clrd 1 35 "                (to check the previous command) ${BASH_SOURCE[0]} --env-dvlpr \"dvlpr1_ws1\" \"Module_xx\" git:remote"
    echo_clrd 1 33 "        - (OPTIONAL) local SERVICE developer repo"
    echo_clrd 1 35 "            ${BASH_SOURCE[0]} --env-dvlpr \"dvlpr1_ws2\" \"Module_xx\" remote_config:public:github"
    echo_clrd 1 33 "    - step 3: local repositories first commit"
    echo_clrd 1 33 "        - local MAIN developer repo"
    echo_clrd 1 35 "            ${BASH_SOURCE[0]} --env-dvlpr \"dvlpr1_ws1\" \"Module_xx\" upd_files:commit:First_commit"
    echo_clrd 1 35 "                (to check the previous command) ${BASH_SOURCE[0]} --env-dvlpr \"dvlpr1_ws1\" \"Module_xx\" git:log"
    echo_clrd 1 33 "        - (OPTIONAL) local SERVICE developer repo"
    echo_clrd 1 35 "            ${BASH_SOURCE[0]} --env-dvlpr \"dvlpr1_ws2\" \"Module_xx\" upd_files:commit:First_commit_from_developer"
    echo_clrd 1 33 "    - step 4: local repositories first push"
    echo_clrd 1 33 "        - local MAIN developer repo"
    echo_clrd 1 35 "            ${BASH_SOURCE[0]} --env-dvlpr \"dvlpr1_ws1\" \"Module_xx\" git:push:set-upstream"
    echo_clrd 1 35 "                (to check the previous command) ${BASH_SOURCE[0]} --env-dvlpr \"dvlpr1_ws1\" \"Module_xx\" git:log"
    echo_clrd 1 33 "        - (OPTIONAL) local SERVICE developer repo"
    echo_clrd 1 35 "            ${BASH_SOURCE[0]} --env-dvlpr \"dvlpr1_ws2\" \"Module_xx\" git:push:set-upstream:public"
    echo_clrd 1 33 "    - step 5: local main repository update (next commits & pushes)"
    echo_clrd 1 33 "        - local MAIN developer repo"
    echo_clrd 1 35 "            ${BASH_SOURCE[0]} --env-dvlpr \"dvlpr1_ws1\" \"Module_xx\" upd_files:commit:Second_commit:push"
    echo_clrd 1 35 "                (to check the previous command) ${BASH_SOURCE[0]} --env-dvlpr \"dvlpr1_ws1\" \"Module_xx\" git:log"
    echo_clrd 1 33 "        - (OPTIONAL) local SERVICE developer repo"
    echo_clrd 1 35 "            ${BASH_SOURCE[0]} --env-dvlpr \"dvlpr1_ws2\" \"Module_xx\" upd_files:commit:Second_commit_from_developer:push"
    echo_clrd 1 32 "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo_clrd 1 32 "- Command sequence to synchronize \"github\" public repository with the \"developer\" public one"
    echo_clrd 1 32 "    - default scenario (the default option are: --scn-intgrm 1 --ws-intgrm ws2)"
    echo_clrd 1 33 "        ${BASH_SOURCE[0]} --publc \"<repo of step_1, remote public (github simulation)>\" --dvlpr \"<repo of step_1, remote public developer (mypass2 simulation)>\" --rel-name First_Release --rel-null 1 3  --rel-inc 2"
    echo_clrd 1 35 "            ${BASH_SOURCE[0]} --publc \"file://$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/public/https/github/Module_xx.git\" --dvlpr \"file://$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/developer/mypass2_repo/Module_xx.git\" --rel-name First_Release --rel-null 1 3  --rel-inc 2"
    echo_clrd 1 35 "                (to check the previous command) ${BASH_SOURCE[0]} --env-intgrm \"Module_xx\" git:log"
    echo_clrd 1 32 "    - NOT default scenario (example options are: --scn-intgrm reale --ws-intgrm ws1)"
    echo_clrd 1 33 "        ${BASH_SOURCE[0]} --scn-intgrm <scenario  name> --ws-intgrm <workstation name> --publc \"<repo of step_1, remote public (github simulation)>\" --dvlpr \"<repo of step_1, remote public developer (mypass2 simulation)>\" --rel-name First_Release --rel-null 1 3  --rel-inc 2"
    echo_clrd 1 31 "            N.B.: you have to create the folder \"$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_<scenario name>/manager/intgrm_<workstation name>\""
    echo_clrd 1 35 "                (to check the existence of integration manager folder) intgrm_folder=\"$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_reale/manager/intgrm_ws1\"; [ -d \"\$intgrm_folder\" ] && echo \"the folder exists\" || mkdir \"\$intgrm_folder\" "
    echo_clrd 1 35 "            ${BASH_SOURCE[0]} --scn-intgrm reale --ws-intgrm ws1 --publc \"file://$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/public/https/github/Module_xx.git\" --dvlpr \"file://$HOME/ObsiData/distributed_git/integration_manager_workflow/scenario_1/remote/developer/mypass2_repo/Module_xx.git\" --rel-name First_Release --rel-null 1 3  --rel-inc 2"
    echo_clrd 1 35 "                (to check the previous command) ${BASH_SOURCE[0]} --scn-intgrm reale --ws-intgrm ws1 --env-intgrm \"Module_xx\" git:log"
    echo_clrd 1 32 "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo_clrd 1 32 "HELP END"
    echo_clrd 1 32 "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
exit 0
}

## ****************************************************************************************
## ****************************************************************************************
## ******   Start main
## ****************************************************************************************
## ****************************************************************************************


    array_steps=(
        ## ----
        "init_script_params"                "chk_mkdir"
        "init_script_params"                "reset_repo"
        "init_script_params"                "test_func"
        "init_script_params"                "env_integration_manager"
        "init_script_params"                "env_developer"
        "init_script_params"                "env_developer_remote"
        "init_script_params"                "env_public_remote"
        "init_script_params"                "help"
        
        ## ----
        ## .... START -> test procedures
        "reset_repo"                        "display_global_variables_list"
        "test_func"                         "display_global_variables_list"
        "env_integration_manager"           "display_global_variables_list"
        "env_developer"                     "display_global_variables_list"
        "env_developer_remote"              "display_global_variables_list"
        "env_public_remote"                 "display_global_variables_list"
        "env_public"                        "display_global_variables_list"
        "help"                              "config_end"
        ## .... END -> test procedures
        ## ----
        ## .... START -> Init procedures
        "chk_mkdir"                         "set_mkdir"
        "chk_mkdir"                         "chk_git_init"
        "set_mkdir"                         "chk_git_init"
        ## ----
        "chk_git_init"                      "set_git_init"
        "chk_git_init"                      "chk_config_main_branches"
        "set_git_init"                      "chk_config_main_branches"
        ## ----
        "chk_config_main_branches"          "chk_config_remote_repo_publc"
        ## .... END -> Init procedures
        ## ----
        ## .... START -> configuring remote PUBLIC repository
        "chk_config_remote_repo_publc"      "chk_status_remote_repo_publc"
        "chk_config_remote_repo_publc"      "set_config_remote_repo_publc"
        "set_config_remote_repo_publc"      "chk_status_remote_repo_publc"
        "chk_status_remote_repo_publc"      "chk_config_main_branch_publc"
        ## ----
        "chk_config_main_branch_publc"      "set_remote_branch_tracking_publc"  ## LOCAL_COMMIT_OK / LOCAL_TRACK_NO / REMOTE_COMMIT_==
        "chk_config_main_branch_publc"      "get_commits"                       ## LOCAL_COMMIT_NO / LOCAL_TRACK_NO / REMOTE_COMMIT_==
        "chk_config_main_branch_publc"      "create_main_branch_publc"          ## LOCAL_NO_EXIST
        "chk_config_main_branch_publc"      "chk_config_remote_repo_dvlpr"      ## LOCAL_COMMIT_OK / LOCAL_TRACK_OK / REMOTE_COMMIT_==
        "create_main_branch_publc"          "get_commits"                       ## LOCAL_COMMIT_NO / LOCAL_TRACK_NO / REMOTE_COMMIT_==
        "get_commits"                       "perform_empty_commit"              ## LOCAL_COMMIT_NO / LOCAL_TRACK_NO / REMOTE_COMMIT_NO
        "get_commits"                       "get_commits_by_fetch_publc"        ## LOCAL_COMMIT_NO / LOCAL_TRACK_NO / REMOTE_COMMIT_OK
        "perform_empty_commit"              "push_set_upstream_to_remote_repo"  ## LOCAL_COMMIT_OK / LOCAL_TRACK_NO / REMOTE_COMMIT_==
        "get_commits_by_fetch_publc"        "set_remote_branch_tracking_publc"  ## LOCAL_COMMIT_OK / LOCAL_TRACK_NO / REMOTE_COMMIT_OK
        "set_remote_branch_tracking_publc"  "push_set_upstream_to_remote_repo"  ## LOCAL_COMMIT_OK / LOCAL_TRACK_NO / REMOTE_COMMIT_NO
        "set_remote_branch_tracking_publc"  "chk_config_remote_repo_dvlpr"      ## LOCAL_COMMIT_OK / LOCAL_TRACK_OK / REMOTE_COMMIT_OK
        "push_set_upstream_to_remote_repo"  "chk_config_remote_repo_dvlpr"      ## LOCAL_COMMIT_OK / LOCAL_TRACK_OK / REMOTE_COMMIT_OK
        ## .... END -> configuring remote PUBLIC repository
        ## ----
        ## .... START -> configuring remote DEVELOPER repository
        "chk_config_remote_repo_dvlpr"      "chk_status_remote_repo_dvlpr"
        "chk_config_remote_repo_dvlpr"      "set_config_remote_repo_dvlpr"
        "set_config_remote_repo_dvlpr"      "chk_status_remote_repo_dvlpr"
        "chk_status_remote_repo_dvlpr"      "chk_config_main_branch_dvlpr"
        ## ----
        "chk_config_main_branch_dvlpr"      "set_remote_branch_tracking_dvlpr"  ## LOCAL_COMMIT_OK / LOCAL_TRACK_NO / REMOTE_COMMIT_==
        "chk_config_main_branch_dvlpr"      "chk_branch_sync_dvlpr"             ## LOCAL_COMMIT_NO / LOCAL_TRACK_NO / REMOTE_COMMIT_==
        "chk_config_main_branch_dvlpr"      "get_commits_by_fetch_dvlpr"        ## LOCAL_NO_EXIST
        "chk_config_main_branch_dvlpr"      "chk_branch_sync_dvlpr"             ## LOCAL_COMMIT_OK / LOCAL_TRACK_OK / REMOTE_COMMIT_==
        "get_commits_by_fetch_dvlpr"        "chk_branch_sync_dvlpr"
        "set_remote_branch_tracking_dvlpr"  "exit_with_error"
        "set_remote_branch_tracking_dvlpr"  "chk_branch_sync_dvlpr"
        ## .... END -> configuring remote DEVELOPER repository
        ## .... START -> synchronizing remote & local repositories procedures
        ## ----
        "chk_branch_sync_dvlpr"             "chk_branch_sync_publc"
        "chk_branch_sync_dvlpr"             "sync_branch_dvlpr"
        "sync_branch_dvlpr"                 "chk_branch_sync_publc"

        "chk_branch_sync_publc"             "chk_branch_sync_new_update"
        "chk_branch_sync_publc"             "chk_branch_sync_new_update"

        "chk_branch_sync_new_update"        "chk_branch_sync_locals"

        "chk_branch_sync_locals"            "sync_new_update_with_dvlpr"
        "chk_branch_sync_locals"            "sync_new_update_with_dvlpr"
        
        "sync_new_update_with_dvlpr"        "sync_publc_with_new_update"
        "sync_publc_with_new_update"        "display_global_variables_list"

        ## .... END -> synchronizing remote & local repositories procedures
        ## ----

        "exit_with_error"                   "display_global_variables_list"
        
        ## ----
        "display_global_variables_list"     "config_end"
    )

    script_params="$@"

    echo_clrd 1 32 "START ..."
    item_id=0
    for item in ${array_steps[@]};
    do
        [ $item_id -eq 0 ] && {
            state_to_perform="init_script_params"
            state_to_perform_id=0
            step_result=
        }
        ((field_id=item_id%2))
        case "$field_id" in
            ("0")
                ## echo_clrd 1 34 "INFO - field_id: $field_id - item: $item - state_xxx: $state_xxx - state_to_perform: $state_to_perform"
                [ "$state_xxx" = "$item" ] && {
                    ((state_xxx_id++)); true
                    ## echo_clrd 1 33 "INFO - state_xxx: $state_xxx - state_xxx_id: $state_xxx_id - state_to_perform: $state_to_perform"
                } || {
                    state_xxx=$item
                    state_xxx_id=0

                    [ "$state_to_perform" = "$state_xxx" ] && {
                        ## check $step_result variable
                        ## echo_clrd 1 34 "INFO - Checking \"step_result\" variable"
                        [ -n "$step_result" ] && {
                            echo_clrd 1 31 "ERROR - step_result variable was not used - "
                            echo_clrd 1 33 "INFO - Perform of \"$state_xxx\" via \"eval\" statement is stopped."
                            exit 1
                        }
                        ## echo_clrd 1 34 "INFO - Performing \"$state_xxx\" via \"eval\" statement ... "
                        eval "$state_xxx"
                        ## controllare il risultato ed impostare il $state_to_perform e $state_to_perform_id
                        ## echo_clrd 1 34 "INFO - getting \"step_result\" variable ... "
                        state_to_perform_id=$step_result
                        state_to_perform=
                        ## echo_clrd 1 34 "INFO - step_result: $step_result -  state_xxx_id: $state_xxx_id"
                    }

                    ## echo_clrd 1 34 "INFO -field_id: $field_id -  state_xxx: $state_xxx - state_xxx_id: $state_xxx_id - state_to_perform: $state_to_perform"
                }

            ;;
            ("1")
                ## echo_clrd 1 36 "INFO - field_id: $field_id"
                ## state_next_xxx=$item

                ## echo_clrd 1 35 "INFO - Checking \"step_result\" variable ($step_result) ... "
                [ -n "$step_result" ] && {
                    [ "$state_xxx_id" = "$step_result" ] && {
                        ## echo_clrd 1 36 "INFO - Setting the next procedure to perform \"state_to_perform\" variable"
                        state_to_perform=$item
                        ## echo_clrd 1 35 "INFO - The next procedure to perform is \"$state_to_perform\""
                        ## echo_clrd 1 36 "INFO - Resetting \"step_result\" variable"
                        ## reset $step_result variable
                        step_result=
                    }
                }
                ## echo_clrd 1 35 "INFO - state_xxx: $state_xxx - state_xxx_id: $state_xxx_id - state_to_perform: $state_to_perform - state_to_perform_id: $state_to_perform_id"
            ;;
        esac


        ((item_id++))
    done
