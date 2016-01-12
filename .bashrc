# Ignore command starting with space and duplicate commands
HISTCONTROL=ignoreboth

# Append to history file
shopt -s histappend

# Maximum commands to save in history file
HISTSIZE=5000

# Maximum number of lines to save
HISTFILESIZE=10000

# Check width of term and adjust (if window size changes) after each command.
shopt -s checkwinsize

# Colored PS1
if [ "$UID" -eq 0 ]
then
    PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
fi


# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Enable bash completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
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
