#!/bin/bash

function backup()
{
  if [[ -f $1 ]]; then
    mv "$1" "$1`date +%Y_%M_%d_%H_%m_%S`"
  fi
}

function safeInstall()
{
  if [[ -f $2 ]]; then
    if [[ `diff $1 $2` ]]; then
      backup $2
    else
#     echo "$1 is same as $2"
      return 0;
    fi
  fi

  cp $1 $2
}