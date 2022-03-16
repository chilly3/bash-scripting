#! /bin/bash

#open gnome-clocks and use wmctrl and xdotool to activate the window, select the stopwatch tab, and begin the count


gnome-clocks &
sleep 1

win_id=$(wmctrl -l -x | awk '/org.gnome.clocks.Org.gnome.clocks/ {print $1}')
xdo_id=$(printf "%d\n" $win_id)

xdotool windowactivate $xdo_id
xdotool key ctrl+alt+Page_Down ctrl+alt+Page_Down ctrl+alt+Page_Down ctrl+alt+Page_Up Return
