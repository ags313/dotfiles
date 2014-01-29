#!/bin/bash
pushd .

export opt="$HOME/opt"
export DOWNLOADS="$HOME/downloads"

mkdir -p "$opt/tools"
mkdir -p "$DOWNLOADS/chrome"
mkdir -p "$DOWNLOADS/dev"
mkdir -p "$HOME/vcs/misc"

source install/install-functions.sh
. install/install-bash.sh
. install/install-git.sh
. install/install-maven.sh

popd

