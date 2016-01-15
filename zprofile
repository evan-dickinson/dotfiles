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


# MacPorts Installer addition on 2016-01-14_at_16:38:19: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

