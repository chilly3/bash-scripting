#!/bin/bash
#script for parsing text document for video length times from vid_list.txt (total time for compTIA course sec 3.3-3.11) Copied from website

#parse file into array of numbers to be added
IFS=$'\n'

v_list=($(cat vid_list.txt | awk -e '/\)$/ {print $NF}' | awk '{gsub(/\(/,"");gsub(/\)/,"");gsub(/:/," "); print $0}'))

#declare -p v_list

#time variables
v_mins=0
v_secs=0
t_time=0


#iterate list adding column 1 (minutes) and 2 (seconds) separately
for i in "${v_list[@]}"
do
  let v_mins=${v_mins}+$(echo ${i} | cut -f1 -d" ")
  let v_secs=${v_secs}+$(echo ${i} | cut -f2 -d" ")
done

#echo ${v_mins}
#echo ${v_secs}

#calculate minutes and remaining seconds from total seconds
let sec_rem=${v_secs}%60
let sec_min=${v_secs}/60

let v_mins=${v_mins}+${sec_min}

echo "Total Time: "${v_mins}":"${sec_rem}
