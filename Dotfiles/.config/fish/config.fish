# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/alux/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# >>> personal settings >>>

set fish_greeting


# >>> Shashimi Prompt >>>
#
# Credit to : https://github.com/isacikgoz/sashimi/blob/master/fish_prompt.fish

function fish_prompt
  set -l last_status $status
  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -g red (set_color -o red)
  set -g blue (set_color -o blue)
  set -l green (set_color -o green)
  set -g normal (set_color normal)

  set -l ahead (_git_ahead)
  set -g whitespace ' '

  if test $last_status = 0
    set initial_indicator "$green◆"
    set status_indicator "$normal❯$cyan❯$green❯"
  else
    set initial_indicator "$red✖ $last_status"
    set status_indicator "$red❯$red❯$red❯"
  end
  set -l cwd $cyan(basename (prompt_pwd))

  if [ (_git_branch_name) ]

    if test (_git_branch_name) = 'master'
      set -l git_branch (_git_branch_name)
      set git_info "$normal git:($red$git_branch$normal)"
    else
      set -l git_branch (_git_branch_name)
      set git_info "$normal git:($blue$git_branch$normal)"
    end

    if [ (_is_git_dirty) ]
      set -l dirty "$yellow ✗"
      set git_info "$git_info$dirty"
    end
  end

  # Notify if a command took more than 5 minutes
  if [ "$CMD_DURATION" -gt 300000 ]
    echo The last command took (math "$CMD_DURATION/1000") seconds.
  end

  echo -n -s $initial_indicator $whitespace $cwd $git_info $whitespace $ahead $status_indicator $whitespace
end

function _git_ahead
  set -l commits (command git rev-list --left-right '@{upstream}...HEAD' ^/dev/null)
  if [ $status != 0 ]
    return
  end
  set -l behind (count (for arg in $commits; echo $arg; end | grep '^<'))
  set -l ahead  (count (for arg in $commits; echo $arg; end | grep -v '^<'))
  switch "$ahead $behind"
    case ''     # no upstream
    case '0 0'  # equal to upstream
      return
    case '* 0'  # ahead of upstream
      echo "$blue↑$normal_c$ahead$whitespace"
    case '0 *'  # behind upstream
      echo "$red↓$normal_c$behind$whitespace"
    case '*'    # diverged from upstream
      echo "$blue↑$normal$ahead $red↓$normal_c$behind$whitespace"
  end
end

function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

# <<< Shashimi Prompt <<< 


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

set workdir "/mnt/InSpace/Systemd/"
set logloc $workdir"Logging and Rollback"
set backloc $workdir"Working Backups/"
set buildbin $workdir"build/bin"
set playground $workdir"Workbench/playground"

set config "/home/alux/AluxRepo/Dotfiles/.config/fish/config.fish"
set qconfig "/home/alux/AluxRepo/Dotfiles/.config/qtile/config.py"

export SAM_CLI_TELEMETRY=0
set EDITOR 'vim'

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
