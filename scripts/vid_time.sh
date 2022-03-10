#!/bin/bash
#script for parsing text document for video length times from vid_list.txt (total time for compTIA course sec 3.3-3.11) Copied from website
#Script needs to be updated to handle invalid user input

IFS=$'\n'

#list of files for selection
vid_dir=($(ls -a vid_dir/ | awk -e '/vid_list/ {print "vid_dir/"$0}'))
vid_pick=''

#present user with list of files to select from
select el in ${vid_dir[@]}
do
  vid_pick=$(echo ${el})
  break
done

echo "Input selected: "${vid_pick}



#parse file into array of numbers to be added
v_list=($(cat ${vid_pick} | awk -e '/\)$/ {print $NF}' | awk '{gsub(/\(/,"");gsub(/\)/,"");gsub(/:/," "); print $0}'))

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
