#!/bin/bash
pushd .

export opt="~/opt"
export DOWNLOADS="~/downloads"

mkdir -p $opt/tools
mkdir -p $DOWNLOADS/chrome
mkdir -p $DOWNLOADS/dev
mkdir -p ~/vcs/misc

source install/install-functions.sh
. install/install-bash.sh
. install/install-git.sh
. install/install-maven.sh

popd

