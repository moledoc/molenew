export PATH="$HOME/.scripts:/usr/local/go/bin:$HOME/.AppImages:/.local/bin:/usr/local/bin:$PATH"
export PATH=$(go env GOPATH)/bin:$PATH
export GOPATH=$(go env GOPATH)$(go env GOPATH$(go env GOPATH))
export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=vim
export TERMINAL=gnome-terminal
export BROWSER=google-chrome
export ELEVATE="doas --"
. "$HOME/.bashrc"
