function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
}

function resetPrompt {
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local        GRAY="\[\033[1;38m\]"
  local        TEAL="\[\e[0;36m\]"
  case $TERM in
*)
TITLEBAR=""
;;
esac

if [ 0 -eq ${UID} ]; then
  export PS1="${TITLEBAR}\
$BLUE[$RED\$(date +%H:%M)$BLUE]\
$BLUE[$RED\u$GRAY@$TEAL\h:$BLUE\w$GREEN\$(parse_git_branch)$BLUE]\
$GREEN\n\$"
else
 export PS1="${TITLEBAR}\
$BLUE[$TEAL\$(date +%H:%M)$BLUE]\
$BLUE[$GREEN\u$GRAY@$TEAL\h:$BLUE\w$GREEN\$(parse_git_branch)$BLUE]\
$GREEN\n\$ "
fi

export PS2='> '
export PS4='+ '
}

removeFromPath()
{
	PATH=`echo $PATH | sed "s|:$1/||"`
	PATH=`echo $PATH | sed "s|:$1||"`
}


