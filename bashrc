#!/usr/local/bin/bash
#   _               _
#  | |__   __ _ ___| |__  _ __ ___
#  | '_ \ / _` / __| '_ \| '__/ __|
#  | |_) | (_| \__ \ | | | | | (__
#  |_.__/ \__,_|___/_| |_|_|  \___|
#

# HISTORY
SHELL_SESSION_HISTORY=0
# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"


# PATH
export PATH="$HOME/.local/bin:$PATH";

# Default programs:
export EDITOR="nvim"
export TERMINAL="iterm2"
export BROWSER="brave"
export READER="preview"


# color
export CLICOLOR=1

##### Bash prompt #####

# colors
green=$(tput setaf 106)   # Green
yellow=$(tput setaf 172)  # Yellow
blue=$(tput setaf 66)     # Blue
purple=$(tput setaf 132)  # Purple
grey=$(tput setaf 246)    # Grey

bold=$(tput bold)         # Bold text
reset=$(tput sgr0)        # Text reset

# get current branch in git repo
function parse_git_branch() {
	BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
	if [[ ! "${BRANCH}" == "" ]]
	then
		STAT=$(parse_git_dirty)
		echo " (${BRANCH}${STAT})"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=$(git status 2>&1 | tee)
	dirty=$(echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?")
	up_to_date=$(echo -n "${status}" 2> /dev/null | grep "working tree clean" &> /dev/null; echo "$?")
	ahead=$(echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?")
	parts=''

	if [ "${ahead}" == "0" ]; then
		parts="▲${parts}"
	fi

	if [ "${up_to_date}" == "0" ]; then
		parts="✓${parts}"
	fi

	if [ "${dirty}" == "0" ]; then
		parts="✗${parts}"
	fi

	if [ ! "${parts}" == "" ]; then
		echo " ${parts}"
	else
		echo ""
	fi
}

PS1="\[$blue\]●"                        # Separator
PS1+="\[$yellow\]\`parse_git_branch\`"  # GIT repository
PS1+=" \[$bold\]\[$blue\]\w"              # working directory
PS1+="\[$reset\]\n"                     # reset and new line
PS1+="\[$bold\]\[$purple\]❯ \[$reset\]"     # prompt sign and reset

export PS1;

##### SHELL OPTIONS #####

# Make bash check its window size after a process completes
shopt -s checkwinsize

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Allows to cd into a dir by just typing the dir name
shopt -s autocd


#Bash completion
[ -r "/usr/local/etc/profile.d/bash_completion.sh" ] && . "/usr/local/etc/profile.d/bash_completion.sh"

#brew completions in bash
if type brew &>/dev/null; then
  for COMPLETION in $(brew --prefix)/etc/bash_completion.d/*
  do
    [ -f $COMPLETION ] && source "$COMPLETION"
  done
  if [ -f $(brew --prefix)/etc/profile.d/bash_completion.sh ];
  then
    source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
  fi
fi

# Load aliases
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc"
