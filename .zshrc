if [[ 0 == 1 ]]; then  # tmux run-shell hangs, why???
                       # there still appear to be tmux instances running even when I close the session...
    if [[ -o interactive ]]; then  # is zsh interactive?
        #if [[ -z "$TMUX" ]]; then
        tmux list-sessions > /dev/null 2>&1
        tmux_sessions=$?
        if [[ $tmux_session == 0 ]]; then
            if [[ $(tmux run-shell "echo #{session_attached}") == 0 ]]; then  # if the tmux session has zero attachers
                tmux attach
            fi
        fi
    fi
fi

# after upgrade to Fedora 33, I needed to do this:
export FPATH=$FPATH:/usr/share/zsh/5.8/functions

# I don't think I'm going to use this venv_activate, not even tested, but I'll decide in the future
# function venv_activate()
# {
#     if [[ -z "$1" ]] || [[ ! -r "$1" ]]; then
#         echo "Pass in a path to a python virtual environment"
#         exit 1
#     fi
#     # 1) set VIRTUAL_ENV 2) modify PATH 3) unset PYTHONHOME 4) and maybe set PS1?                                                                                                                                                                                                       │freenode  -- | - accept our policies and guidelines as set out on https://freenode.net                                                                         │freenode  -- | - accept our policies and guidelines as set out on https://freenode.net
#     #path_to_venv="$1"
#     unset PYTHONHOME
#     export VIRTUAL_ENV="$1"
#     export PATH=${VIRTUAL_ENV}/bin:$PATH
#     export PS1="($(basename ${VIRTUAL_ENV})${PS1}"
# }

[[ ! -f ~/.motd ]] || source ~/.motd

[[ -d /usr/local/brew/share/zsh/site-functions/ ]] && fpath+=(/usr/local/brew/share/zsh/site-functions/)

unsetopt beep  # I hate, hate, hate being beeped at

source ~/.powerlevel10k/powerlevel10k.zsh-theme

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# /usr/local/brew does not exist anymore.... right?
# # move /opt/brew/bin before /usr et al
# if [[ -e /usr/local/brew/bin ]]; then
#     # remove /usr/local/brew/bin
#     PATH=${PATH/:\/usr\/local\/brew\/bin//}
#     # put /usr/local/brew/bin at the front
#     PATH="/usr/local/brew/bin:$PATH"
# fi
export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH"

# https://unix.stackexchange.com/a/557490/30160
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
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git chucknorris colored-man-pages command-not-found virtualenv pep8)

source $ZSH/oh-my-zsh.sh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

zstyle ':completion:*' extra-verbose yes
zstyle ':completion:list-expand:*' extra-verbose yes

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vimr'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# https://github.com/Qix-/better-exceptions/
export BETTER_EXCEPTIONS=1

which exa > /dev/null 2>&1
exa_not_exists=$?

if [[ $exa_not_exists -ne 0 ]]; then
    alias ll='ls -l'
    alias lr='ls -alrth'
else
    alias ll='exa -l'
    alias lr='exa -alh --sort=date'
    alias lc='exa -1'
    alias lt='exa -T'
    alias ll='exa -l'
    alias lrg='exa -albh --sort=accessed --git'
    alias lRg='exa -albh --sort=accessed --git --extended'
fi

alias vimr='vimr --nvim -O'
alias pfzf='fzf --preview=bat {}'
alias ipoca='ip -o -c a'

function git_cmds()
{
    # TODO see list-<category> in command-list.txt, https://github.com/git/git/blob/master/command-list.txt
    set -x
    for cmd in builtins parseopt main others config; do
        git --list-cmds=${cmd}
    done
}

alias punkt='git -C $HOME/.punkte/.git --git-dir=$HOME/.punkte/.git --work-tree=$HOME'

function punkt_status()
{
    punkt status --ignore-submodules=all --untracked-files=no
}

function punkt_reset()
{
    punkt reset --hard origin/master
}

function punkt_new()
{
    set -x
    git clone https://github.com/marmalodak/home $HOME/.punkte
    punkt checkout -- $HOME
    punkt status --ignore-submodules=all --untracked-files=no
    echo "Jetzt führe diesen Befehl: punkt_auf"
}

function punkt_auf()
{
    set -x
    punkt pull --rebase
    punkt submodule update --init --remote --recursive --jobs=16
}

function punkt_zeige()
{
    if [[ "${1}" == "--json" ]]; then
        echo $(punkt_zu_json)
    elif [[ -n "${1}" ]]; then
        punkte_json=$(punkt_zu_json)
        echo "${punkte_json}" | jq -r '.[] | select(.submodule_name | contains("'${1}'"))'
    else
        punkt submodule foreach \
            'echo submodule_name:$name; echo displaypath:$displaypath; echo toplevel:$toplevel; echo sm_path:$sm_path; echo; git --no-pager config --list --show-origin; echo'
    fi
}

function punkt_zu_json()
{
    command -v jo > /dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        echo "Install jo"
        return 1
    fi
    echo $(jo -a $(punkt submodule foreach --quiet 'jo submodule_name=$name displaypath=$displaypath toplevel=$toplevel sm_path=$sm_path'))
}

function punkt_flachen()
{
    set -x
    # https://stackoverflow.com/a/37933909
    punkt submodule foreach 'git config -f ${HOME}/.punkte/.gitmodules submodule.$name.shallow true'
    punkt submodule foreach 'git config -f ${HOME}/.punkte/.git/config submodule.$name.shallow true'
}

function punkt_submodule_bringeum()
{
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
        echo "Submoule must be passed in as report by punkt status"
        echo "NB punkt_status does not show submodules"
        echo "See also punkt_zeige"
        return 1
    fi

    punkte_json=$(punkt_zu_json)
    set -x
    eval $(echo "${punkte_json}" | jq -r '.[] | select(.submodule_name=="'${SUBMODULE_NAME}'") | to_entries | .[] | .key + "=\"" + .value + "\""')

    # now these variables exist:
    # submodule_name=.zsh/zsh-autosuggestions
    # displaypath=../../.zsh/zsh-autosuggestions
    # toplevel=/Users/john
    # sm_path=.zsh/zsh-autosuggestions

    if [[ -z ${submodule_name} || -z ${displaypath} || -z ${toplevel} || -z ${sm_path} ]]; then
        echo "Achtung! Kein submodule gefunden!"
        return 1
    fi
    
    set -x

    punkt rm --force "${displaypath}"
    rm -rf "${toplevel}/.punkte/.git/modules/${submodule_name}"
    rm -rf "${toplevel}/${sm_path}"
    punkt config --remove-section submodule.${submodule_name}
    punkt config --file config --remove-section submodule.${submodule_name}

    echo
    echo "Beachte folgendes:"
    echo "1. punkt add ${toplevel}/.punkte/.git/modules ?"
    echo "2. punkt commit"
    echo "3. punkt push"
    echo
}


[[ ! -f ~/.local.zsh ]] || source ~/.local.zsh


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
