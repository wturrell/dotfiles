#!/bin/bash
#
# (1) copy to a bin folder you use.
#   i.e.  ~/bin/ssh.color.sh
#
# (2) set: alias ssh=~/bin/ssh.color.sh
# 
# (3) Add some hostname color profiles (see 'profiles=(' below)
#
# Inspired from http://talkfast.org/2011/01/10/ssh-host-color
# AND
# https://gist.github.com/pol/773849
#

#######################################
# RGB Color definitions in the
#   form r,g,b (comma delim, no spaces)
#######################################
BLACK="0 0 0"
WHITE="255 255 255"
RED="40 0 0"
GREEN="0 40 0"
BLUE="0 0 40"
GREY="64 64 64"
YELLOW="153 153 0"

set_term_bgcolor(){
  local R=$1
  local G=$2
  local B=$3
  /usr/bin/osascript <<EOF
tell application "iTerm"
  tell current session of current window
      set background color to {$(echo "scale=2; ($1/255.0)*65535" | bc),$(echo "scale=2; ($2/255.0)*65535" | bc),$(echo "scale=2; ($3/255.0)*65535" | bc)}
  end tell
end tell
EOF
}

# staging/preview (amber)
if [[ "$@" =~ goodwood_staging 
   || "$@" =~ credo_charms ]]; then
  echo -ne "\033]6;1;bg;red;brightness;255\a"
  echo -ne "\033]6;1;bg;green;brightness;165\a"
  echo -ne "\033]6;1;bg;blue;brightness;0\a"
  
  # if you wanted to change the actual window back colour
  # set_term_bgcolor $YELLOW 

# production (red)
elif [[ "$@" =~ credo_care
     || "$@" =~ credo_base
     || "$@" =~ credo_portal
     || "$@" =~ facebook
     || "$@" =~ fsd2
     || "$@" =~ portal.credocare.co.uk
     || "$@" =~ credobase.credocare.co.uk
     || "$@" =~ aldeburgh
     || "$@" =~ goodwood
     || "$@" =~ woodstockrd
     || "$@" =~ turtle2
]]; then
  echo -ne "\033]6;1;bg;red;brightness;153\a"
  echo -ne "\033]6;1;bg;green;brightness;0\a"
  echo -ne "\033]6;1;bg;blue;brightness;0\a"
fi

ssh $@

# go back to black afterwards

set_term_bgcolor 0 0 0

echo -ne "\033]6;1;bg;*;default\a"
