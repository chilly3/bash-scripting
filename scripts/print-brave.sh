#!/bin/bash
#script for capturing brave browser window and automatically saving to specified location (Desktop/compTIA)

#filenumber variable for first file
brave_number=01

#section variable for comptia videos
brave_section=$(wmctrl -l -x | awk '/brave-browser.Brave-browser/ {$1=$2=$3=$4=""; print $(NF-4)}' | awk '{gsub(/\./,"_"); print}')

#parent directory for saved screen captures
parent_dir=~/Desktop/compTIA/

#save file directory
save_dir="${parent_dir}${brave_section}/"

#conditional to make directory if it doesn't exist
dir_array=($(ls ${parent_dir} | grep -E '^[0-9]{1,2}'))
for i in "${dir_array[@]}"
do
  if [ ! -d "$i" ] ; then
    mkdir -p ${save_dir}
  fi
done

#array of files in directory
file_array=($(ls ${save_dir} | grep -Eo '[0-9]{1,2}'))

#conditional to check directory for current file number
for i in "${file_array[@]}"
do
  if [ "$i" ] ; then
    brave_number=$(expr ${file_array[-1]} + 1)
    brave_number=$(printf "%02d\n" ${brave_number})
  fi
done



#get window id for brave browser
brave_win=$(wmctrl -l -x | awk '/brave-browser.Brave-browser/ {print $1}')
#get window title | remove everything from "-" on | remove trailing whitespace; replace spaces with "-" for filename.png
brave_title=$(wmctrl -l -x | awk '/brave-browser.Brave-browser/ {print $1=$2=$3=$4=""; print $0}' | cut -f1 -d"-" | xargs);brave_title=$(echo "${brave_title// /-}_${brave_number}.png")

#capture screen
import -window $brave_win $save_dir$brave_title
