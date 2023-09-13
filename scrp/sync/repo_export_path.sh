#!/bin/bash

# ********************************************************
function echo_chk_clrd {
    echo -e "\033[$1;$2m""dbg msg on stderr -> $3""\033[0;0m" > /dev/stderr
}
# ********************************************************
function echo_chk_clrd_start {
    echo -e "\033[$1;$2m""$3" > /dev/stderr
}

# ********************************************************
function echo_chk_clrd_end {
    echo -e "\033[0;0m" > /dev/stderr
}

option_restore=0
option_set=0
[ "$1" = --restore ] && {
    shift
    option_restore=1
} || {
    [ "$1" = --set ] && {
        shift
        option_set=1
    }
}


{
    [ $option_restore -eq 0 ] &&
    [ $option_set -eq 0 ]
} && {
    echo_chk_clrd_start 1 33
    echo "PATH:           $PATH"
    echo "PATH_ORIGINAL:  $PATH_ORIGINAL"
    echo "PATH_REPO_MPFW_CODE: $PATH_REPO_MPFW_CODE"
    echo
    echo "Option available: \"--restore\" or \"--set\" "
    echo_chk_clrd_end
}

[ $option_restore -eq 1 ] && {

    [ "$PATH_ORIGINAL" ] && {
        export PATH=$PATH_ORIGINAL
        export PATH_ORIGINAL=""
        export PATH_REPO_MPFW_CODE=""
        echo_chk_clrd_start 1 32 "OK - Original path "
        echo "PATH: \"$PATH\""
        echo "has been restored succesfully."
        echo_chk_clrd_end
    } || {
        echo_chk_clrd 1 31 "ERROR - this command can only be executed after the \"repo_export_path.sh\" one"
    }

}

[ $option_set -eq 1 ] && {

    [ "$PATH_ORIGINAL" ] && {
        echo_chk_clrd 1 31 "WARNING - this command can only be executed once on terminal session or after that you restore the path"
    } || {

        path_basename=$(basename $PWD)
        [ "$path_basename" = "mpfw_code" ] && {
            PATH_REPO_MPFW_CODE="$PWD"
        } || {
            path_pre_mpfw_code=${PWD%/mpfw_code/*}
            PATH_REPO_MPFW_CODE="$path_pre_mpfw_code/mpfw_code"
        }
        [ -d "$PATH_REPO_MPFW_CODE/cmake" ] && {
            echo_chk_clrd 1 32 "OK ---- \"$PATH_REPO_MPFW_CODE\" is a valid mpfw_code path: \"cmake\" subdirectroy exists"

            export PATH_ORIGINAL=$PATH
            export PATH_REPO_MPFW_CODE
            export PATH=$PATH_REPO_MPFW_CODE/scrp:$PATH

        } || {
            echo_chk_clrd 1 31 "ERROR - \"$PATH_REPO_MPFW_CODE\" is not a valid mpfw_code path: \"cmake\" subdirectroy does not exist"
        }
    }
}
