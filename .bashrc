# .bashrc

# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/

# TODO: consider zsh and fish shells
# TODO: other things to consider: tig pgcli httpie jo jq doitlive pipsi https://github.com/facebook/PathPicker 
# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

shopt -s histappend

env_file="/home/setup/dot.bashrc"
if [ -x $env_file ]; then
	source $env_file
fi

#export PATH=/sbin:/usr/sbin:$PATH:/usr/libexec/xscreensaver

unalias vi 2> /dev/null > /dev/null
alias vi='vim -v -C'
alias lc='ls -C --color=tty'
alias ll='ls -l --color=tty'
alias lr='ls -lrth --color=tty'
alias cvstatus='cvs status | grep -v Examining | grep Status: | grep -v Up-to-date'
alias v='vnchome && nohup vncvhome &'
alias view='vim -R'

# http://zwischenzugs.tk/index.php/2015/07/01/bash-shortcuts-gem/
alias binds="bind -l | sed 's/.*/bind -q \0/' | /bin/bash 2>&1 | grep -v warning: | grep 'can be'"
bind -x '"\C-x\C-o":bind -l | sed "s/.*/bind -q \0/" | /bin/bash 2>&1 | grep -v warning: | grep can'


function pycalc() { python -c "from math import *; print $*" ;}
function calc(){ awk "BEGIN{ print $* }" ;}

alias ddpoker='(cd ~/.wine/drive_c/Program\ Files/ddpoker && wine ./poker.exe > /tmp/ddpoker.out 2> /tmp/ddpoker.err)'


export COLUMNS
export EDITOR=vim
export COLORTERM=on

export PAGER=less
export LESS="-w -m --follow-name"
# export LESS=-r

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

# PROMPT_COMMAND='if [ $? == 0 ]; then PS1="\033[01;32m:-) $PS1_SAVE"; else PS1="\033[01;31m:-( $PS1_SAVE\033[01;32m"; fi' 
# PROMPT_COMMAND='if [ $? == 0 ]; then PS1="$NORMAL:-) $PS1_SAVE"; else PS1="$SCARY:-( $PS1_SAVE$NORMAL"; fi'

alias blob='sudo modprobe cryptoloop && sudo modprobe serpent && sudo losetup -d /dev/loop0 && sudo losetup -e serpent /dev/loop0 /home/js152033/scribble/scribblesblob && sudo mount -t ext3 /dev/loop0 /home/js152033/scribble/scribbles && cd /home/js152033/scribble/scribbles'
alias unblob='cd ~ && sudo umount /home/js152033/scribble/scribbles;  sudo losetup -d /dev/loop0; sudo rmmod serpent; sudo rmmod cryptoloop'

# This line was appended by KDE
# Make sure our customised gtkrc file is loaded.
# (This is no longer needed from version 0.8 of the theme engine)
# export GTK2_RC_FILES=$HOME/.gtkrc-2.0

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
