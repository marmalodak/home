# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
shopt -s checkhash
shopt -s cmdhist
shopt -s histappend
shopt -s histreedit
shopt -s dotglob
shopt -s failglob
shopt -s no_empty_cmd_completion

PATH=$PATH:$HOME/bin:/usr/sbin:/sbin

export PATH
unset USERNAME

# from http://serverfault.com/questions/2817/hidden-features-of-linux/15179#15179
# Make history ignore dups, ls, and exit
export HISTIGNORE="&:ls:[bf]g:exit"

# Save 100000 history comamnds
export HISTSIZE=10000

# Make each terminal use a separate history file
HISTDIR=${HOME}/.history
SHELLID=$(tty | sed 's!/!.!g')
HISTFILE=${HISTDIR}/history${SHELLID}

touch ${HISTFILE}

# load last histfile as current history
history -r $(/bin/ls ${HISTDIR}/history${SHELLID} | /usr/bin/tail -n 1)

