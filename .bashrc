## History related settings
shopt -s histappend # Append to history file
HISTCONTROL=ignoreboth # Ignore commands that begin with space/are duplicate
HISTSIZE=5000 # Maximum commands to save in history file
HISTFILESIZE=10000 # Maximum number of lines to save

# Autocorrect cd typos
shopt -s cdspell

# Check width of term and adjust (if window size changes) after each command.
shopt -s checkwinsize

# Logged in via ssh?
if [ -n "$SSH_CLIENT" ]
then
    REMOTE_PS1="(ssh)"
fi

# Colored PS1
# If user is `root' set color as red, else green
if [ "$UID" -eq 0 ]
then
    PS1='\[\033[01;31m\]\u@\h\[\033[01;35m\]${REMOTE_PS1}\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='\[\033[01;32m\]\u@\h\[\033[01;35m\]${REMOTE_PS1}\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
fi

# Set Term title
case "$TERM" in
    xterm*|rxvt*)
	PS1="\[\e]0;\u@\h${REMOTE_PS1}: \w\a\]$PS1"
	;;
    *)
	;;
esac

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Enable bash completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Some more bashrc
if [ -f ~/.bash/bashrc ]
then
    . ~/.bash/bashrc
fi


# Include the contents of `.bash_aliases'
if [ -f ~/.bash_aliases ]
then
    . ~/.bash_aliases
fi

# My Personal aliases
if [ -f ~/.bash/aliases ]
then
    . ~/.bash/aliases
fi

# Include your personal scripts and confs here
# This file won't be overwritten by the update script
if [ -f ~/.bash/personal ]
then
    . ~/.bash/personal
fi
