#!/usr/bin/env bash
#   _               _
#  | |__   __ _ ___| |__  _ __ ___
#  | '_ \ / _` / __| '_ \| '__/ __|
#  | |_) | (_| \__ \ | | | | | (__
#  |_.__/ \__,_|___/_| |_|_|  \___|
#

HISTSIZE=HISTFILESIZE=     # Infinite history.
SHELL_SESSION_HISTORY=0


export PATH="/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/local/opt:$PATH"
export EDITOR="nvim"

##### Bash prompt

# colors
green=$(tput setaf 106)   # Green
yellow=$(tput setaf 172)  # Yellow
blue=$(tput setaf 66)      # Blue
purple=$(tput setaf 132)  # Purple
grey=$(tput setaf 246)    # Grey

bold=$(tput bold)         # Bold text
reset=$(tput sgr0)        # Text reset

# get current branch in git repo
function parse_git_branch() {
	BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
	if [ ! "${BRANCH}" == "" ]
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

export PS1="${blue}●${yellow}\`parse_git_branch\` ${bold}${grey}\W ${reset}\n${bold}${purple}❯ ${reset}"

##### SHELL OPTIONS

# Make bash check its window size after a process completes
shopt -s checkwinsize

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Allows to cd into a dir by just typing the dir name
shopt -s autocd

#[ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"

#Bash completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# Load aliases
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
