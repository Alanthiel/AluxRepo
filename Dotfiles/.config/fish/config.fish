# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/alux/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# >>> personal settings >>>

alias check="cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor"
alias apply="sudo cpupower frequency-set -g"
alias load_droid_audio="pacmd load-module module-alsa-source device=hw:0,1,0"
alias enter_build="cd /mnt/InSpace/Systemd/build"
alias enter_systemd="cd /mnt/InSpace/Systemd"
alias enter_adb="cd /mnt/InSpace/Systemd/build/android/"
alias ping="ping -c 5 "
alias ..="cd .."


set logloc "/mnt/InSpace/Systemd/Logging and Rollback"
set backloc "/mnt/InSpace/Systemd/Working Backups/"
set buildbin "/mnt/InSpace/Systemd/build/bin"
set config "/home/alux/AluxRepo/Dotfiles/fish/config.fish"

set EDITOR 'vim'

function restart_wifi
    wifi off
    wifi on
end

function update_git
	cd ~alux/AluxRepo
	git add .
	git commit
	git push -u origin master
end

function unload_droid_audio
	pactl unload-module (pactl list short modules | grep 'module-alsa-source' | awk '{print $1}')
end

# <<< personal settings <<<
