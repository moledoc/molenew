# program env variables
export LESS="-R"
export PATH=$PATH:/usr/sbin:/usr/local/bin:$HOME/.scripts:$HOME/.AppImages:$HOME/go/bin:/usr/local/go/bin
export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=vi
export TERMINAL=st
export TERM=st
# export BROWSER="google-chrome"
export BROWSER="chromium"
export ELEVATE="doas --" # sudo
export HISTSIZE=10000
# export HISTCONTROL=ignoreboth # for zsh
## self defined env variables
export MAX_BRIGHTNESS=$(cat /sys/class/backlight/*/max_brightness)
export BRIGHTNESS_STEP=$(echo $(($MAX_BRIGHTNESS/20)))
export SOUND_STEP="5%"

alias todo="$EDITOR $HOME/todo"
