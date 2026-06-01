# ********************************************************
function get_array_id {

    local l_item_id=0
    local result=-1
    for item in ${glovars_list[@]}; do
        ## echo_clrd 1 35 "$l_item_id -> $item"
        [ "${glovars_list[$l_item_id]}" = "$1" ] && result=$l_item_id || true
        ((l_item_id++))
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

function glovars_display    {

    local l_item_id=0
    for item in ${glovars_list[@]}; do
        echo_clrd_2 1 35 "$item: " 1 33 "${glovars[$l_item_id]}"
        ((l_item_id++))
    done

}




function parse_input_param  {

    echo_clrd 1 33 "Reading input parameters"
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
                ## parameters that do or can not have parameters
                ("--help")
                    par_name="g_help"
                    glovars_upd "$par_name" "yes"
                    ;;
                ("--create-local-public-repos")
                    par_name="create_local_public_repos"
                    glovars_upd "$par_name" "yes"
                    ;;
            esac
            true
        } || {
            [ -n "$param_type" ] && {
                case "$param_type" in
                    ("--public-intgrm")
                        par_name="public_intgrm"
                        [ -z "$l_par_string" ] && l_par_string="$par_item" || l_par_string="$l_par_string"" $par_item"
                        glovars_upd "$par_name" "$l_par_string"
                        ;;
                    ("--public-dvlpr")
                        par_name="public_dvlpr"
                        [ -z "$l_par_string" ] && l_par_string="$par_item" || l_par_string="$l_par_string"" $par_item"
                        glovars_upd "$par_name" "$l_par_string"
                        ;;
                    ("--create-local-public-repos")
                        par_name="create_local_public_repos"
                        [ -z "$l_par_string" ] && l_par_string="$par_item" || l_par_string="$l_par_string"" $par_item"
                        glovars_upd "$par_name" "$l_par_string"
                        ;;
                    ("--range-down")
                        par_name="range_dw"
                        [ -z "$l_par_string" ] && l_par_string="$par_item" || l_par_string="$l_par_string"" $par_item"
                        glovars_upd "$par_name" "$l_par_string"
                        ;;
                    ("--range-up")
                        par_name="range_up"
                        [ -z "$l_par_string" ] && l_par_string="$par_item" || l_par_string="$l_par_string"" $par_item"
                        glovars_upd "$par_name" "$l_par_string"
                        ;;
                esac
            }
        }
    done

    [ -z "$range_dw" ] && range_dw=0
    [ -z "$range_up" ] && range_up=1

}


function display_global_variables_list {
    echo_clrd 1 34 "|^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^|"
    echo_clrd 1 33 "Global variables summary ..."
    echo_clrd 1 34 "|~~~~~"

    glovars_display
    step_result=0

}

