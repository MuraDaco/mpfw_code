#!/bin/bash


DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR/.. && {
    source scrp/sync/repo_export_path.sh --set
    date
    zsh
    pwd
    date
#    while true
#    do
#        echo_chk_clrd 1 33 "exit [q] - continue [any key]"
#        while IFS= read -r answer
#        do
#            [ "$answer" = "q" ] && exit 0 || break
#        done < /dev/stdin
#
#        obdash.sh
#    done
}