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

day_back=1
[ -n "$1" ] && ((day_back = $1 + 1)) || true
((day_back_next = day_back - 1 ))


line_day_start=$(       cat /Users/work/Documents/db_activity.txt | grep -n "activity_start_event" | tail -$day_back      | head -1 | cut -d':' -f 1)
[ $day_back_next -eq 0 ] && {
    line_next_day_start=$(  cat /Users/work/Documents/db_activity.txt | wc -l)
    ## to remove white spaces
    ((line_next_day_start = $line_next_day_start))
} || {
    line_next_day_start=$(  cat /Users/work/Documents/db_activity.txt | grep -n "activity_start_event" | tail -$day_back_next | head -1 | cut -d':' -f 1)
}
((line_delta = $line_next_day_start - $line_day_start + 1 ))

## sed -n "$line_day_back, $line_next_day_back p" /Users/work/Documents/db_activity.txt
## cat /Users/work/Documents/db_activity.txt | head -$line_next_day_start | tail -$line_delta
line_delta2=$(sed -n "$line_day_start, $line_next_day_start p" /Users/work/Documents/db_activity.txt | wc -l)

time_start=$(   cat /Users/work/Documents/db_activity.txt | grep "activity_start_event" | tail -$day_back | head -1 | cut -d':' -f 3)
time_current=$( cat /Users/work/Documents/db_activity.txt | head -$line_next_day_start | grep "activity_periodic_recording_event" | tail -1 | cut -d':' -f 3)
echo "time_start test:      $time_start"
echo "time_current test:    $time_current"
echo "day_back test:        $day_back"
echo "day_back_next test:   $day_back_next"
echo "line_day_start:       $line_day_start"
echo "line_next_day_start:  $line_next_day_start"
echo "line_delta:           $line_delta"
echo "line_delta2:          $line_delta2"


## get the day of report
## time_start=$(cat /Users/work/Documents/db_activity.txt | grep "activity_start_event" | tail -1 | cut -d':' -f 3)
## time_current=$(cat /Users/work/Documents/db_activity.txt | grep "activity_periodic_recording_event" | tail -1 | cut -d':' -f 3)
(( day_report_sec = ( $time_start / 86400 ) * 86400 ))
(( day_report_next_sec = ( $time_start / 86400 + 1) * 86400 ))
echo "The day of report is:"
date -u -r $day_report_sec 
echo

period_idle_tot=0
while IFS= read -r line;
do
    ## echo "line: $line"
    line_time_current=$(echo $line | cut -d':' -f 3)
    ## check the day
    ## [ $day_report_sec -le $line_time_current ] && {
    ##     [ $line_time_current -lt $day_report_next_sec ] && {

            line_time_last=$(echo $line | cut -d':' -f 5)
            line_time_last=${line_time_last#*/ }
            ## echo "line_time_current:    $line_time_current"
            ## echo "line_time_last:       $line_time_last"
            ((period_idle_current = $line_time_current - $line_time_last))
            ((period_idle_tot = $period_idle_tot + $period_idle_current ))
            [ $period_idle_current -ge 600 ] && ((period_idle_tot_filter = $period_idle_tot + $period_idle_current )) || true

    ##     }
    ## }
    true

## done < <(cat /Users/work/Documents/db_activity.txt | grep "period_idle")
done < <(sed -n "$line_day_start, $line_next_day_start p" /Users/work/Documents/db_activity.txt | grep "period_idle")


echo "period_idle_tot:       $period_idle_tot "

## time_current=$(date +%s)
echo "time_start:       $time_start"
echo "time_current:     $time_current"
((period_activity_tot = ($time_current - $time_start) - $period_idle_tot))

date -r $time_start    "+start time:   %H:%M:%S"
date -r $time_current  "+current time: %H:%M:%S"

period_idle_tot_2=$(date -u -r $period_idle_tot      "+idle period:     %Hh %M' %S\"")
period_activity_tot_2=$(date -u -r $period_activity_tot  "+activity period: %Hh %M' %S\"")

echo_clrd 1 31 "$period_idle_tot_2"
echo_clrd 1 32 "$period_activity_tot_2"

##    - [report_sum]
##        - totale del tempo di idle
##        - totale del tempo di attività = (orario corrente - orario start attivita) - totale tempo di idle
##    - [report_details]
##        - init
##            - [time_array_start_event_sec] = ore 04.00 del giorno delezionato
##            - <id array last> = 18 ore / 5 min = 216
##            - <id array> = 0
##        - loop (<row db> of [activity_periodic_recording_event])
##            - <id array current> = <id array>
##            - loop (<id array current> up to <id array last>)
##                - [time_periodic_array_event]<id array> = [time_array_start_event_sec] + <id array>*[PERIOD_recording]
##                - [time_periodic_rec_event]<row db> >= [time_periodic_array_event]<id array> && [time_periodic_rec_event]<row db> < [time_periodic_array_event]<id array + 1>
##                    - [activity_level]<id array> = [activity_level]<row db>
##                    - inc <id array>
##                    - break (exit from loop (<id array> ))
##                - [otherwise]
##                    - [activity_level]<id array> = 0
##                    - inc <id array>
##            - next <row db>
##        - loop (<id array current> up to <id array last>)
##            - [activity_level]<id array> = 0
##            - inc <id array>
##        - oppure
##        - loop (<id array>)

## exit 0

## init
    ## 00:00:00 del giorno corrente (current time / 86400 * 86400) + 2h (7200 sec)
    (( time_report_begin = ( $time_start / 86400 ) * 86400 + 7200 ))
    (( time_report_end   = $time_report_begin + 64800 ))
    PERIOD_recording=300 
    id=0
    activity_level_report=()

    echo "Start report" > /Users/work/Documents/db_report.txt
    date -u -r $day_report_sec >> /Users/work/Documents/db_report.txt
    
## loop on db recording
    while IFS= read -r line;
    do
        time_recording_current=$(echo $line | cut -d':' -f 3)
        ## check the day
        ## [ $day_report_sec -le $time_recording_current ] && {
        ##     [ $time_recording_current -lt $day_report_next_sec ] && {

                level_activity=$(echo $line | cut -d':' -f 6 | cut -d' ' -f 2)
                ## level_activity=${level_activity#*level_act }
                ## loop on array
                while true
                do
                    (( time_report_id      = $time_report_begin + $PERIOD_recording * $id ))
                    (( time_report_id_next = $time_report_begin + $PERIOD_recording * ($id + 1) ))
                    [ $time_report_id -ge $time_report_end ] && break || true

                    ## if [[ $time_report_id -le $time_recording_current -a $time_recording_current -lt $time_report_id_next ]]; then
                    if [[ $time_recording_current -lt $time_report_id_next ]]; then
                        activity_level_report[$id]=$level_activity
                        ## echo "$time_report_id ($time_recording_current) - $id - ${activity_level_report[$id]} - break" >> /Users/work/Documents/db_report.txt
                        ((id++))
                        break
                    else
                        activity_level_report[$id]=0
                        ## echo "$time_report_id ($time_recording_current) - $id - ${activity_level_report[$id]}" >> /Users/work/Documents/db_report.txt
                        ((id++))
                    fi
                done
        ##     }
        ## }

    ## done < <(cat /Users/work/Documents/db_activity.txt | grep "activity_periodic_recording_event")
    done < <(sed -n "$line_day_start, $line_next_day_start p" /Users/work/Documents/db_activity.txt | grep "activity_periodic_recording_event")

    echo "----- " >> /Users/work/Documents/db_report.txt

    while true
    do
        (( time_report_id      = $time_report_begin + $PERIOD_recording * $id ))
        (( time_report_id_next = $time_report_begin + $PERIOD_recording * ($id + 1) ))
        [ $time_report_id -ge $time_report_end ] && break || true
        activity_level_report[$id]=0
        ## echo "$time_report_id ($time_recording_current) - $id - ${activity_level_report[$id]}" >> /Users/work/Documents/db_report.txt
        ((id++))

    done

    (( item_half = $id / 2 ))

##    echo "$id" >> /Users/work/Documents/db_report.txt
##
##    for((id=0;id<5;id++)); do
##        str=
##        item_id=0
##        ((limit_40 = 40 + 40*$id))
##        ((limit_20 = 20 + 40*$id))
##        ((limit_10 = 10 + 40*$id))
##        ((limit_0  =      40*$id))
##        id_last=0        
##        for item in ${activity_level_report[@]}; do
##            [ $item -gt $limit_40 ] && str=$str":" || {
##                [ $item -gt $limit_20 ] && str=$str":" || {
##                    [ $item -gt $limit_10 ] && str=$str"." || {
##                        [ $item -gt $limit_0 ] && str=$str"~" || {
##                            [ $id -eq $id_last ] && str=$str"*" || str=$str" "
##                        }
##                    }
##                }
##            }
##
##            ((item_id++))
##            ##echo "$item_id - $item" >> /Users/work/Documents/db_report.txt
##
##        done
##        str_level[$id]=$str
##        echo "${str_level[$id]}" >> /Users/work/Documents/db_report.txt
##    done
##
##    echo >> /Users/work/Documents/db_report.txt
##    echo >> /Users/work/Documents/db_report.txt
##    echo "------------------------------------------------------------------------------------------" >> /Users/work/Documents/db_report.txt
##    echo >> /Users/work/Documents/db_report.txt
##    echo >> /Users/work/Documents/db_report.txt
##
##    for((id=0;id<5;id++)); do
##        str=
##        item_id=0
##        ((limit_40 = 40 + 40*(4 - $id) ))
##        ((limit_20 = 20 + 40*(4 - $id) ))
##        ((limit_10 = 10 + 40*(4 - $id) ))
##        ((limit_0  =      40*(4 - $id) ))
##        id_last=4
##        for item in ${activity_level_report[@]}; do
##            [ $item -gt $limit_40 ] && str=$str":" || {
##                [ $item -gt $limit_20 ] && str=$str":" || {
##                    [ $item -gt $limit_10 ] && str=$str"." || {
##                        [ $item -gt $limit_0 ] && str=$str"~" || {
##                            [ $id -eq $id_last ] && str=$str"*" || str=$str" "
##                        }
##                    }
##                }
##            }
##
##            ((item_id++))
##            ##echo "$item_id - $item" >> /Users/work/Documents/db_report.txt
##
##        done
##        str_level[$id]=$str
##        echo "${str_level[$id]}" >> /Users/work/Documents/db_report.txt
##    done

##    echo >> /Users/work/Documents/db_report.txt
##    echo >> /Users/work/Documents/db_report.txt
##    echo "********************************************************************************************" >> /Users/work/Documents/db_report.txt
##    echo >> /Users/work/Documents/db_report.txt
##    echo >> /Users/work/Documents/db_report.txt

    echo " 04          05          06          07          08          09          10          11          12         13 " >> /Users/work/Documents/db_report.txt
    echo " 0    1/2    1    1/2    2    1/2    3    1/2    4    1/2    5    1/2    6    1/2    7    1/2    8    1/2    9 " >> /Users/work/Documents/db_report.txt
    echo "-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-" >> /Users/work/Documents/db_report.txt

    for((id=0;id<5;id++)); do
        str=
        item_id=0
        ((limit_40 = 40 + 40*$id))
        ((limit_20 = 20 + 40*$id))
        ((limit_10 = 10 + 40*$id))
        ((limit_0  =      40*$id))
        id_last=0        
        for item in ${activity_level_report[@]}; do
            [ $item_id -lt $item_half ] && {
                [ $item -gt $limit_40 ] && str=$str":" || {
                    [ $item -gt $limit_20 ] && str=$str":" || {
                        [ $item -gt $limit_10 ] && str=$str"." || {
                            [ $item -gt $limit_0 ] && str=$str"~" || {
                                [ $id -eq $id_last ] && str=$str"*" || str=$str" "
                            }
                        }
                    }
                }
            }
            ((item_id++))

        done
        str_level[$id]=$str
        echo "${str_level[$id]}" >> /Users/work/Documents/db_report.txt
    done

    echo >> /Users/work/Documents/db_report.txt
    echo >> /Users/work/Documents/db_report.txt
    echo "------------------------------------------------------------------------------------------" >> /Users/work/Documents/db_report.txt
    echo >> /Users/work/Documents/db_report.txt
    echo >> /Users/work/Documents/db_report.txt

    for((id=0;id<5;id++)); do
        str=" "
        item_id=0
        ((limit_40 = 40 + 40*(4 - $id) ))
        ((limit_20 = 20 + 40*(4 - $id) ))
        ((limit_10 = 10 + 40*(4 - $id) ))
        ((limit_0  =      40*(4 - $id) ))
        id_last=4
        for item in ${activity_level_report[@]}; do
            [ $item_id -ge $item_half ] && {
                [ $item -gt $limit_40 ] && str=$str":" || {
                    [ $item -gt $limit_20 ] && str=$str":" || {
                        [ $item -gt $limit_10 ] && str=$str"." || {
                            [ $item -gt $limit_0 ] && str=$str"~" || {
                                [ $id -eq $id_last ] && str=$str"*" || str=$str" "
                            }
                        }
                    }
                }
            }
            ((item_id++))
            ##echo "$item_id - $item" >> /Users/work/Documents/db_report.txt

        done
        str_level[$id]=$str
        echo "${str_level[$id]}   " | rev >> /Users/work/Documents/db_report.txt
    done

    echo " |-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-_-_-|-" >> /Users/work/Documents/db_report.txt
    echo " 18   1/2   17    1/2   16    1/2   15    1/2   14    1/2   13    1/2   12    1/2   11    1/2   10    1/2    9" >> /Users/work/Documents/db_report.txt
    echo " 22         21          20          19          18          17          16          15          14          13" >> /Users/work/Documents/db_report.txt

    echo >> /Users/work/Documents/db_report.txt
    echo >> /Users/work/Documents/db_report.txt

    date -r $time_start    "+start time:   %H:%M:%S" >> /Users/work/Documents/db_report.txt
    date -r $time_current  "+current time: %H:%M:%S" >> /Users/work/Documents/db_report.txt

    ## period_idle_tot_2=$(date -u -r $period_idle_tot      "+idle period:     %Hh %M' %S\"")
    ## period_activity_tot_2=$(date -u -r $period_activity_tot  "+activity period: %Hh %M' %S\"")

    echo_clrd 1 31 "$period_idle_tot_2" >> /Users/work/Documents/db_report.txt
    echo_clrd 1 32 "$period_activity_tot_2" >> /Users/work/Documents/db_report.txt
