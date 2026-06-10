#!/bin/bash

## Screenshot 2026-05-18 at 09-12-27 BASH function to read user input OR interrupt on timeout - Unix & Linux Stack Exchange.png
## Screenshot 2026-05-18 at 09-57-37 How to set date range in shell script - Stack Overflow.png
## Screenshot 2026-05-18 at 15-40-48 How to set date range in shell script - Stack Overflow.png


function Process_A    {
    sleep 4
    echo "Process A is done"
}


function Process_B    {
    sleep 3
    echo "Process B is done"
}


Process_A &
pid_A=$!

Process_B &
pid_B=$!

echo "CHILD_MAX:    $CHILD_MAX"
echo "Waiting ... ($pid_A, $pid_B)"
wait

echo "All done."

