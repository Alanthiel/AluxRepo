#! /bin/bash 
picom --experimental-backends &
dunst &
clipmenud &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &	# Gnome Polkit - Authentation Agent
nitrogen --restore &
xdotool key Num_Lock
