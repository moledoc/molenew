# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '+' '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/utt/.zshrc'

autoload -Uz compinit
zmodload zsh/complist
compinit
_comp_options+=(globdots)

autoload -Uz promptinit
promptinit

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd extendedglob notify
unsetopt beep
bindkey -v
export KEYTIMEOUT=1
# End of lines configured by zsh-newuser-install

##############
# Self defined

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Edit command in vim w/ ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Map moving in tab complete to vim keys
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
PS1="$USER@%M %F{green}%~%f%F{yellow}$(parse_git_branch)%f
$ "

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias update="${ELEVATE} apt update;${ELEVATE} apt full-upgrade;alert"
alias install="${ELEVATE} apt install"
alias debinstall="${ELEVATE} dpkg -i"
alias dryinstall="${ELEVATE} apt install --dry-run"
alias uninstall="${ELEVATE} apt remove --auto-remove"
alias purge="${ELEVATE} apt purge"
alias autoremove="${ELEVATE} apt autoremove"
alias search="apt search"
alias show="apt show"
alias list="apt list"
alias installed="apt list --installed"
alias upgradable="apt list --upgradeable"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -1F --color=always'
    alias grep='grep --color=always -I --exclude=tags --exclude-dir=.git'
    alias fgrep='fgrep --color=always -I --exclude=tags --exclude-dir=.git'
    alias egrep='egrep --color=always -I --exclude=tags --exclude-dir=.git'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alhF'
alias la='ls -Ah'
alias l='ls -CF'

# movement/[cp|mv|rm]
alias b="cd .."
alias p="cd -"
alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -iv"

# directories
alias repo="cd $HOME/Documents/molecurrent"
alias dl="cd $HOME/Downloads"
alias doc="cd $HOME/Documents"
alias g="cd $HOME/go/src/github.com/moledoc"

# files
alias cfz="$EDITOR $HOME/.zshrc"
alias cfv="$EDITOR $HOME/.vimrc"
alias srcz="source $HOME/.zshrc"
alias srcv="source $HOME/.vimrc"
alias todo="$EDITOR $HOME/todo"

# systemctl
alias sd="$ELEVATE systemctl poweroff"
alias po="$ELEVATE systemctl poweroff"
alias rb="$ELEVATE systemctl reboot"

# utilities
alias wget="wget --show-progress"

# # git
# alias ga="git add"
# alias gb="git branch"
# alias gc="git commit"
# alias gco="git checkout"
# alias gd="git diff"
# alias gl="git log"
# alias gm="git merge"
# alias gp="git push"
# alias gpu="git pull"
# alias gr="git reset"
# alias gs="git status"
# alias gbc="git branch --show-current"

# # go
# alias goi="go install"
# alias gor="go run"
# alias gob="go build"
# alias goc="go clean"
# alias got="go test -v -cover"
# alias gobw="GOOS=windows GOARCH=amd64 go build"
# alias gopt="cd ~/go;vim -c \"q\" test.go;exit"

# # docker 
# alias ds="$ELEVATE docker ps"
# alias dr="$ELEVATE docker run"
# alias dre="$ELEVATE docker restart"
# alias dst="$ELEVATE docker stop"
# alias drm="$ELEVATE docker rm"
