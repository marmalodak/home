# .bashrc

set +x
set +e  # have not yet found the error where set -o causes a problem
set -o pipefail

# remember this line when debugging shell
# PS4='# ${BASH_SOURCE}:${LINENO}: ${FUNCNAME[0]}() - [${SHLVL},${BASH_SUBSHELL},$?] '

# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/

# TODO: consider zsh and fish shells
# TODO: other things to consider: tig pgcli httpie jo jq doitlive pipsi https://github.com/facebook/PathPicker 

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

3 https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
shopt -s histappend

which exa > /dev/null 2>&1
exa_not_exists=$?

if [[ $exa_not_exists -ne 0 ]]; then
    if [[ $OSTYPE == 'darwin'* ]]; then
        alias ll='ls -lG'
        alias lr='ls -alrthG'
    else
        alias ll='ls -l --color=auto'
        alias lr='ls -alrth --color=auto'
    fi
else
    alias ll='exa -l --icons'
    alias lr='exa -alh --sort=date --icons'
    alias lc='exa -1 --icons'
    alias lt='exa -T --icons'
    alias ll='exa -l --icons'
    alias lrg='exa -albh --sort=accessed --git --icons'
    alias lRg='exa -albh --sort=accessed --git --extended --icons'
fi

unalias vi
alias vi='vim -v -C --clean --noplugin'
alias view='vim -R'
alias pfzf='fzf --preview=bat {}'
alias ipoca='ip -o -c a'

alias vimr='vimr --nvim -O'

function pycalc() { python -c "from math import *; print $*" ;}
function calc(){ awk "BEGIN{ print $* }" ;}

export COLUMNS
export EDITOR=vim
export VISUAL=vim
export COLORTERM=on

export PAGER=less
export LESS="-w -m --follow-name -r"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# https://github.com/Qix-/better-exceptions/
export BETTER_EXCEPTIONS=1

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

# Codi
# https://github.com/metakirby5/codi.vim
# Usage: codi [filetype] [filename]
function codi() {
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

function totmp()
{
    echo "Args: $*"
    tmpdir=$(mktemp -d)
    echo $"mv --target-directory=${tmpdir} $*"
    mv --target-directory=${tmpdir} $*
}

# e.g. myfind choices 4
# that is, recusively find the word "choices" but descend no more than 4 directories
function myfind()
{
    find . -maxdepth $2 -iname \*.py -exec  grep -in --color -H $1 '{}' \;
}

function watchthis()
{
    while true; do inotifywait -e modify $1; clear; less -E $1 | ccze --mode ansi; done
}

function servefile()
{
    while true; do { echo -ne "HTTP/1.0 OK\n\n"; cat < "$1" ; } | nc -vlp 8002; done
}

function activate()
{
    bash -i <<< 'source ~/.venv/bin/activate; exec </dev/tty'
}

if [[ -f $(which powerline-daemon) ]]; then
    powerline-daemon -q
    POWERLINE_BASH_CONTINUATION=1
    POWERLINE_BASH_SELECT=1
    . /usr/share/powerline/bash/powerline.sh
fi

if [[ $- == *i* ]]; then  # is bash interactive?
    if [[ -z "$TMUX" ]]; then
        if [[ $(tmux run-shell "echo #{session_attached}") == 0 ]]; then  # if the tmux session has zero attachers
            tmux attach
        fi
    fi
fi

[[ ! -f ~/.motd ]] || source ~/.motd

source /Users/john/.config/broot/launcher/bash/br

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
