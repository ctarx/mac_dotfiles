#!/bin/sh

source functions.sh

DOTFILES="$HOME/.dotfiles"

# checking OS #####
print 'Checking OS'
  if is_os "darwin"; then
    msg_checking "You are on a macOS"
  else
    msg_alert "You are not on a macOS"
    exit 1
  fi

# vifm #####
  if [ -d "$HOME/.config/vifm" ]; then
    msg_update "vifm"
    rm -rf ~/.config/vifm
  else
    msg_install "vifm"
  fi

  ln -s $DOTFILES/vifm ~/.config/vifm
  msg_checking "vifm"

