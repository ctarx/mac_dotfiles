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
BREW_PACKAGES=( git fasd lsd vifm pcre2 neovim node zsh zsh-completions htop youtube-dl )

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
cask=( brave-browser visual-studio-code iina cakebrew alacritty mudlet bitwarden telegram discord amethyst syncthing dropbox steam malwarebytes teamviewer electrum tor-browser balenaetcher battle-net virtualbox )

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


# zsh #####
  if [[ -f "$HOME/.zshrc" ]]; then
    msg_update ".zshrc"
    rm -rf ~/.zshrc
  else
    msg_install ".zshrc"
  fi

  ln -s "$DOTFILES/zsh" ~/.config/zsh
  msg_checking ".zshrc"

# zprofile #####
  if [[ -f "$HOME/.zprofile" ]]; then
    msg_update ".zprofile"
    rm -rf ~/.zprofile
  else
    msg_install ".zprofile"
  fi

  ln -s "$DOTFILES/zprofile" ~/.zprofile
  ln -s ~/.zprofile ~/.profile
  msg_checking ".zprofile"

# aliasrc #####
  if [[ -f "$HOME/.config/aliasrc" ]]; then
    msg_update "aliasrc"
    rm -rf ~/.config/aliasrc
  else
    msg_install "aliases"
  fi

  ln -s "$DOTFILES/aliasrc" ~/.config/aliasrc
  msg_checking "aliasrc"


# shortcutrc #####
  if [[ -f "$HOME/.config/shortcutrc" ]]; then
    msg_update "shortcutrc"
    rm -rf ~/.config/shortcutrc
  else
    msg_install "shortcuts"
  fi

  ln -s "$DOTFILES/shortcutrc" ~/.config/shortcutrc
  msg_checking "shortcutrc"


# neovim #####
  if [[ -d "$HOME/.config/nvim" ]]; then
    msg_update "nvim"
    rm -rf ~/.config/nvim
    rm -rf ~/.vim
    rm -rf ~/.vimrc
  else
    msg_install "nvim"
  fi

  ln -s "$DOTFILES/nvim" ~/.config/nvim
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


# ~/.hushlogin suppresses the 'last login' message
  touch ~/.hushlogin


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

print "All done!"
msg_info "Start using your machine."
