#!/bin/bash
mkdir -p ~/bash

function installBashThings
{
	safeInstall .bashrc ~/.bashrc
	safeInstall .bash_profile ~/.bash_profile
	safeInstall .dircolors ~/.dircolors

	for file in bash/*; do
		safeInstall $file ~/bash/$file
	done
}

installBashThings

