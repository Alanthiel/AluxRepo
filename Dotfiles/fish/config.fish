# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/alux/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# >>> personal settings >>>

alias check="cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor"
alias apply="sudo cpupower frequency-set -g"
alias enter_build="cd /mnt/InSpace/Systemd/build"
alias enter_systemd="cd /mnt/InSpace/Systemd"
alias enter_adb="cd /mnt/InSpace/Systemd/build/android/"
alias ping="ping -c 5 "
alias ..="cd .."


set logloc "/mnt/InSpace/Systemd/Logging and Rollback"
set backloc "/mnt/InSpace/Systemd/Working Backups/"

function restart_wifi
    wifi off
    wifi on
end
# <<< personal settings


