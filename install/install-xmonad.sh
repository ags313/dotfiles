#!/bin/bash

mkdir -p "$HOME/.xmonad"
mkdir -p ".kde/env"

function installXmonad
{
	safeInstall xmonad/xmonad.hs ~/.xmonad/xmonad.hs
}

installXmonad