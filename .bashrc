#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
# [ -z "$PS1" ] && return

TERM=xterm-color

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	   color_prompt=yes
    else
	   color_prompt=
    fi
fi

unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Load aliases
for file in $HOME/bash/bash*.aliases; do
#    echo "Loading aliases from: $file"
    . $file
done

# Load completion
for file in $HOME/bash/bash*.completion; do
 #   echo "Loading completion from: $file"
    . $file
done

export PATH=$PATH:$HOME/scripts
export PATH=/opt/local/bin:$PATH
export PATH=/opt/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/mysql/bin:$PATH
export PATH=/usr/local/git/bin:$PATH
export PATH=$PATH:$HOME/bin

export DOWNLOADS=~/Downloads
export opt=~/opt

export ANDROID_HOME=~/opt/sdk/android-sdk
export ANDROID_NDK_HOME=~/opt/sdk/android-ndk

if [[ -f /opt/vagrant/bin/vagrant ]]; then
    export PATH=/opt/vagrant/bin:$PATH
fi

source $HOME/scripts/functions.sh
source $HOME/scripts/runtime.sh
# source $HOME/scripts/install.sh

export HISTIGNORE='&:cd:ls:bin/ss;history *'

GIT_PS1_SHOWDIRTYSTATE=true

export MAVEN_OPTS="-Xmx512M -XX:MaxPermSize=512M"

# Load RVM into a shell session *as a function*
if [[ -f "/usr/local/rvm/scripts/rvm" ]]; then
    source "/usr/local/rvm/scripts/rvm"
fi
if [[ -f "$HOME/.rvm/scripts/rvm" ]]; then
    source "$HOME/.rvm/scripts/rvm"
fi

source ~/vcs/misc/z/z.sh
resetPrompt

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export ANDROID_HOME=~/opt/sdk/android-sdk
export ANDROID_NDK_HOME=~/opt/sdk/android-sdk

