# try this instead: https://kevin.burke.dev/kevin/profiling-zsh-startup-time/
# https://kevin.burke.dev/kevin/profiling-zsh-startup-time/
PROFILE_STARTUP=false
if [[ "$PROFILE_STARTUP" == true ]]; then
  # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
  PS4=$'%D{%M%S%.} %N:%i> '
  exec 3>&2 2>$HOME/tmp/startlog.$$
  setopt xtrace prompt_subst
fi


# TODO there are useful things that can be taken from .bashrc

# [[ -f ~/.ghtok ]] && source ~/.ghtok  # how did this get here?

# zsh-lovers reference card https://grml.org/zsh/zsh-lovers.html
# from Zach Riddle, better output for zsh -x
export PS4='+%1N:%I> '

# https://wiki.archlinux.org/title/Zsh
# https://github.com/ChrisCummins/zsh/blob/master/zshrc <- crib from here
# https://awesomeopensource.com/project/sharkdp/bat
# https://github.com/sharkdp/bat/issues/508
# https://github.com/sharkdp/bat#using-a-different-pager
# export BAT_PAGER="less -RF"
export BAT_THEME=Coldark-Cold

# defaults read -g AppleInterfaceStyle
# Dark # $? = 0, $? = 1 # when not in dark mode


# why did control+p and control+n break?
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

# these binding didn't work; search for "Default key bindings" in /etc/zshrc for copypasta
# https://stackoverflow.com/a/55235069/1698426
# alt+<- | alt+->
bindkey "^[f" forward-word
bindkey "^[b" backward-word
# # ctrl+<- | ctrl+->
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# https://old.reddit.com/r/zsh/comments/svctvj/how_to_park_a_command_like_bash/
bindkey '^[#' pound-insert
# bindkey "^q" pound-insert # no worky??

# https://github.com/ohmyzsh/ohmyzsh/issues/6835
# https://github.com/ohmyzsh/ohmyzsh/issues/6835#issuecomment-392755849 ???
# https://stackoverflow.com/a/61572895 ???
#ZSH_DISABLE_COMPFIX="true"  # hopefully this is no longer needed

# Q: what is the relationship between $fpath and $FPATH other than that $FPATH separates entries with colons like $PATH
# A: see https://unix.stackexchange.com/a/532155/30160
# tldr The $path array variable is tied to the $PATH scalar (string) variable. Any modification on one is reflected in the other.
# TODO should this be in .zprofile?
[[ -d /usr/local/brew/share/zsh/site-functions/ ]] && fpath+=(/usr/local/brew/share/zsh/site-functions/)
[[ -d /opt/brew/share/zsh/site-functions ]]        && fpath+=(/opt/brew/share/zsh/site-functions)  # when brew is installed by liv
[[ -d /opt/homebrew/share/zsh/site-functions ]]    && fpath+=(/opt/homebrew/share/zsh/site-functions)  # brew on m1
# how do /opt/homebrew/share/zsh-completions entries get configured?

# after upgrade to Fedora 33, I needed to do this:
[[ $OSTYPE == 'linux'* ]] && export FPATH=$FPATH:/usr/share/zsh/5.8/functions
# maybe zshversion=$(zsh --version | cut -d' ' -f 2)

if ! whence ~/bin/cht.sh > /dev/null; then
  echo "Consider curl https://cht.sh/:cht.sh > /tmp/cht.sh ... "
fi
if whence fastfetch > /dev/null; then
  fastfetch # The fat logo in each pane is a bit much
elif whence neofetch > /dev/null; then
  neofetch
elif whence nerdfetch > /dev/null; then
  nerdfetch
fi
[[ -f ~/.motd ]] && source ~/.motd

unsetopt beep  # I hate, hate, hate being beeped at

# NB some of these feel very slow in the rs-cfe repo
# other oh-my-posh themese I like: (source https://ohmyposh.dev/docs/themes/)
all_oh_my_posh_themes=(
  1_shell.omp.json # needs newline # 4, it does NOT need a newline, what? slightly too light on white background
  # aliens.omp.json # a bit too shiny and needs a newline -1
  amro.omp.json # 2 a bit too light on a light background
  darkblood.omp.json # 5 too light on a light background, otherwise great
  emodipt-extend.omp.json # 2
  fish.omp.json # 2 a bit too shiny # needs newline
  cobalt2.omp.json # needs newline # a bit too shiny
  honukai.omp.json # 5 some colour adjustments needed on light background
  illusi0n.omp.json # 2 needs newline
  kali.omp.json # 9 maybe change $ to > or ＞ FULLWIDTH GREATER-THAN SIGN Unicode: U+FF1E, UTF-8: EF BC 9E
  kushal.omp.json # 2 very slow, too light on a white background and also a bit too shiny
  lambdageneration.omp.json # 5 # not sure about the amber colour tho
  # montys.omp.json # 2 pretty but shiny -1, I think this one screws up the console with junk chars or something
  negligible.omp.json # needs newline 3
  paradox.omp.json # 4 # a bit too shiny
  powerlevel10k_rainbow.omp.json
  probua.minimal.omp.json # -1 illegible on white background
  pure.omp.json # 1
  # simweb.omp.json # -1
  # slimfat.omp.json # 2
  sorin.omp.json # needs a newline before the cursor # 1
  stelbent-compact.minimal.omp.json # 1
  takuya.omp.json
  # thecyberden.omp.json # 1 # a bit too shiny
  # uew.omp.json # needs git info in the prompt and another newline 2, too light for light background
  wholespace.omp.json # 1 needs newline, very slow
  wopian.omp.json # 1 # needs hostname in the prompt
  ys.omp.json # 1 # too light on a light background
)
ri=$(( $RANDOM % ${#all_oh_my_posh_themes[@]} + 1)) # https://unix.stackexchange.com/a/287333
oh_my_posh_theme=${all_oh_my_posh_themes[$ri]}
echo "oh-my-posh theme ${oh_my_posh_theme}"

autoload -Uz zle-line-init  # some of these oh-my-posh themes complain `No such widget `zle-line-init'`, hopefully this will fix that...
if [[ ! -f ~/.oh-my-posh/oh-my-posh ]]; then
  go build -C ~/.oh-my-posh/src -o ~/.oh-my-posh/oh-my-posh
fi
eval "$(~/.oh-my-posh/oh-my-posh init zsh --config ~/.oh-my-posh/themes/${oh_my_posh_theme})"
# TODO customize themes that assume a dark background a la https://ohmyposh.dev/docs/installation/customize

# https://unix.stackexchange.com/a/557490/30160, so that # can be used in interactive mode
setopt interactive_comments

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

# ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# https://stackoverflow.com/a/19454838 # HISTSIZE vs HISTFILESIZE
# https://martinheinz.dev/blog/110
# TODO: increase history https://unix.stackexchange.com/a/521206/30160, see also https://zsh.sourceforge.io/Guide/zshguide02.html#l17
# put history in an sqlite database https://github.com/ellie/atuin
# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"
# HISTIGNORE=&
SAVEHIST=100000
HISTSIZE=1000000
HISTFILESIZE=10000000
# HISTCONTROL=ignoreboth # bashism? zsh equivelant is HIST_IGNORE_DUPS

setopt APPEND_HISTORY           # append to history rather than replace it
setopt HIST_REDUCE_BLANKS       # remove unnecessary blanks
# setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
# setopt SHARE_HISTORY            # imports new commands from the history file, and also causes your typed commands to be appended to the history file
#                                 # also enables EXTENDED_HISTORY
#                                 # SHARE_HISTORY isn't that great because local history is more important 
setopt EXTENDED_HISTORY         # record command start time
setopt HIST_IGNORE_SPACE        # do not record if the command starts with whitespace
# https://askubuntu.com/a/23631 Either set inc_append_history or share_history but not both

[[ -z LC_CTYPE ]] && export LC_CTYPE="${LC_ALL}"  # tmux needs this for UTF-8 text? I must be  mistaken; see the tmux man page seciont "ENVIRONMENT"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git chucknorris colored-man-pages command-not-found virtualenv pep8 fzf z web-search)
# I removed the timer plugin because it makes copying console text more complicated
# do not add zsh-autosuggestions to plugins because it is installed manually
# z https://github.com/agkozak/zsh-z

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# source $ZSH/oh-my-zsh.sh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# source ~/.zsh/zsh-you-should-use/you-should-use.plugin.zsh
source ~/.zsh/zsh-edit/zsh-edit.plugin.zsh

zstyle ':completion:*' extra-verbose yes
zstyle ':completion:list-expand:*' extra-verbose yes
zstyle ':completion:*' menu select  # recommended by z

# export MANPATH="/usr/local/man:$MANPATH"

export LANG=en_US.UTF-8

export EDITOR='vim'
whence nvim > /dev/null && export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"


# https://github.com/Qix-/better-exceptions/
# on 2nd thought, I don't know how much I actually like this
export BETTER_EXCEPTIONS=1  # https://github.com/qix-/better-exceptions

# alias fzf='\fzf --preview "bat --style=numbers --color=always --line-range :500 {}"'  # TODO fix colors
# FZF_DEFAULT_COMMAND="fd --type f --exclude .git"
FZF_DEFAULT_COMMAND="eza -1"

if [[ -r ~/.punkte.zsh ]]; then
  source ~/.punkte.zsh
else
  echo "\e[1;31mNo Punkte?\e[0m"
fi

alias r1='rg --max-depth=1'
alias r2='rg --max-depth=2'
alias r3='rg --max-depth=3'
alias r4='rg --max-depth=4'

setopt autocd
# omg setopt autocd https://zsh.sourceforge.io/Intro/intro_16.html#SEC16 seems to remove the need for any of the following!
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'

# https://github.com/sharkdp/vivid
# https://unix.stackexchange.com/questions/245378/common-environment-variable-to-set-dark-or-light-terminal-background#245568
# https://github.com/rocky/shell-term-background/blob/master/term-background.zsh
# http://www.bigsoft.co.uk/blog/2008/04/11/configuring-ls_colors

# switch from exa to eza https://github.com/eza-community/eza
if whence eza > /dev/null; then
  alias ll='eza --long --icons=always'
  alias lr='eza --long --header --sort=date --icons=always'
  alias lra='eza --all --long --header --sort=date --icons=always'
  alias lc='eza --oneline --icons=always'
  alias lt='eza --tree --icons=always'
  alias l1='eza --oneline'
  alias l2='eza --tree --icons=always --level=2'
  alias l3='eza --tree --icons=always --level=3'
  alias l4='eza --tree --icons=always --level=4'
  alias l5='eza --tree --icons=always --level=5'
  alias lrg='eza --all --long --header --binary --sort=accessed --git --icons=always'
  alias lRg='eza --all --long --header --binary --sort=accessed --git --extended --icons=always'
  source ~/.config/eza-colors/eza-colors.zsh
  export EZA_COLORS="${eza_colors_one_light}"
else
  if [[ $OSTYPE == 'darwin'* ]]; then
    alias ll='ls -lG'
    alias lr='ls -lrthG'
  else
    alias ll='ls -l --color=auto'
    alias lr='ls -lrth --color=auto'
  fi
fi


alias pfzf='fzf --preview=bat {}'
alias ipoca='ip -o -c a' # TODO test for macOS vs Linux
alias nvn='nvim -O $(git diff --cached --name-only --diff-filter=ACMR --ignore-submodules=all)'
alias nvnp='nvim -O $(punkt diff --name-only --diff-filter=ACMR --ignore-submodules=all)'
alias breakpath='sep=:;print -l ${(ps.$sep.)PATH}'  # https://discussions.apple.com/thread/251387981
alias brup='brew update && brew upgrade --greedy-auto-updates && brew cleanup && brew doctor && brew config'

# rsync instead of ssh https://gist.github.com/dingzeyuli/1cadb1a58d2417dce3a586272551ec4f
alias secscp='rsync -azhe ssh --progress $1 $2'

function cd-fd()
{
  somefile="$(fd $1)"
  if [[ -z "$1" ]] || [[ -z "${somefile}" ]] || [[ ! -f "${somefile}" ]]; then echo "File $1 not found"; return 1; fi
  cd $(dirname ${somefile})
}

# bc - An arbitrary precision calculator language
function =
{
  echo "$@" | bc -l
}
alias calc="="


function hs()  # from #help-zsh: search history and display unique lines (for those tools you use every-so-often with arguments you can never remember)
{
  fc -ln 0 | grep $1 | awk '{!seen[$0]++};END{for(i in seen) if(seen[i]==1)print i}'
  # fc -ln 0 | grep $1 | sort | uniq -c | sort -n | cut -c6- # frequent things at the end of the list
}


# open all the files that are found by ripgrep
function nvim-rg()
{
  maxdepth=()
  if [[ "${1:0:2}" == '-d' ]]; then
    maxdepth="--max-depth=${2}"
    shift
    shift
  fi
  searchterm=$*
  shift
  nvim -O $(rg --ignore-case --color=never --files-with-matches ${maxdepth} ${searchterm}) # $*
  #                                                                                          ⤷ What? I don't think this is necessary
}


# Do not understand why, but fd will not find CommandLineTools.dmg unless the -u flag is set
alias fd='\fd -u'

if whence batcat > /dev/null; then
  alias bat='batcat'  # ubuntu
elif ! whence bat > /dev/null; then
  alias bat='cat'  # if bat is not installed
fi
whence fdfind > /dev/null && alias fd='fdfind'  # ubuntu

alias nvimdiff='nvim -d'


# open the files that are found by fd
# if there are
# dir1/dir2/foo.anext
# dir3/foo.ext
# nvim-fd foo should invoke nvim -O dir1/dir2/foo.anext dir3/foo.ext
function nvim-fd()
{
  if whence fdfind > /dev/null; then
    fdfind ${@} --exec-batch nvim -O  # oh ubuntu, why??
  else
    fd ${@} --exec-batch nvim -O
  fi

  # TODO accept more than one search term
  # TODO accept a --maxdepth option

  # files=$(eval $(printf "fd %s " ${@}))
  # echo files=$files
  # nvim -O $files

  # files=(  )
  # for i in ${@}; do
  #   files+=( $(fd $i)  )
  # done
  # nvim -O ${files[@]}
}


# open all the files that are modified according to git
function nvim-modified()
{
  # eval nvim -O printf "$(git diff --patch %s) " $(git status --short --untracked-files=no --ignore-submodules=all | awk '{if ($1 == "M" || $1 == "MM" || $1 == " M") print $2}')  # broken
  # nvim -O $(git ls-files --modified --exclude-standard)  # https://stackoverflow.com/a/28280636/1698426
  # Using git ls-files might be better if it excluded submodules
  nvim -O $(git status --short --untracked-files=no --ignore-submodules=all | cut -d' ' -f3)  # cut -w does not work everywhere
}


# when there are foo.err foo.log bar.err bar.log, open just the log files, not the .err files
function nvim-errlog()
{
  if [[ -n $1 ]]; then
    nvim -O ${$(echo *$1*.err)/err/log}
  else
    nvim -O ${$(echo *.err)/err/log}
  fi
}


function huh()
{
  whence -v $@
  whence -f $@
}


function git-cmds()
{
  # TODO see list-<category> in command-list.txt, https://github.com/git/git/blob/master/command-list.txt
  for cmd in builtins parseopt main others config; do
    git --list-cmds=${cmd}
  done
}

# requires autoload -Uz compinit && compinit
function zsh-completions-show-all
{
  # https://stackoverflow.com/a/40014760/1698426
  for command completion in ${(kv)_comps:#-*(-|-,*)}
  do
    printf "%-32s %s\n" $command $completion
  done | sort
}

# https://x.com/igor_chubin/status/1343294742315020293
function fzfc()
{
  curl -ks cht\.sh/$(curl -ks cht\.sh/:list | IFS=+ fzf --preview 'curl -ks http://cht.sh{}' -q "$*");
}

function cht()
{
  # curl cht.sh/git/saltstack+schedule\?style=xcode
  # term="{1}"'?style=xcode'
  curl cht.sh/$1'?style=xcode'
}


# if cmd is available use it, otherwise run cmd2
# could this be made to work for cmd3? cmd4?
# probably not because how do you distinguish between a cmd and a argument to a cmd?
function ifcmd()
{
  cmd1=${1}; shift
  cmd2=${1}; shift
  if whence ${cmd1} > /dev/null ${cmd1}; then
    ${cmd1} $*
  else
    ${cmd2} $*
  fi
  # whence ${cmd1} > /dev/null && ${cmd1} $* || ${cmd2} $*
}


[[ ! -f ~/.local.zsh ]] || source ~/.local.zsh


# compdef punkt=git
# 
# if whence eza > /dev/null; then
#   compdef ll=eza
#   compdef lr=eza
#   compdef lc=eza
#   compdef lt=eza
#   compdef l2=eza
#   compdef l3=eza
#   compdef l4=eza
#   compdef l5=eza
#   compdef lrg=eza
#   compdef lRg=eza
# fi

bindkey '^I' expand-or-complete-prefix

# https://unix.stackexchange.com/a/736909/30160, enable completion in the middle of a word, ignore everything after the cursor
zstyle ':completion:*' completer _complete _prefix
set -o completeinword

# # the next time completions stop working: rm ~/.zcompdump*, and then autoload -U compinit && compinit
# autoload -Uz compinit # does oh-my-zsh already run compinit??  # https://gist.github.com/ctechols/ca1035271ad134841284
# # https://gist.github.com/ctechols/ca1035271ad134841284
# if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
#   compinit
# else
#   compinit -C
# fi

autoload -Uz +X compinit && compinit -u # https://stackoverflow.com/questions/13762280/zsh-compinit-insecure-directories?noredirect=1&lq=1
autoload -Uz +X bashcompinit && bashcompinit # zsh can load bash completion functions! https://stackoverflow.com/a/70893451/1698426



# https://postgresqlstan.github.io/cli/zsh-run-help/ https://unix.stackexchange.com/a/282649/30160 https://stackoverflow.com/a/7060716
(( $+aliases[run-help] )) && unalias run-help  # https://www.reddit.com/r/zsh/comments/g1srzn/comment/fnhomy8/
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-svk
autoload -Uz run-help-sudo
autoload -Uz run−help−ip
autoload -Uz run−help−openssl
autoload -Uz run−help−p4
autoload -Uz run−help−svn
alias help=run-help
HELPDIR="/usr/share/zsh/$(zsh --version | cut -d' ' -f2)/help"

# TODO: steal from https://github.com/vincentbernat/zshrc/blob/master/rc/alias.zsh
# TODO: steal from https://github.com/gibfahn/dot/blob/539fb6881ee8ddb184c0a41a31d7b6e3c0573f82/dotfiles/.config/zsh/deferred/deferred.zsh#L570-L572
# TODO: steal from https://natelandau.com/my-mac-os-zsh-profile/
# TODO: use the fzf hints https://github.com/sharkdp/bat/issues/357
#                         https://github.com/sharkdp/fd#using-fd-with-fzf
#                         https://github.com/lotabout/skim
# TODO: something like zcat https://github.com/sharkdp/bat/issues/237#issuecomment-617079288
# TODO: https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Accessing-On_002dLine-Help
#       this makes run-help bindkeys show the zsh man page for the bindkeys entry
#       see also https://stackoverflow.com/a/7060716/1698426 where I learned about run-help
# good primer on bools in bash https://stackoverflow.com/a/47876317/1698426
# TODO: consider https://github.com/z-shell/zsh-lint which requires https://github.com/z-shell/zi

if ! source <(fzf --zsh 2> /dev/null); then
  source /usr/share/doc/fzf/examples/key-bindings.zsh # ubuntu 22
fi
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # when did this ever exist?

# https://kevin.burke.dev/kevin/profiling-zsh-startup-time/
if [[ "$PROFILE_STARTUP" == true ]]; then
    unsetopt xtrace
    exec 2>&3 3>&-
fi

# This is the .zshrc that is default on ubuntu
#
# john@bna-vm-01 ~ % cat .zshrc
# # Set up the prompt
#
# autoload -Uz promptinit
# promptinit
# prompt adam1
#
# setopt histignorealldups sharehistory
#
# # Use emacs keybindings even if our EDITOR is set to vi
# bindkey -e
#
# # Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
# HISTSIZE=1000
# SAVEHIST=1000
# HISTFILE=~/.zsh_history
#
# # Use modern completion system
# autoload -Uz compinit
# compinit
#
# zstyle ':completion:*' auto-description 'specify: %d'
# zstyle ':completion:*' completer _expand _complete _correct _approximate
# zstyle ':completion:*' format 'Completing %d'
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*' menu select=2
# eval "$(dircolors -b)"
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
# zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
# zstyle ':completion:*' menu select=long
# zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# zstyle ':completion:*' use-compctl false
# zstyle ':completion:*' verbose true
#
# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
# zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
source <(capri --zsh-completions 2>/dev/null)
source <(isc --zsh-completions 2>/dev/null)
source <(acc --zsh-completions 2>/dev/null)
