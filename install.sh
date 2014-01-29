#!/bin/bash
pushd .

cd ~
mkdir -p downloads/chrome
mkdir -p downloads/dev
mkdir -p vcs/misc

export DOWNLOADS="~/downloads"

source install/install-functions.sh
. install/install-bash.sh
. install/install-git.sh
. install/install-maven.sh

popd

