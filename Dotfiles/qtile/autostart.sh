#! /bin/bash 
picom --experimental-backends &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &	# Gnome Polkit - Authentation Agent
nitrogen --restore 
