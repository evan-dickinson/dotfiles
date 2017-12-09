##########################
# ZSH profile


# define aliases
alias h=history
alias ht='history | tail'
alias ll='ls -l'

# Typo aliases
#
alias maek=make
alias sl=ls
alias wpd=pwd

#
# Make a dir and cd to it
mkcd() {
    mkdir $1
    cd $1
}

#
# ls
alias ls='ls -F'

# Prompt
export PROMPT='%n:%3C %# '

# avoid vi if possible
if [ -f /usr/bin/nano ]; then
    export EDIT="/usr/bin/nano -w"
    export EDITOR="/usr/bin/nano -w"
elif [ -f /usr/bin/pico ]; then
    export EDIT="/usr/bin/pico -w"
    export EDITOR="/usr/bin/pico -w"
else
    export EDIT="/bin/vi"
    export EDITOR="/bin/vi"
fi

# Search history with up and down keys
# http://unix.stackexchange.com/a/97844
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

bindkey -M emacs '^P' history-beginning-search-backward
bindkey -M emacs '^N' history-beginning-search-forward


# MacPorts Installer addition on 2016-01-14_at_16:38:19: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# Mercury
if [ -d $HOME/Apps/mercury-14.01.1/bin ]; then
    export PATH="$PATH:$HOME/Apps/mercury-14.01.1/bin"
fi

# ~/bin
if [ -d $HOME/bin ]; then
    export PATH="$PATH:$HOME/bin"
fi
