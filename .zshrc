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
# The fat logo in each pane is too much
# if whence fastfetch > /dev/null; then
#   fastfetch
# elif whence neofetch > /dev/null; then
#   neofetch
# elif whence nerdfetch > /dev/null; then
#   nerdfetch
# fi
[[ -f ~/.motd ]] && source ~/.motd

unsetopt beep  # I hate, hate, hate being beeped at

# NB some of these feel very slow in the rs-cfe repo
# other oh-my-posh themese I like: (source https://ohmyposh.dev/docs/themes/)
all_oh_my_posh_themes=(
  1_shell.omp.json # needs newline # 2 -1, it does NOT need a newline, what? slightly too light on white background
  # aliens.omp.json # a bit too shiny and needs a newline -1
  amro.omp.json # 2 a bit too light on a light background
  darkblood.omp.json # 5 too light on a light background, otherwise great
  emodipt-extend.omp.json # 2
  fish.omp.json # 1 a bit too shiny # needs newline
  cobalt2.omp.json # needs newline # a bit too shiny
  honukai.omp.json # 4 some colour adjustments needed on light background
  illusi0n.omp.json # 1 needs newline
  kali.omp.json # 5 maybe change $ to > or ＞ FULLWIDTH GREATER-THAN SIGN Unicode: U+FF1E, UTF-8: EF BC 9E
  kushal.omp.json # 1 very slow
  lambdageneration.omp.json # 4 # not sure about the amber colour tho
  # montys.omp.json # 2 pretty but shiny -1, I think this one screws up the console with junk chars or something
  negligible.omp.json # needs newline 2
  paradox.omp.json # 3 # a bit too shiny
  powerlevel10k_rainbow.omp.json
  probua.minimal.omp.json # -1 illegible on white background
  pure.omp.json # 1
  # simweb.omp.json # -1
  slimfat.omp.json # 2
  sorin.omp.json # needs a newline before the cursor # 1
  stelbent-compact.minimal.omp.json
  takuya.omp.json
  thecyberden.omp.json # 1 # a bit too shiny
  # uew.omp.json # needs git info in the prompt and another newline 2, too light for light background
  wholespace.omp.json # 1 needs newline, very slow
  wopian.omp.json # 1
  ys.omp.json # 1
)
ri=$(( $RANDOM % ${#all_oh_my_posh_themes[@]} + 1)) # https://unix.stackexchange.com/a/287333
oh_my_posh_theme=${all_oh_my_posh_themes[$ri]}
echo "oh-my-posh theme ${oh_my_posh_theme}"

autoload -Uz zle-line-init  # some of these oh-my-posh themes complain `No such widget `zle-line-init'`, hopefully this will fix that...
eval "$(~/.oh-my-posh/oh-my-posh init zsh --config ~/.oh-my-posh/themes/${oh_my_posh_theme})"

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
setopt SHARE_HISTORY            # imports new commands from the history file, and also causes your typed commands to be appended to the history file
                                # also enables EXTENDED_HISTORY
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


alias r1='rg --max-depth=1'
alias r2='rg --max-depth=2'
alias r3='rg --max-depth=3'
alias r4='rg --max-depth=4'

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
    alias lr='ls -alrthG'
  else
    alias ll='ls -l --color=auto'
    alias lr='ls -alrth --color=auto'
  fi
fi


# alias vimr='vimr --nvim -O'  # Not sure I want to use vimr any more
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
  # IFS=  # I do not recall why this was even here...
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
  maxdepth=()
  if [[ "${1:0:2}" == '-d' ]]; then
    maxdepth="--max-depth=${2}"
    shift
    shift
  fi
  searchterm=$*
  shift
  nvim -O $(rg --color=never --files-with-matches ${maxdepth} ${searchterm}) $*
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
  fd ${@} -X nvim -O

  # TODO accept more than one search term

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


alias punkt='git -C ${HOME} --git-dir=${HOME}/.punkte/.git --work-tree=${HOME}'
# alias punkt-status='punkt status --ignore-submodules=all --untracked-files=no'


# similar to nvim-modified
function punkt-modified()
{
  # eval nvim -O printf "<(punkt diff -p %s) " $(punkt-status --short | awk '{if ($1 == "M" || $1 == "MM" || $1 == " M") print $2}')
  # nvim -O $(punkt -C ~ ls-files --modified --exclude-standard)  # https://stackoverflow.com/a/28280636/1698426
  pushd ${HOME} # file names from the line below are relative to ${HOME}
  nvim -O $(punkt status --short --untracked-files=no --ignore-submodules=all | cut -d' ' -f3)  # cut -w does not work everywhere
  popd
}


function punkt-is-repo()
{
  # return 1 if there is a tarball timestamp, and therefore not ~/.punkte is not a real git repo
  if [[ -f ${home_tarball_file_timestamp} ]]; then
    return 1
  fi
  return 0
}


function punkt-status()
{
  # man gitmodules: submodule.<name>.ignore
  if punkt-is-repo; then
    punkt status --ignore-submodules=all --untracked-files=no
    return $?
  fi
  echo "Not a punkt-repo, what now?"
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


home_tarball_file=/tmp/home.tar
home_tarball_file_zip=${home_tarball_file}.gz
home_tarball_file_timestamp=.punkt-timestamp.text
function punkt-ausführe()
{
  pushd ${HOME}
  # https://stackoverflow.com/a/23116607
  [[ -f ${home_tarball_file_zip} ]] && rm ${home_tarball_file_zip}
  punkt ls-files --full-name --recurse-submodules | tar Tcf - ${home_tarball_file}
  [[ -f .local.zsh ]] && tar --append --file=${home_tarball_file} .local.zsh
  date > ${home_tarball_file_timestamp}
  tar --append --file=${home_tarball_file} ${home_tarball_file_timestamp}
  rm -f ${home_tarball_file_timestamp} # this file must exist only on hosts where the home_tarball_file is used, not on hosts that have working ~/.punkt git repos
  gzip ${home_tarball_file}
  popd
  if [[ -f ${home_tarball_file_zip} ]]; then
    ls -l ${home_tarball_file_zip}
  else
    echo "Something went wrong, whar tarball ${home_tarball_file_zip}?"
    return 1
  fi
  echo "copy ${home_tarball_file_zip} to the destination computer"
  echo 'On the destination:'
  echo '1. apt install unzip fzf fd-find ripgrep bat'
  echo ' OR '
  echo '1. brew install fzf fd ripgrep bat go gnu-tar'
  echo '2. cd ~'
  echo "3. gtar xvf ${home_tarball_file_zip}"
  echo 'This gets more complicated on Ubuntu 24 which has an older version of go:'
  echo '4. wget https://go.dev/dl/go1.24.0.linux-amd64.tar.gz'
  echo ' OR '
  echo '4. wget https://go.dev/dl/go1.24.0.linux-arm64.tar.gz'
  echo '5. tar -C ${HOME}/bin -xzf go1.24.0.linux-amd64.tar.gz'
  echo ' OR '
  echo '5. tar -C ${HOME}/bin -xzf go1.24.0.linux-arm64.tar.gz'
  echo '6. ~/bin/go/bin/go build -C ~/.oh-my-posh/src -o ~/.oh-my-posh/oh-my-posh # when did this work, worked s-c-f'
  echo ' OR '
  echo '6. cd .oh-my-posh/src && ~/bin/go/bin/go build'
  echo 'https://ohmyposh.dev/docs/installation/linux'
  echo '6. apt install unzip fzf fd-find ripgrep bat'
  echo ' OR '
  echo '7. brew install fzf fd ripgrep bat'
  echo ' OR maybe'
  echo '8. mkdir -p ~/.oh-my-posh'
  echo '9. curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.oh-my-posh'
}


function punkt-aufbau()
{
  if ! punkt-is-repo; then
    echo "Since punkt is not a git repo, this is probably not what you want"
    echo "Maybe punkt-auf, since it checks for this?"
    return 1
  fi
  # https://gist.github.com/nicktoumpelis/11214362; see updates further down
  # Do not call git clean!! git clean recursively deletes files that are not under version control
  # https://stackoverflow.com/a/68086677/1698426
  punkt submodule foreach --recursive git reset --hard
  # if this is not enough, maybe 
  # git submodule deinit -f . && git submodule update --init --recursive
  punkt-auf
}


function punkt-einfüre()
{
  pushd ${HOME} > /dev/null 2>&1
  if [[ -f "${home_tarball_file_zip}" ]]; then
    if whence gtar > /dev/null; then # brew on macOS
      TAR=gtar
    else
      TAR=tar
    fi
    echo "Unpacking ${home_tarball_file_zip}"
    ${TAR} xvf "${home_tarball_file_zip}" > /dev/null 2>&1
    punkt-build-utils
  fi
  popd > /dev/null 2>&1
}


# https://german.stackexchange.com/questions/22438/repository-oder-repositorium
function punkt-auf()
{
  if ! punkt-is-repo; then
    echo "Not a punkt repo"
    punkt-einfüre
    return 0
  fi
  echo "Probably a real punkt repo"
  # https://stackoverflow.com/a/76182448/1698426
  echo "Pulling, ignoring submodules"
  punkt pull --stat --verbose --rebase --no-recurse-submodules
  echo "Updating submodules"
  punkt submodule update --init --remote --recursive --jobs=16 | column -t
  punkt-build-utils
}


function punkt-build-utils()
{
  local return_status=0
  pushd ${HOME} > /dev/null 2>&1
  if whence make > /dev/null; then
    make -C .vim/pack/vim8/start/telescope-fzf-native.nvim clean all
  else
    echo "Install make"
    return_status=1
  fi
  if whence go > /dev/null; then
    if [[ ! $(go env GOVERSION) < 'go1.23.0' ]]; then
      { go build -C .oh-my-posh/src -o .oh-my-posh/oh-my-posh }
    else
      echo "Get a newer version of go"
      return_status=1
    fi
  else
    echo "Install go"
    return_status=1
  fi
  popd > /dev/null 2>&1
  return ${return_status}
}


function punkt-zeige()
{
  if ! whence jq > /dev/null 2>&1; then
    echo "Install jq"
    return 1
  fi
  tojson=0
  short=0
  if [[ "${1}" == "--json" ]]; then
    tojson=1
    shift
  fi
  if [[ "${1}" == "--short" ]]; then
    short=1
    shift
  fi
  if [[ "${tojson}" -ne 0 ]]; then
    shift
    echo $(punkt-zu-json) | jq
  fi
  if [[ -n "${1}" ]]; then
    punkte-json=$(punkt-zu-json)
    echo "${punkte-json}" | jq -r ".[] | select(.submodule_name | contains(${1}))"  # still does not work
  else
    if [[ "${short}" -eq 1 ]]; then
      punkt submodule foreach 'if [[ "$*" =~ "--short" ]]; then echo submodule_name:$name; echo; fi'
    else
      punkt submodule foreach \
          'echo submodule_name:$name; echo displaypath:$displaypath; echo toplevel:$toplevel; echo sm_path:$sm_path; echo; git --no-pager config --list --show-origin; echo'
    fi
  fi
}


function punkt-zu-json()
{
  whence jo > /dev/null 2>&1
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
  if [[ ${WO} =~ $(whoami) || ${WO} =~ "home" || ${WO} =~ "Users" ]]; then
    echo "Do not add tilde or $HOME or \$HOME an absolute path to the destination directory"
    echo "Example:"
    echo "punkt-submodule-zutat https://github.com/NLKNguyen/papercolor-theme.git .vim/pack/vim8/start"
    echo "Do not do any of the following:"
    echo "punkt-submodule-zutat https://github.com/NLKNguyen/papercolor-theme.git ~/.vim/pack/vim8/start"
    echo "punkt-submodule-zutat https://github.com/NLKNguyen/papercolor-theme.git $HOME/.vim/pack/vim8/start"
    echo "punkt-submodule-zutat https://github.com/NLKNguyen/papercolor-theme.git \$HOME/.vim/pack/vim8/start"
    return -1
  fi
  STEM=${URL##*/}
  punkt submodule add $URL $WO/$STEM
}


function punkt-submodule-bringeum()
{
  # TODO this is still not reliable
  # TODO just use the equivelant of git rm, it deletes the working directory and the .gitmodules entry

  # to prevent a previous invocation of this function possibly still having these variables set:
  unset submodule_name
  unset displaypath
  unset toplevel
  unset sm_path

  if ! whence jq > /dev/null 2>&1; then
    echo "Install jq"
    return 1
  fi

  # https://stackoverflow.com/a/1260982/1698426
  # https://stackoverflow.com/a/7646931/1698426

  SUBMODULE_NAME="${1}"
  if [[ -z "${SUBMODULE_NAME}" ]]; then
    echo "Must provide a submodule"
    echo "Submoule must be passed in as reported by punkt status"
    echo "NB punkt-status does not show submodules"
    echo "See also punkt-zeige"
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


# requires autoload -Uz compinit && compinit
function zsh-completions-show-all
{
  # https://stackoverflow.com/a/40014760/1698426
  for command completion in ${(kv)_comps:#-*(-|-,*)}
  do
    printf "%-32s %s\n" $command $completion
  done | sort
}


functiom punkt-mini()
{
  # maybe install ~/.mini/* on a remote host?
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

whence batcat > /dev/null && alias bat='batcat'  # ubuntu
whence fdfind > /dev/null && alias fd='fdfind'  # ubuntu


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

# autoload -Uz compinit && compinit
# zsh can load bash completion functions! https://stackoverflow.com/a/70893451/1698426
# # Load bash completion functions
autoload -Uz +X compinit && compinit
autoload -Uz +X bashcompinit && bashcompinit



# https://postgresqlstan.github.io/cli/zsh-run-help/ https://unix.stackexchange.com/a/282649/30160 https://stackoverflow.com/a/7060716
(( $+aliases[run-help] )) && unalias run-help  # https://www.reddit.com/r/zsh/comments/g1srzn/comment/fnhomy8/
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-svk
autoload -Uz run-help-sudo
alias help=run-help

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
