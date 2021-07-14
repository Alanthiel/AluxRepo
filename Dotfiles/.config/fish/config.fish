# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/alux/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# >>> personal settings >>>

set fish_greeting
alias enter_build="cd /mnt/InSpace/Systemd/build"
alias enter_systemd="cd /mnt/InSpace/Systemd"
alias enter_adb="cd /mnt/InSpace/Systemd/build/android/"

alias check="cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor"
alias apply="sudo cpupower frequency-set -g"

alias reset_mps='rm ~/.config/mps-youtube/cache_py*'
alias load_droid_audio="pacmd load-module module-alsa-source device=hw:0,1,0"
alias ping="ping -c 5 "
alias ..="cd .."
alias grep="grep --color=always"

alias cat="bat"

alias tree="exa --tree --icons"
alias ls="exa"
alias la="exa -la"
alias ll="exa -l"

alias jloc='curl https://json.geoiplookup.io/(curl https://ipinfo.io/ip) | jq'

set workdir "/mnt/InSpace/Systemd/"
set logloc $workdir"Logging and Rollback"
set backloc $workdir"Working Backups/"
set buildbin $workdir"build/bin"
set playground $workdir"Workbench/playground"

set config "/home/alux/AluxRepo/Dotfiles/.config/fish/config.fish"
set qconfig "/home/alux/AluxRepo/Dotfiles/.config/qtile/config.py"

export SAM_CLI_TELEMETRY=0
set EDITOR 'vim'

# >>> promt settings:

set SPACEFISH_CONDA_SHOW false 
set SPACEFISH_EXIT_CODE_SHOW true
set SPACEFISH_DIR_TRUNC 1
set SPACEFISH_USER_SHOW true
set SPACEFISH_PROMPT_SEPARATE_LINE false

function restart_wifi
    wifi off
    wifi on
end

function update_git
	set path (pwd)
	cd ~alux/AluxRepo
	git add .
	git commit
	git push -u origin master
	cd $path
end

function set-inpl
  /home/alux/.config/inpl/set.py $argv
end

function __fish_command_not_found_handler --on-event fish_command_not_found
    __fish_default_command_not_found_handler $argv[1]
end

function visplay
	mpv --config=no --quiet --vo=tct --lavfi-complex='[aid1]asplit[ao][a1];[a1]showwaves=mode=cline:colors=white:rate=25[vo]' $argv
end

function unload_droid_audio
	pactl unload-module (pactl list short modules | grep 'module-alsa-source' | awk '{print $1}')
end

# <<< personal settings <<<

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/mnt/InSpace/Systemd/build/google-cloud-sdk/path.fish.inc' ]; . '/mnt/InSpace/Systemd/build/google-cloud-sdk/path.fish.inc'; end
