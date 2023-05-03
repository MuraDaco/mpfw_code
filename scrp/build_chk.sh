#!/bin/bash

function echo_chk_clrd {
    echo -e "\033[$1;$2m""dbg msg - `basename $0` -> $3""\033[0;0m" > /dev/stderr
}

echo_chk_clrd 1 33 "build_total.sh stm32f769_disco  stm_20230501"
build_total.sh stm32f769_disco  stm_20230501 > /dev/null 2>&1 && {
    echo_chk_clrd 1 33 "build_total.sh mac tst_20221229"
    build_total.sh nxp              tst_20221229 > /dev/null 2>&1 && {
        echo_chk_clrd 1 33 "build_total.sh nxp tst_20221229"
        build_total.sh mac              tst_20221229 > /dev/null 2>&1 && {
            echo_chk_clrd 1 32 "OK"
        } || {
            build_total.sh mac              tst_20221229 
            true
        }
    } || {
        build_total.sh nxp              tst_20221229
        true
    }
} || {
    build_total.sh stm32f769_disco  stm_20230501
    true
}
