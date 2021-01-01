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
ZSH_THEME="powerlevel10k/powerlevel10k"

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
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

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

function dotup()
{
    set -x
    (
        cd ${HOME}
        git pull --rebase
        git submodule update --init --remote --recursive --jobs=16
    )
}


[[ ! -f ~/.local.zsh ]] || source ~/.local.zsh


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
