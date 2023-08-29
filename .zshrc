# [[ -f ~/.ghtok ]] && source ~/.ghtok  # how did this get here?

# zsh-lovers reference card https://grml.org/zsh/zsh-lovers.html
# from Zach Riddle, better output for zsh -x
export PS4='+%1N:%I> '

# https://github.com/ChrisCummins/zsh/blob/master/zshrc <- crib from here
# https://awesomeopensource.com/project/sharkdp/bat
export BAT_THEME=Coldark-Cold
# https://github.com/sharkdp/bat/issues/508
# https://github.com/sharkdp/bat#using-a-different-pager
# export BAT_PAGER="less -RF"

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

[[ -f ~/.motd ]] && source ~/.motd

unsetopt beep  # I hate, hate, hate being beeped at

source ~/.powerlevel10k/powerlevel10k.zsh-theme

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# https://unix.stackexchange.com/a/557490/30160, so that # can be used in interactive mode
setopt interactive_comments

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

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
HISTSIZE=100000
HISTFILESIZE=100000
SAVEHIST=100000
HISTCONTROL=ignoreboth


# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git chucknorris colored-man-pages command-not-found virtualenv pep8 fzf z timer web-search)
# do not add zsh-autosuggestions to plugins because it is installed manually
# z https://github.com/agkozak/zsh-z

source $ZSH/oh-my-zsh.sh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# source ~/.zsh/zsh-you-should-use/you-should-use.plugin.zsh
source ~/.zsh/zsh-edit/zsh-edit.plugin.zsh

zstyle ':completion:*' extra-verbose yes
zstyle ':completion:list-expand:*' extra-verbose yes
zstyle ':completion:*' menu select  # recommended by z

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"


# https://github.com/Qix-/better-exceptions/
# on 2nd thought, I don't know how much I actually like this
export BETTER_EXCEPTIONS=1  # https://github.com/qix-/better-exceptions

# TODO: EXA_COLORS, e.g. https://github.com/ogham/exa/issues/733#issuecomment-688930008
# https://github.com/sharkdp/vivid
# https://unix.stackexchange.com/questions/245378/common-environment-variable-to-set-dark-or-light-terminal-background#245568
# https://github.com/rocky/shell-term-background/blob/master/term-background.zsh
# http://www.bigsoft.co.uk/blog/2008/04/11/configuring-ls_colors


if command -v exa > /dev/null; then
  alias ll='exa -l --icons'
  alias lr='exa -alh --sort=date --icons'
  alias lc='exa -1 --icons'
  alias lt='exa -T --icons'
  alias ll='exa -l --icons'
  alias lrg='exa -albh --sort=accessed --git --icons'
  alias lRg='exa -albh --sort=accessed --git --extended --icons'
  source ~/.config/exa-colors/exa-colors.zsh
  export EXA_COLORS="${exa_colors_one_light}"
  # export EXA_COLORS="${exa_colors_one_dark}"
  # export EXA_COLORS=$(vivid generate one-light)
else
  if [[ $OSTYPE == 'darwin'* ]]; then
    alias ll='ls -lG'
    alias lr='ls -alrthG'
  else
    alias ll='ls -l --color=auto'
    alias lr='ls -alrth --color=auto'
  fi
fi


alias vimr='vimr --nvim -O'
alias pfzf='fzf --preview=bat {}'
alias ipoca='ip -o -c a'
alias nvn='nvim -O $(git diff --cached --name-only --diff-filter=ACMR --ignore-submodules=all)'
alias nvnp='nvim -O $(punkt diff --name-only --diff-filter=ACMR --ignore-submodules=all)'
alias breakpath='sep=:;print -l ${(ps.$sep.)PATH}'  # https://discussions.apple.com/thread/251387981
alias brup='brew update && brew upgrade --greedy-auto-updates && brew cleanup && brew doctor && brew config'

# rsync instead of ssh https://gist.github.com/dingzeyuli/1cadb1a58d2417dce3a586272551ec4f
alias secscp='rsync -azhe ssh --progress $1 $2'

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

# since the trash *.foo *.bar command aborts when no .bar files are found, use this for trashing multiple files
function trashit()
{
  for i in $*; do
    if [[ -f "${i}" ]] ; then
      \trash $i
    fi
  done
}


# open all the files that are found by ripgrep
function nvim-rg()
{
  term=$1
  shift
  nvim -O $(rg -l $term) $*
}


# Do not understand why, but fd will not find CommandLineTools.dmg unless the -u flag is set
alias fd='\fd -u'

alias nvimdiff='nvim -d'


# open the files that are found by fd
# if there are
# dir1/dir2/foo.anext
# dir3/foo.ext
# nvim-fd foo should invoke nvim -O dir1/dir2/foo.anext dir3/foo.ext
function nvim-fd()
{
  # the ${@} was an attempt to make (for example) "nvim-fd foo bar" where both foo and bar are patterns, but fd takes only one pattern argument
  # the man page for fd has this at the end:
  # Open all search results with vim:
  # $ fd pattern -X vim
  # so this might be better written as
  # fd ${1} -X nvim -O

  # set -x

  # files=$(eval $(printf "fd %s " ${@}))
  # echo files=$files
  # nvim -O $files

  # files=(  )
  # for i in ${@}; do
  #   files+=( $(fd $i)  )
  # done
  # nvim -O ${files[@]}
  fd ${@} -X nvim -O
}


# open all the files that are modified according to git
function nvim-modified()
{
  # eval nvim -O printf "$(git diff --patch %s) " $(git status --short --untracked-files=no --ignore-submodules=all | awk '{if ($1 == "M" || $1 == "MM" || $1 == " M") print $2}')  # broken
  # nvim -O $(git ls-files --modified --exclude-standard)  # https://stackoverflow.com/a/28280636/1698426
  # Using git ls-files might be better if it excluded submodules
  nvim -O $(git status --short --untracked-files=no --ignore-submodules=all | cut -w -f3)
}


# when there are foo.err foo.log bar.err bar.log, open just the log files, not the .err files
function nvim-errlog()
{
  if [[ -n $1 ]]; then  # is this check necessary?
    nvim ${$(echo *$1*.err)/err/log}
  else
    nvim ${$(echo *.err)/err/log}
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
  set -x
  for cmd in builtins parseopt main others config; do
    git --list-cmds=${cmd}
  done
  set +x
}


alias punkt='git --git-dir=$HOME/.punkte/.git --work-tree=$HOME'
alias punkt-status='punkt status --ignore-submodules=all --untracked-files=no'


# similar to nvim-modified
function punkt-modified()
{
  # eval nvim -O printf "<(punkt diff -p %s) " $(punkt-status --short | awk '{if ($1 == "M" || $1 == "MM" || $1 == " M") print $2}')
  # nvim -O $(punkt -C ~ ls-files --modified --exclude-standard)  # https://stackoverflow.com/a/28280636/1698426
  nvim -O $(punkt status --short --untracked-files=no --ignore-submodules=all | cut -w -f3)
}


function punkt-status()
{
  # man gitmodules: submodule.<name>.ignore
  punkt status --ignore-submodules=all --untracked-files=no
}


function punkt-diff()
{
  # TODO something like punkt submodule foreach config ignore = dirty"
  punkt diff --patch --ignore-submodules=all
}


function punkt-reset()
{
  punkt reset --hard origin/master
}


function punkt-neu()
{
  set -x
  git clone https://github.com/marmalodak/home $HOME/.punkte
  punkt checkout -- $HOME
  punkt status --ignore-submodules=all --untracked-files=no
  echo "Jetzt führe diesen Befehl: punkt-auf"
  set +x
}


function punkt-export()
{
  # https://stackoverflow.com/a/23116607
  punkt ls-files | tar Tzcf - /tmp/home.tgz
  echo On the destination: cd ~; tar xvf home.tgz
}


function punkt-export-old-method()
{
  set -x
  # https://www.geeksforgeeks.org/how-to-export-a-git-project/
  # see also git checkout-index https://stackoverflow.com/a/160620/1698426
  dest=/tmp/.home.tar
  setopt CSH_NULL_GLOB
  if [[ -n $(echo ${dest}*) ]]; then echo remove $(echo ${dest}*); return 1; fi
  additions=()
  if [[ -f .local.zsh ]]; then
    additions+=.local.zsh
  fi
  punkt archive --verbose --format tar.gz HEAD --output=${dest} --add-file=${additions}
  # https://stackoverflow.com/a/23116607
  # i.e. punkt ls-files | tar Tczf - ${dest}
  gzip ${dest}
  set +x
}


function punkt-aufbau()
{
  # https://gist.github.com/nicktoumpelis/11214362; see updates further down
  # Do not call git clean!!
  punkt submodule foreach --recursive git reset --hard
  punkt submodule update --init --recursive --remote
}


function punkt-auf()
{
  pushd ${HOME} > /dev/null 2>&1
  punkt pull --stat --recurse-submodules=yes --jobs=16 && punkt submodule update --init --remote --recursive --jobs=16
  popd > /dev/null 2>&1
}


function punkt-zeige()
{
  if ! command -v jq > /dev/null 2>&1; then
    echo "Install jq"
    return 1
  fi
  if [[ "${1}" == "--json" ]]; then
    echo $(punkt-zu-json) | jq
  elif [[ -n "${1}" ]]; then
    punkte-json=$(punkt-zu-json)
    echo "${punkte-json}" | jq -r '.[] | select(.submodule_name | contains("'${1}'"))'
  else
    punkt submodule foreach \
        'if [[ "$*" =~ "--short" ]]; then echo submodule_name:$name; echo; \
        else echo submodule_name:$name; echo displaypath:$displaypath; echo toplevel:$toplevel; echo sm_path:$sm_path; echo; git --no-pager config --list --show-origin; echo; \
        fi '
  fi
}


function punkt-zu-json()
{
  command -v jo > /dev/null 2>&1
  if [[ $? -ne 0 ]]; then
    echo "Install jo"
    return 1
  fi
  echo $(jo -a $(punkt submodule foreach --quiet 'jo submodule_name=$name displaypath=$displaypath toplevel=$toplevel sm_path=$sm_path'))
}


function punkt-flachen()
{
  # man 5 gitmodules: submodule.<name>.shallow
  # This is probably wrong:
  # 1. it doesn't seem to do what I think it should do
  # 2. probably don't need to use -f, git already knows where config files are
  #
  # Could this be enhanced to set the submodule repo to be bare?
  set -x
  # https://stackoverflow.com/a/37933909
  punkt submodule foreach 'git config -f ${HOME}/.punkte/.gitmodules submodule.$name.shallow true'
  punkt submodule foreach 'git config -f ${HOME}/.punkte/.git/config submodule.$name.shallow true'
}


function punkt-submodule-zutat()
{
  URL=$1
  WO=$2
  STEM=${URL##*/}
  punkt submodule add $URL $WO/$STEM
}

# vielleicht:
# function punkt-submodule-zutat() oder punkt-submodule-neu()
# {
#     submodule_repo=$1
#     punkt submodule add $1 ...
#     man gitmodules: submodule.<name>.ignore
#     man gitmodules: submodule.<name>.shallow
# }


function punkt-submodule-bringeum()
{
  # TODO this is still not reliable

  # to prevent a previous invocation of this function possibly still having these variables set:
  unset submodule_name
  unset displaypath
  unset toplevel
  unset sm_path

  command -v jq > /dev/null 2>&1
  if [[ $? -ne 0 ]]; then
    echo "Install jq"
    return 1
  fi

  # https://stackoverflow.com/a/1260982/1698426
  # https://stackoverflow.com/a/7646931/1698426

  SUBMODULE_NAME="${1}"
  if [[ -z "${SUBMODULE_NAME}" ]]; then
    echo "Must provide a submodule"
    echo "Submoule must be passed in as reported by punkt status"
    echo "NB punkt_status does not show submodules"
    echo "See also punkt_zeige"
    return 1
  fi

  punkte-json=$(punkt-zu-json)
  submodule-details=$(echo "${punkte-json}" | jq -r '.[] | select(.submodule-name=="'${SUBMODULE_NAME}'") | to_entries | .[] | .key + "=\"" + .value + "\""')
  eval ${submodule-details}

  # now these variables exist:
  # submodule_name=.zsh/zsh-autosuggestions
  # displaypath=../../.zsh/zsh-autosuggestions
  # toplevel=/Users/john
  # sm_path=.zsh/zsh-autosuggestions

  if [[ -z ${submodule_name} || -z ${displaypath} || -z ${toplevel} || -z ${sm_path} ]]; then
    echo "Achtung! Kein submodule gefunden!"
    # return 1
  fi

  set -x
  if [[ -n "${displaypath}" ]]; then
    punkt rm -iv "${displaypath}"
  fi
  if [[ -n "${submodule_name}" ]]; then
    rm -riv "${toplevel}/.punkte/.git/modules/${submodule_name}"
  fi
  if [[ -n "${sm_path}" ]]; then
    rm -riv "${toplevel}/${sm_path}"
  fi
  if [[ -n "${submodule_name}" ]]; then
    punkt config --remove-section submodule.${submodule_name}
  fi
  # - one of the comments about removing submodules said that config -f config was needed
  # - I found that after the previous command, I got only an error message from config -f config --remove -section...
  # - the error was "fatal: no such section: submodule.<submodule-name>"
  # punkt config --file config --remove-section submodule.${submodule_name}
  set +x
}


[[ ! -f ~/.local.zsh ]] || source ~/.local.zsh


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# See .zprofle for path and fpath and PATH

# the next time completions stop working: rm ~/.zcompdump*, and then autoload -U compinit && compinit
autoload -U compinit && compinit

# TODO: steal from https://natelandau.com/my-mac-os-zsh-profile/
# TODO: use the fzf hints https://github.com/sharkdp/bat/issues/357
#                         https://github.com/sharkdp/fd#using-fd-with-fzf
#                         https://github.com/lotabout/skim
# TODO: something like zcat https://github.com/sharkdp/bat/issues/237#issuecomment-617079288
# TODO: https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Accessing-On_002dLine-Help
#       this makes run-help bindkeys show the zsh man page for the bindkeys entry
#       see also https://stackoverflow.com/a/7060716/1698426 where I learned about run-help
# good primer on bools in bash https://stackoverflow.com/a/47876317/1698426
