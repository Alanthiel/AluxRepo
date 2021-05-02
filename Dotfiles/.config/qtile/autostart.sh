#! /bin/bash 
picom --experimental-backends &
clipmenud &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &	# Gnome Polkit - Authentation Agent
nitrogen --restore &
xdotool key Num_Lock
