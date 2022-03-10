#!/bin/bash
#script for parsing text document for video length times from vid_list.txt (total time for compTIA course sec 3.3-3.11) Copied from website

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

#declare -p v_list

#time variables
v_mins=0
v_secs=0
t_time=0


#iterate list adding column 1 (minutes) and 2 (seconds) separately (10# base 10 added to fix error caused by leading zero causing number to be interpreted as octal)
for i in "${v_list[@]}"
do
  let v_mins=${v_mins}+$(echo ${i} | cut -f1 -d" ")
  let v_secs=${v_secs}+10#$(echo ${i} | cut -f2 -d" ")
  #printf ${v_secs}" "
done

#echo ${v_mins}
#echo ${v_secs}

#calculate minutes and remaining seconds from total seconds (printf call added to print single digit number with zero preceding it for results ofseconds less than 10
let sec_rem=${v_secs}%60
printf -v sec_rem "%02d\n" ${sec_rem}

let sec_min=${v_secs}/60

let v_mins=${v_mins}+${sec_min}

echo "Total Time: ${v_mins}:${sec_rem}"
