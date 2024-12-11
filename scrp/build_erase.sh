#!/bin/bash

source build_functions.sh

set_array_param=()
while (( $# ))
do
    set_array_param+=("$1")
    shift
done

param_parsing "${set_array_param[@]}"


echo_chk_clrd 1 32 "main_name:          $main_name"
echo_chk_clrd 1 32 "apps_name:          $apps_name"

echo 
echo "Starting erasing cmake build dir ..."
echo 

build_total.sh $main_name $apps_name mac             dbg -rr
build_total.sh $main_name $apps_name nxp             dbg -rr
build_total.sh $main_name $apps_name stm32f769_disco dbg -rr

build_total.sh $main_name $apps_name mac             rls -rr
build_total.sh $main_name $apps_name nxp             rls -rr
build_total.sh $main_name $apps_name stm32f769_disco rls -rr

echo 
echo "Starting erasing cube & xpresso build dir ..."
echo 


(
    cd "apps/mpfw_code_apps_$apps_name/wsp/xpresso/$apps_name" && {
        echo "Directory \"${PWD#*/mpfw_code/}\" exist" 
        rm -rf Debug
        rm -rf Release
        rm -rf .settings/language.settings.xml
        rm -rf .eclipse_cproject_patch*
    } || echo "ERROR"
)

(
    cd "apps/mpfw_code_apps_$apps_name/wsp/cube/$apps_name" && {
        echo "Directory \"${PWD#*/mpfw_code/}\" exist" 
        rm -rf Debug
        rm -rf Release
        rm -rf .settings/language.settings.xml
        rm -rf .eclipse_cproject_patch*
    } || echo "ERROR"
) 

(
    cd "main/mpfw_code_main_$main_name/wsp/xpresso/project/nxp/$main_name" && {
        echo "Directory \"${PWD#*/mpfw_code/}\" exist" 
        rm -rf Debug
        rm -rf Release
        rm -rf .settings/language.settings.xml
        rm -rf .eclipse_cproject_patch*
    } || echo "ERROR"
)

(cd "main/mpfw_code_main_$main_name/wsp/cube/project/stm32f769_disco/$main_name" && {
        echo "Directory \"${PWD#*/mpfw_code/}\" exist" 
        rm -rf Debug
        rm -rf Release
        rm -rf .settings/language.settings.xml
        rm -rf .eclipse_cproject_patch*
    } || echo "ERROR"
)

