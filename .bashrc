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

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
