#!/bin/bash

function echo_chk_clrd {
    echo -e "\033[$1;$2m""dbg msg - `basename $0` -> $3""\033[0;0m" > /dev/stderr
}

build_total.sh tst_20240203main tst_20240203app mac rls > /dev/null 2>&1  && {
    echo_chk_clrd 1 32 "platform <mac> OK"
    build_total.sh tst_20240203main tst_20240203app nxp rls > /dev/null 2>&1 && {
        echo_chk_clrd 1 32 "platform <nxp> OK"
        build_total.sh tst_20240203main tst_20240203app stm32f769_disco rls > /dev/null 2>&1 && {
            echo_chk_clrd 1 32 "platform <stm32f769_disco> OK"
        } || {
            build_total.sh tst_20240203main tst_20240203app stm32f769_disco rls
            true
        }
    } || {
        build_total.sh tst_20240203main tst_20240203app nxp rls
        true
    }
} || {
    build_total.sh tst_20240203main tst_20240203app mac rls
    true
}
