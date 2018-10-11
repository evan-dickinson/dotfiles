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

# sketchtool
if [ -d /Applications/Sketch.app/Contents/Resources/sketchtool/bin ]; then
    export PATH="$PATH:/Applications/Sketch.app/Contents/Resources/sketchtool/bin"
fi

# Perl / CPAN stuff
if [[ -d /Users/sesa382347/ ]]; then
	PATH="/Users/sesa382347/perl5/bin${PATH:+:${PATH}}"; export PATH;
	PERL5LIB="/Users/sesa382347/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
	PERL_LOCAL_LIB_ROOT="/Users/sesa382347/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
	PERL_MB_OPT="--install_base \"/Users/sesa382347/perl5\""; export PERL_MB_OPT;
	PERL_MM_OPT="INSTALL_BASE=/Users/sesa382347/perl5"; export PERL_MM_OPT;
fi


export HISTSIZE=1000

