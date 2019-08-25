#!/bin/sh

source functions.sh

DOTFILES="$HOME/.dotfiles"
VSCDIR=$HOME/Library/Application\ Support/Code/User

printf "${purple}
     _             ___ _ _
    | |      _    / __|_) |
  _ | | ___ | |_ | |__ _| | ____  ___
 / || |/ _ \|  _)|  __) | |/ _  )/___)
( (_| | |_| | |__| |  | | ( (/ /|___ |
 \____|\___/ \___)_|  |_|_|\____|___/

  ${green}==> Setup for macOS <==

-------------------------------------
${yellow}● ${green}personal dotfiles
${yellow}● ${green}and base configuration files\n
${yellow}https://github.com/ctarx/dotfiles${reset}
${green}-------------------------------------
${reset}"

# checking OS #####
print 'Checking OS'
  if is_os "darwin"; then
    msg_checking "You are on a macOS"
  else
    msg_alert "You are not on a macOS"
    exit 1
  fi


# clone repo #####
  if [[ -d $DOTFILES ]]; then
    print 'Checking dotfiles directory'
  else
    print 'Cloning dotfiles'
    git clone --recursive https://github.com/ctarx/dotfiles.git "$DOTFILES"
  fi

cd "$DOTFILES" || exit

# Brew #####
print "Setting up Homebrew"
  if test ! "$(command -v which brew)"; then
    msg_install "Installing Homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    msg_ok 'Homebrew'
  else
    msg_alert "Homebrew already installed"
    msg_update "Updating Homebrew"
    brew update
  fi


# Brew apps #####
print "Installing apps with brew"
BREW_PACKAGES=( git fasd lsd vifm pcre2 neovim node zsh zsh-completions bash bash-completion@2 )

for app in "${BREW_PACKAGES[@]}"; do
  msg_checking "Checking package $app"
  if test ! "$(brew list | grep "$app")"; then
    msg_install "$app"
    brew install "$app"
  else
  msg_ok "$app"
  fi
done
print "Homebrew packages installed"


#  Brew Cask #####
print "Installing apps with brew cask"
cask=( google-chrome firefox visual-studio-code iina cakebrew )

for app in "${cask[@]}"; do
  msg_checking "Checking application $app"
  if test ! "$(brew cask list | grep "$app")"; then
  msg_install "Installing $app"
  brew cask install "$app"
  else
  msg_ok "$app"
  fi
done
print "Homebrew cask applications installed"


print 'Checking dotfiles'
# .bash_profile #####
  if [[ -f "$HOME/.bash_profile" ]]; then
    msg_update ".bash_profile"
    rm -rf ~/.bash_profile
  else
    msg_install ".bash_profile"
  fi

  ln -s "$DOTFILES/bash_profile" ~/.bash_profile
  msg_checking ".bash_profile"


# .bashrc #####
  if [[ -f "$HOME/.bashrc" ]]; then
    msg_update ".bashrc"
    rm -rf ~/.bashrc
  else
    msg_install ".bashrc"
  fi

  ln -s "$DOTFILES/bashrc" ~/.bashrc
  msg_checking ".bashrc"


# aliasrc #####
  if [[ -f "$HOME/.config/aliasrc" ]]; then
    msg_update "aliasrc"
    rm -rf ~/.config/aliasrc
  else
    msg_install ".aliases"
  fi

  ln -s "$DOTFILES/aliasrc" ~/.config/aliasrc
  msg_checking "aliasrc"


# vim #####
  if [[ -d "$HOME/.config/nvim" ]]; then
    msg_update "nvim"
    rm -rf ~/.config/nvim
    rm -rf ~/.vim
    rm -rf ~/.vimrc
  else
    msg_install "nvim"
  fi

  ln -s "$DOTFILES/nvim" ~/.config/nvim
  ln -sf ~/.dotfiles/nvim ~/.vim
  ln -sf ~/.dotfiles/nvim/init.vim ~/.vimrc
  msg_checking "nvim"


# vscode #####
  if [[ -f "$VSCDIR/settings.json" ]]; then
    msg_update "vscode settings"
    rm -rf "$VSCDIR/settings.json"
  else
    msg_install "vscode setings"
  fi
  ln -sf "$DOTFILES/settings.json" "$VSCDIR/settings.json"
  msg_checking "vscode settings"



# .gitconfig #####
  if [[ -f "$HOME/.gitconfig" ]]; then
    msg_update ".gitconfig"
    rm -rf ~/.gitconfig
  else
    msg_install ".gitconfig"
  fi

  ln -s "$DOTFILES/gitconfig" ~/.gitconfig
  msg_checking ".gitconfig"


# .gitignore #####
  if [[ -f "$HOME/.gitignore" ]]; then
    msg_update ".gitignore"
    rm -rf ~/.gitignore
  else
    msg_install ".gitignore"
  fi

  ln -s "$DOTFILES/gitignore" ~/.gitignore
  msg_checking ".gitignore"
  git config --global core.excludesFile "$HOME/.gitignore"



# tmux #####
  if [[ -f "$HOME/.tmux.conf" ]]; then
    msg_update ".tmux.conf"
    rm -rf ~/.tmux.conf
  else
    msg_install ".tmux.conf"
  fi

  ln -s "$DOTFILES/tmux.conf" ~/.tmux.conf
  msg_checking ".tmux.conf"


# ranger #####
  if [[ -d "$HOME/.config/ranger" ]]; then
    msg_update "ranger"
    rm -rf ~/.config/ranger
  else
    msg_install "ranger"
  fi

  ln -s "$DOTFILES/ranger" ~/.config/ranger
  msg_checking "ranger"


# vifm #####
  if [[ -d "$HOME/.config/vifm" ]]; then
    msg_update "vifm"
    rm -rf ~/.config/vifm
  else
    msg_install "vifm"
  fi

  ln -s "$DOTFILES/vifm" ~/.config/vifm
  msg_checking "vifm"


# zsh #####
  if [[ -f "$HOME/.zshrc" ]]; then
    msg_update ".zshrc"
    rm -rf ~/.zshrc
  else
    msg_install ".zshrc"
  fi

  ln -s "$DOTFILES/zshrc" ~/.zshrc
  msg_checking ".zshrc"


# slimzsh
  if [[ -d $HOME/.slimzsh ]]; then
    print 'Checking slimzh directory'
  else
    print 'Cloning slimzsh'
    git clone --recursive https://github.com/changs/slimzsh.git ~/.slimzsh
  fi

  rm -rf ~/.slimzsh/aliases.zsh.local
  touch ~/.slimzsh/aliases.zsh.local
  echo '[[ -f "$HOME/.config/aliasrc" ]] && source "$HOME/.config/aliasrc"' >> ~/.slimzsh/aliases.zsh.local


# ~/.hushlogin suppresses the 'last login' message
  touch ~/.hushlogin

print "All done!"
msg_info "Start using your machine."
