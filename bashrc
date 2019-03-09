#      __               __
#     / /_  ____ ______/ /_  __________
#    / __ \/ __ `/ ___/ __ \/ ___/ ___/
#   / /_/ / /_/ (__  ) / / / /  / /__
#  /_.___/\__,_/____/_/ /_/_/   \___/
#

HISTSIZE= HISTFILESIZE= # Infinite history.
SHELL_SESSION_HISTORY=0

# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

# Bash prompt
# \u	The current user
# \w	The current working directory
# \W	The last fragment of the current working directory.
# \h	The name of the computer, upto a dot(.).
# \H	The full hostname
# \d	The date in “Weekday Month Date” format (e.g.”Tue 21 July”)
# \t	The current time in 24 hour HH:MM:SS format
# \T	The current time in 12 hour HH:MM:SS format
# \@	The current time in 12-hour AM/PM format
# \n	Move on to the next line.
# export PS1="\u@\h\w: "

PS1="\n\[$(tput sgr0)\]\[\033[38;5;75m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\n\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;206m\]>\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

# Make bash check its window size after a process completes
shopt -s checkwinsize

#[ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"

# Load aliases
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
