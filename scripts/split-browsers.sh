#!/bin/bash
#script for two browser windows side by side on 2nd monitor

#change IFS
IFS=$'\n'
#horizontal starting position (2nd monitor for this setup)
x_start=1900

#get array of available browser windows
my_array=($(wmctrl -l -x | awk '/(Navigator.Firefox)|(brave-browser.Brave-browser)/ {print $1"|"$3}'))


#loop array resizing and moving windows
for i in "${my_array[@]}"
do


win_num=$(echo $i | cut -f1 -d"|")
win_type=$(echo $i | cut -f2 -d"|")
ff_windim=1320,1080
ff_winpos=-20

#adjustments for window size to match if brave browser
if [ "$win_type" == "brave-browser.Brave-browser" ] ; then
  ff_windim=1300,1072
  ff_winpos=-8
  let x_start=${x_start}+10
fi

#shell command to move and resize window
wmctrl -i -r $win_num -e 0,${x_start},${ff_winpos},${ff_windim}

#move horizontal starting position for next window
let x_start=${x_start}+1280

done
