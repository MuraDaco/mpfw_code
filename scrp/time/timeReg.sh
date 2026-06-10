#!/bin/bash

current_script_dir=$(dirname "${BASH_SOURCE[0]}")
source $current_script_dir/func_echo.sh

# ********************************************************
function read_string {
    while IFS= read -r answer
    do
        [ "$answer" ] && break
    done < /dev/stdin

    answer=${answer%/}

    eval "$1=\"$answer\""
    eval result=\"\$$1\"
    echo_clrd_2 1 32 "result: " 1 31 "$result"
}


while IFS= read -r line;
do
    echo "line: $line"
    line_code=$(echo $line | cut -d':' -f 1)
    [ "cmd" = "$line_code" ] && {
        line_cmd=$(echo $line | cut -d':' -f 2)
        [ "start" = "$line_cmd" ] && {
            break
        }

    }
    true
done < <(cat /Users/work/Documents/ipc_cmd.txt | grep "cmd")

[ "start" = "$line_cmd" ] && {

    echo "------" >> "/Users/work/Documents/db_activity.txt"
    echo >> "/Users/work/Documents/db_activity.txt"
    date >> "/Users/work/Documents/db_activity.txt"
    echo "------"
    echo
    date

    time_event_sec=$(date +%s)
    time_event_sec_last_activity_event=$time_event_sec
    time_event_standard=$(date -r $time_event_sec "+%Hh %M' %S\"")
    echo "record:activity_start_event:$time_event_sec:$time_event_standard" >> "/Users/work/Documents/db_activity.txt"
    echo "record:activity_start_event:$time_event_sec:$time_event_standard"
    PERIOD_idle_MIN=300
    PERIOD_recording=300
    ((time_event_sec_delta = $time_event_sec / $PERIOD_recording))
    ((time_recording_sec = $time_event_sec_delta * $PERIOD_recording + $PERIOD_recording))
    cntr_activity_event=1
    while true
    do

        while IFS= read -r line;
        do
            ## echo "line: $line"
            line_code=$(echo $line | cut -d':' -f 1)
            [ "cmd" = "$line_code" ] && {
                line_cmd=$(echo $line | cut -d':' -f 2)
                [ "stop" = "$line_cmd" ] && {
                    break
                }

                [ "report_sum" = "$line_cmd" ] && {
                    break
                }

                [ "report_details" = "$line_cmd" ] && {
                    break
                }

            }
            true
        done < <(cat /Users/work/Documents/ipc_cmd.txt | grep "cmd")

        [ "stop" = "$line_cmd" ] && {
            break
        }

        time_current_sec=$(date +%s)
        time_event_sec=$time_current_sec
        ((time_period_idle_sec = $time_event_sec - $time_event_sec_last_activity_event))
        time_event_standard=$(date -r $time_event_sec "+TIME %Hh %M' %S\"")
        ## aggiungere la condizione che deve essere inferiore al time_recording_sec + PERIOD_recording / situazione di sleep
        [ $time_event_sec -ge $time_recording_sec ] && {
            ((time_recording_delta_sec = $time_recording_sec + 10))

            ((time_event_sec_delta = $time_event_sec / $PERIOD_recording))
            ((time_recording_sec = $time_event_sec_delta * $PERIOD_recording + $PERIOD_recording))
            time_recording_standard=$(date -r $time_recording_sec "+NEXT REC %Hh %M' %S\"")

            [ $time_event_sec -le $time_recording_delta_sec ] && {
                [ $cntr_activity_event -gt 0 ] && {
                    echo "record:activity_periodic_recording_event:$time_event_sec:$time_event_standard:$time_recording_standard:level_act $cntr_activity_event" >> "/Users/work/Documents/db_activity.txt"
                    echo "record:activity_periodic_recording_event:$time_event_sec:$time_event_standard:$time_recording_standard:level_act $cntr_activity_event"
                }
            } || {
                ## return from "system sleep" / just wake up from system sleep
                [ $cntr_activity_event -gt 0 ] && {
                    time_recording_delta_std=$(date -r $time_recording_delta_sec "+TIME %Hh %M' %S\"")
                    echo "record:activity_periodic_recording_event:$time_recording_delta_sec:$time_recording_delta_std - \"just wake up from system sleep\" :$time_recording_standard:level_act $cntr_activity_event" >> "/Users/work/Documents/db_activity.txt"
                    echo "record:activity_periodic_recording_event:$time_recording_delta_sec:$time_recording_delta_std - \"just wake up from system sleep\" :$time_recording_standard:level_act $cntr_activity_event"
                }
            }
            cntr_activity_event=0

        } || {

            ## check idle time of the system
            time_idle_test=$((`ioreg -c IOHIDSystem | sed -e '/HIDIdleTime/!{ d' -e 't' -e '}' -e 's/.* = //g' -e 'q'`/1000000000))
            [ $time_idle_test -eq 0 ] && {
                ## activity event
                time_period_idle=$(date -u  -r $time_period_idle_sec "+%Hh %M' %S\"")
                time_last_event_standard=$(date -r $time_event_sec_last_activity_event "+%Hh %M' %S\"")
                [ $time_period_idle_sec -gt $PERIOD_idle_MIN ] && {
                    echo "record:period_idle:$time_event_sec:$time_event_standard:last event activity $time_last_event_standard / $time_event_sec_last_activity_event:idle_interval $time_period_idle:level_act $cntr_activity_event" >> "/Users/work/Documents/db_activity.txt"
                    echo "record:period_idle:$time_event_sec:$time_event_standard:last event activity $time_last_event_standard / $time_event_sec_last_activity_event:idle_interval $time_period_idle:level_act $cntr_activity_event"
                    cntr_activity_event=1
                    ## break 
                } || {
                    ((cntr_activity_event = $cntr_activity_event + 1))
                }

                ## update last event activity time
                time_event_sec_last_activity_event=$time_event_sec
            }
            true
        }
        ## echo "time_idle_test:           $time_idle_test"
        ## echo "time_period_idle_sec:     $time_period_idle_sec"
        sleep 1
    done

}

