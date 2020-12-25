# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/alux/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# >>> personal settings >>>

alias check="cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor"
alias apply="sudo cpupower frequency-set -g"
alias pycharm="bash /usr/bin/pycharm"  # /usr/bin/pycharm is a symlink -> usr readlink to find location, its on major part
alias clion="bash /usr/bin/CLion" # /usr/bin/CLion is a symlink -> usr readlink to find location, its on major part
alias enter_build="cd /mnt/e94f8d4a-1f50-490e-b9fb-97e94b40a0fd/Systemd/build/"
alias enter_systemd="cd /mnt/e94f8d4a-1f50-490e-b9fb-97e94b40a0fd/Systemd"
alias enter_adb="cd /mnt/e94f8d4a-1f50-490e-b9fb-97e94b40a0fd/Systemd/build/Android/"
alias ping="ping -c 5 "
alias ..="cd .."


set logloc "/mnt/e94f8d4a-1f50-490e-b9fb-97e94b40a0fd/Systemd/Logging and Rollback"
set backloc "/mnt/e94f8d4a-1f50-490e-b9fb-97e94b40a0fd/Systemd/Working Backsups/"

function restart_wifi
    wifi off
    wifi on
end
# <<< personal settings


