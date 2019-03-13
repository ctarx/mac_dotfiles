#!/usr/bin/env bash

# check OS #####
is_os() {
if [[ "${OSTYPE}" == $1* ]]; then
  return 0
fi
return 1
}

# COLORS #####
green=$(tput setaf 106)   # Green
yellow=$(tput setaf 172)  # Yellow
#orange=$(tput setaf 166)  # Orange
red=$(tput setaf 124)     # Red
blue=$(tput setaf 66)      # Blue
#purple=$(tput setaf 132)  # Purple
#grey=$(tput setaf 246)    # Grey

bold=$(tput bold)         # Bold text
reset=$(tput sgr0)        # Text reset


print() {
  printf "\n ${bold}${green}==>${reset} %b\n" "$1"
  }

msg_checking() {
  printf "${green}✔ [ok]${reset} %b\n" "$1"
  }

msg_update() {
  printf "${yellow} [update]${reset} %b\n" "$1"
  }

msg_ok() {
  printf "${green}✔ [installed]${reset} %b\n" "$1"
}

msg_install() {
  printf "${yellow} [installing]${reset} %b\n" "$1"
}

msg_alert() {
  printf "${red}✖ [error]${reset} %b\n" "$1"
}

msg_info() {
  printf "${bold}${blue}▲ [info]${reset} %b\n" "$1"
}


