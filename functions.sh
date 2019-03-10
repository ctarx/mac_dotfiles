#!/bin/sh

# check OS #####
is_os() {
if [[ "${OSTYPE}" == $1* ]]; then
  return 0
fi
return 1
}

# COLORS #####
txtgrn=$(tput setaf 106) # Green
txtylw=$(tput setaf 172) # Yellow
txtorn=$(tput setaf 166) # Orange
txtred=$(tput setaf 124) # Red
txtblu=$(tput setaf 66)  # Blue
txtpur=$(tput setaf 132) # Purple
txtwht=$(tput setaf 246) # Grey

txtb=$(tput bold)        # Bold text
txtrst=$(tput sgr0)      # Text reset
txtudr=$(tput sgr 0 1)   # Text underline

function print { printf "\n ${txtb}${txtgrn}==> $1 ${txtrst} \n"; }
function msg_checking { printf "\n ${txtgrn}[ok]${txtrst} ${txtwht}$1${txtrst} ${txtgrn}✔${txtrst} \n"; }
function msg_update { printf "\n ${txtylw}[update]${txtrst} ${txtwht}$1${txtrst} \n\n"; }
function msg_install { printf "\n ${txtylw}[installing]${txtrst} ${txtwht}$1${txtrst} \n"; }
function msg_ok { printf "\n ${txtb}${txtgrn}[installed]${txtrst} ${txtwht}$1${txtrst} ${txtb}${txtgrn}✔${txtrst} \n"; }
function msg_note { printf "\n ${txtudr}${txtb}${txtorn}Note:${txtrst} ${txtwht}$1${txtrst} \n"; }
function msg_alert { printf "\n ${txtb}${txtred}[alert] ✖${txtrst} ${txtwht}$1${txtrst} ${txtb}${txtred}✖${txtrst} \n"; }