#!/bin/bash
mkdir -p "$HOME/bash"
mkdir -p "$HOME/scripts"
mkdir -p "$HOME/vcs/misc"

function installBashThings
{
  safeInstall .bashrc ~/.bashrc
  safeInstall .bash_profile ~/.bash_profile
  safeInstall .dircolors ~/.dircolors

  for file in bash/*; do
    safeInstall $file ~/$file
  done

  for file in scripts/*; do
    safeInstall $file ~/$file
  done  
}

function install-z
{
  if [[ ! -d ~/vcs/misc/z ]]; then
    git clone git://github.com/rupa/z.git ~/vcs/misc/z
  fi
}

installBashThings
install-z

