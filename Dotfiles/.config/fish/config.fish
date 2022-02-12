# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/alux/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# >>> personal settings >>>

set fish_greeting
set repoloc "/home/alux/repos/AluxRepo"

# Directories setup
set workdir "/home/alux/workbench/"
set logloc $workdir"System/Logging and Rollback"
set backloc $workdir"System/Working Backups/"
set buildbin $workdir"build/bin"
set playground $workdir"playground"
set Internal_Resources "$HOME/internal-resources"

# Quick Config Variables
set config "/home/alux/repos/AluxRepo/Dotfiles/.config/fish/config.fish"
set qconfig "/home/alux/repos/AluxRepo/Dotfiles/.config/qtile/config.py"

# Quick Entry Aliases
alias enter_build="cd $workdir/build"
alias enter_systemd="cd $workdir/Systemd"
alias mynotes="cd $HOME/repos/crispy-journey"
alias check="cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor"
alias apply="sudo cpupower frequency-set -g"

# External Command Aliases
alias reset_mps='rm ~/.config/mps-youtube/cache_py*'
alias load_droid_audio="pacmd load-module module-alsa-source device=hw:0,1,0"

# Command Replacements / Flag setups
alias ping="ping -c 5 "
alias ..="cd .."
alias grep="grep --color=always"

alias cat="bat"

alias tree="exa --tree --icons"
alias ls="exa"
alias la="exa -la"
alias ll="exa -l"
set -xU MANPAGER 'less -R --use-color -Dd+r -Du+b'

# Aliases Commands
alias jloc='curl https://json.geoiplookup.io/(curl https://ipinfo.io/ip) | jq'
alias import-docker-scr="source $repoloc/scripts/fish-scr/docker_scr.fish"
alias emptyfolder="rm -r *"
alias cettime="env TZ=CET date"
alias launchsshagent="eval (ssh-agent -s | sed 's/export.*;//g' | sed 's/SSH_AUTH_SOCK=/export SSH_AUTH_SOCK=/g' | sed 's/SSH_AGENT_PID=/export SSH_AGENT_PID=/g')"

#Application Settings
export DOCKER_BUILDKIT=1
export SAM_CLI_TELEMETRY=0
set EDITOR 'vim'

# >>> promt settings:

set SPACEFISH_CONDA_SHOW false
set SPACEFISH_EXIT_CODE_SHOW true
set SPACEFISH_DIR_TRUNC 2
set SPACEFISH_USER_SHOW true
set SPACEFISH_CHAR_SYMBOL »
set SPACEFISH_EXIT_CODE_SYMBOL 𐩾

export PATH="$PATH:$HOME/.cargo/bin:$HOME/.local/symlinks"

function macrofile
	source ~/resources/macros/$argv
end

function awsregion:
	export AWS_DEFAULT_REGION=$argv
end

function enter_proj
	cd /home/alux/workbench/Projects/$argv
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

function importgitkey
	eval (ssh-agent -s | sed 's/export.*;//g' | sed 's/SSH_AUTH_SOCK=/export SSH_AUTH_SOCK=/g' | sed 's/SSH_AGENT_PID=/export SSH_AGENT_PID=/g') 
	if not set -q argv[1] #Check if any arguments are passed to function
		ssh-add $Internal_Resources/keys/dev_id_rsa
	else
		ssh-add $argv
	end
end


# <<< personal settings <<<
