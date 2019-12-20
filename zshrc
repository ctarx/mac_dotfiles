#
# User configuration sourced by interactive shells
#

# Define zim location
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Start zim
[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh

export PATH="$PATH:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/local/opt"
export EDITOR="nvim"

# Load aliases
[[ -f "$HOME/.config/aliasrc" ]] && source "$HOME/.config/aliasrc"
