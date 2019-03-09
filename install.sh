#!/bin/sh

source functions.sh

DOTFILES="$HOME/.dotfiles"

# check OS #####
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
    git clone https://github.com/ctarx/dotfiles.git $DOTFILES
fi

cd $DOTFILES

# Brew #####
msg_install "Setting up Homebrew"
if test ! $(which brew); then
  msg_install "Installing homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  msg_ok 'Homebrew'
else
  msg_alert "Homebrew already instaled"
  msg_update "Updating Homebrew"
  brew update
fi


# Brew apps #####
msg_install "Installing apps with brew"
brew=(
  "git"
  "zsh"
  "zsh-completions"
  "fasd"
  "lsd"
  "ranger"
  "pcre2"
  "neovim"
  "node"
)

for app in "${brew[@]}"; do
  msg_install "Installing $app"
  brew install $app
  msg_ok "$app"
done


#  Brew Cask #####
msg_install "Installing apps with brew cask"
brew cask

cask=(
  "google-chrome"
  "firefox"
  "visual-studio-code"
  "iina"
  "cakebrew"
)

for app in "${cask[@]}"; do
  msg_install "Installing $app"
  brew cask install $app
  msg_ok "$app"
done


# .bash_profile #####
if [ -f "$HOME/.bash_profile" ]; then
    msg_update ".bash_profile"
    rm -rf ~/.bash_profile
else
    msg_install ".bash_profile"
fi

ln -s $DOTFILES/bash_profile ~/.bash_profile
msg_checking ".bash_profile"


# .bashrc #####
if [ -f "$HOME/.bashrc" ]; then
    rm -rf ~/.bashrc
else
    msg_install ".bashrc"
fi

ln -s $DOTFILES/bashrc ~/.bashrc
msg_checking ".bashrc"


# aliasrc #####
if [ -f "$HOME/.config/aliasrc" ]; then
    msg_update "aliasrc"
    rm -rf ~/.config/aliasrc
else
    msg_install ".aliases"
fi
cd ..
mkdir -p ~/.config
ln -s $DOTFILES/aliasrc ~/.config/aliasrc
msg_checking "aliasrc"


# vim #####
if [ -d "$HOME/.config/nvim" ]; then
    msg_update "nvim"
    rm -rf ~/.config/nvim
else
    msg_install "nvim"
fi
mkdir -p ~./config
ln -s $DOTFILES/nvim ~/.config/nvim
ln -sf ~/.dotfiles/nvim ~/.vim
ln -sf ~/.dotfiles/nvim/init.vim ~/.vimrc
msg_checking "nvim"


# .gitconfig #####
if [ -f "$HOME/.giconfig" ]; then
    msg_update ".gitconfig"
    rm -rf ~/.gitconfig
else
    msg_install ".gitconfig"
fi

ln -s $DOTFILES/gitconfig ~/.gitconfig
msg_checking ".gitconfig"


# .gitignore #####
if [ -f "$HOME/.gitignore" ]; then
    msg_update ".gitignore"
    rm -rf ~/.gitignore
else
    msg_install ".gitignore"
fi

ln -s $DOTFILES/gitignore ~/.gitignore
msg_checking ".gitignore"
git config --global core.excludesfile ~/.gitignore


# tmux #####
if [ -f "$HOME/.tmux.conf" ]; then
    msg_update ".tmux.conf"
    rm -rf ~/.tmux.conf
else
    msg_install ".tmux.conf"
fi

ln -s $DOTFILES/tmux.conf ~/.tmux.conf
msg_checking ".tmux.conf"


# ranger #####
if [ -d "$HOME/.config/ranger" ]; then
    msg_update ".ranger"
    rm -rf ~/.config/ranger
else
    msg_install ".ranger"
fi

ln -s $DOTFILES/ranger ~/.config/ranger
msg_checking ".ranger"


# zsh #####
if [ -f "$HOME/.zshrc" ]; then
    msg_update ".zshrc"
    rm -rf ~/.zshrc
else
    msg_install ".zshrc"
fi

ln -s $DOTFILES/zshrc ~/.zshrc
msg_checking ".zshrc"

# slimzsh
if [[ -d $HOME/.slimzsh ]]; then
    print 'Checking slimzh directory'
else
    print 'Cloning slimzsh'
    git clone --recursive https://github.com/changs/slimzsh.git ~/.slimzsh
    ln -s $DOTFILES/aliases.zsh.local ~/.slimzh/aliases.zsh.local
fi

# ~/.hushlogin suppresses the 'last login' message
rm -rf ~/.hushlogin
touch ~/.hushlogin

print 'All done'
msg 'Start using your machine'
zsh
