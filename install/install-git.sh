#!/bin/bash

echo "Installing git"

safeInstall .gitconfig ~/.gitconfig
safeInstall .gitignore_global ~/.gitignore_global

function install_git_completion
{
	pushd /tmp
	wget https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh
	wget https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
	safeInstall git-completion.bash ~/bash/bash-git.completion
	safeInstall git-prompt.sh ~/bash/git-prompt.sh
	popd
}

function installGitSh
{
	mkdir
	if [[ ! -d ~/vcs/misc/git-sh ]]; then
		git clone git://github.com/rtomayko/git-sh.git ~/vcs/misc/git-sh
		cd ~/vcs/misc/git-sh
		make
		sudo make install
	fi
}

pushd .

install_git_completion

if [[ -z `which git-sh` ]]; then
	installGitSh
fi

popd
