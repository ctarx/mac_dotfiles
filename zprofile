#!/bin/zsh

# zsh profile file. Runs on login. Environmental variables are set here.

# If you don't plan on reverting to bash, you can remove the link in ~/.profile
# to clean up.

# Adds `~/.local/bin` to $PATH
#export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | paste -sd ':')"
export PATH="$PATH:$HOME/.local/bin:/usr/local/bin:/usr/bin:usr/local/sbin:/usr/local/opt"

# Default programs:
export EDITOR="nvim"
export TERMINAL="iterm2"
export BROWSER="brave"
export READER="preview"

# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

