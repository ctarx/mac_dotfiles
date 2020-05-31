#.zshrc

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors

PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

setopt autocd	  	# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.

unsetopt prompt_cr prompt_sp  # Removing % sign in iterm2

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Load aliases
[[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc" ]] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc"
[[ -f "$HOME/.config/aliasrc" ]] && source "$HOME/.config/aliasrc"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Git Prompt Settings
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{yellow}(%b)%r%f'
zstyle ':vcs_info:*' enable git

# vi mode
bindkey -v
#export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

fpath+=${ZDOTDIR:-~}/.zsh_functions
