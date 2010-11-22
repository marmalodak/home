# .bashrc

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
alias backup='mount /media/JohnsHome && rdiff-backup --print-statistics -v6 /home/john/. /media/JohnsHome/j/john/. ; umount /media/JohnsHome'
alias view='vim -R'

function pycalc() { python -c "from math import *; print $*" ;}
function calc(){ awk "BEGIN{ print $* }" ;}

alias ddpoker='(cd ~/.wine/drive_c/Program\ Files/ddpoker && wine ./poker.exe > /tmp/ddpoker.out 2> /tmp/ddpoker.err)'

alias mountjs152033='sudo mount -t nfs hampk-home1.sfbay:/global/export/home1/317/js152033 /home/js152033'


export COLUMNS
export EDITOR=vim
export COLORTERM=on

export PAGER=less
export LESS="-w -m"
# export LESS=-r

# PROMPT_COMMAND defaults is "echo -ne
# "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"" export
# PROMPT_COMMAND='`if [ $?==0 ]; then PS1=":)[\u@\h][\d \@][\w] \$\r\n"; else
# PS1=":([\u@\h][\d \@][\w] \$\r\n"; fi`' bash prompt old PS1='[\u@\h \W]\$
# ' export PS1="[\u@\H][\d \@][\w] \$\r\n"
#export PS1='\`if [ \$?==0 ]; then echo -e "\033[01;32m:)"; else echo -e "\033[01;31m:("; fi\` \u@\h[\d \@][\w] \$\r\n'

export PS1="[\u@\H][\d \@][\w] \$\r\n"
PS1_SAVE=$PS1

NORMAL="\[\033[01;0m\]"

SCARY="\[\033[01;31m\]"



# PROMPT_COMMAND='if [ $? == 0 ]; then PS1="\033[01;32m:-) $PS1_SAVE"; else PS1="\033[01;31m:-( $PS1_SAVE\033[01;32m"; fi' 



PROMPT_COMMAND='if [ $? == 0 ]; then PS1="$NORMAL:-) $PS1_SAVE"; else PS1="$SCARY:-( $PS1_SAVE$NORMAL"; fi'


export PYTHONPATH=/usr/local/lib/python2.3/site-packages/:/usr/lib/python2.3/site-packages/:$PYTHONPATH



alias blob='sudo modprobe cryptoloop && sudo modprobe serpent && sudo losetup -d /dev/loop0 && sudo losetup -e serpent /dev/loop0 /home/js152033/scribble/scribblesblob && sudo mount -t ext3 /dev/loop0 /home/js152033/scribble/scribbles && cd /home/js152033/scribble/scribbles'
alias unblob='cd ~ && sudo umount /home/js152033/scribble/scribbles;  sudo losetup -d /dev/loop0; sudo rmmod serpent; sudo rmmod cryptoloop'
#export http_proxy="http://webcache.sfbay.sun.com:8080"

alias vpn='sudo service vpnclient_init start && sudo vpnclient connect sfbay'
alias vpnstop='sudo vpnclient disconnect; sudo service vpnclient_init stop; sudo rmmod cisco_ipsec'



# This line was appended by KDE
# Make sure our customised gtkrc file is loaded.
# (This is no longer needed from version 0.8 of the theme engine)
# export GTK2_RC_FILES=$HOME/.gtkrc-2.0
