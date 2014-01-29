#!/bin/bash

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/home/ags/.gvm/bin/gvm-init.sh" ]] && source "/home/ags/.gvm/bin/gvm-init.sh"
