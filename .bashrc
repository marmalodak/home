# .bashrc

set +x
set +e  # have not yet found the error where set -o causes a problem
set -o pipefail


# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/

# TODO: consider zsh and fish shells
# TODO: other things to consider: tig pgcli httpie jo jq doitlive pipsi https://github.com/facebook/PathPicker 

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

shopt -s histappend

unalias vi
alias vi='vim -v -C --clean --noplugin'
alias lc='exa -1'
alias lt='exa -T'
alias ll='exa -l'
alias lr='exa -albh --sort=accessed --git --extended'
alias view='vim -R'

# http://zwischenzugs.tk/index.php/2015/07/01/bash-shortcuts-gem/
# alias binds="bind -l | sed 's/.*/bind -q \0/' | /bin/bash 2>&1 | grep -v warning: | grep 'can be'"
# bind -x '"\C-x\C-o":bind -l | sed "s/.*/bind -q \0/" | /bin/bash 2>&1 | grep -v warning: | grep can'

function pycalc() { python -c "from math import *; print $*" ;}
function calc(){ awk "BEGIN{ print $* }" ;}

#alias ddpoker='(cd ~/.wine/drive_c/Program\ Files/ddpoker && wine ./poker.exe > /tmp/ddpoker.out 2> /tmp/ddpoker.err)'


export COLUMNS
export EDITOR=vim
export COLORTERM=on

export PAGER=less
export LESS="-w -m --follow-name -r"

# PROMPT_COMMAND defaults is "echo -ne
# "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"" export
# PROMPT_COMMAND='`if [ $?==0 ]; then PS1=":)[\u@\h][\d \@][\w] \$\r\n"; else
# PS1=":([\u@\h][\d \@][\w] \$\r\n"; fi`' bash prompt old PS1='[\u@\h \W]\$
# ' export PS1="[\u@\H][\d \@][\w] \$\r\n"
#export PS1='\`if [ \$?==0 ]; then echo -e "\033[01;32m:)"; else echo -e "\033[01;31m:("; fi\` \u@\h[\d \@][\w] \$\r\n'

#export PS1="[\u@\H][\d \@][\w] \$\r\n"
#PS1_SAVE="$PS1"
#NORMAL="\[\033[01;0m\]"
#SCARY="\[\033[01;31m\]"

## PROMPT_COMMAND='if [ $? == 0 ]; then PS1="\033[01;32m:-) $PS1_SAVE"; else PS1="\033[01;31m:-( $PS1_SAVE\033[01;32m"; fi' 
## PROMPT_COMMAND='if [ $? == 0 ]; then PS1="$NORMAL:-) $PS1_SAVE"; else PS1="$SCARY:-( $PS1_SAVE$NORMAL"; fi'

##alias blob='sudo modprobe cryptoloop && sudo modprobe serpent && sudo losetup -d /dev/loop0 && sudo losetup -e serpent /dev/loop0 /home/js152033/scribble/scribblesblob && sudo mount -t ext3 /dev/loop0 /home/js152033/scribble/scribbles && cd /home/js152033/scribble/scribbles'
##alias unblob='cd ~ && sudo umount /home/js152033/scribble/scribbles;  sudo losetup -d /dev/loop0; sudo rmmod serpent; sudo rmmod cryptoloop'

# Codi
# Usage: codi [filetype] [filename]
codi() {
  local syntax="${1:-python}"
  shift
  vim -c \
    "let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax" "$@"
}

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bash/powerline.sh

# use like this: VENVSHELL=~/projects/jupyter/venv/jupyter-venv/bin/activate bash
if [[ -v "$VENVSHELL" ]]; then
    source "$VENVSHELL"
fi
