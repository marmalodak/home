#!/usr/bin/env bash

set -x  # verbose debugging
set -e  # abort on first error
set -u  # aborts on unset variables
set -o pipefail
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'

# https://github.com/camfowler/vim/blob/master/pack/install.sh

# Create new folder in ~/.vim/pack that contains a start folder and cd into it.
#
# Arguments:
#   package_group, a string folder name to create and change into.
#
# Examples:
#   set_group syntax-highlighting
#
function set_group () {
  package_group=$1
  path="$HOME/.vim/pack/$package_group/start"
  mkdir -p "$path"
  cd "$path" || exit
}

# Clone or update a git repo in the current directory.
#
# Arguments:
#   repo_url, a URL to the git repo.
#
# Examples:
#   package https://github.com/tpope/vim-endwise.git
#
function package () {
  repo_url=$1
  expected_repo=$(basename "$repo_url" .git)
  if [ -d "$expected_repo" ]; then
    cd "$expected_repo" || exit
    result=$(git pull --force)
    echo "$expected_repo: $result"
  else
    echo "$expected_repo: Installing..."
    git clone -q "$repo_url"
  fi
}

(
    set_group vim8
    package https://github.com/w0rp/ale                           &
    package https://github.com/dbmrq/vim-howdy                    &
    package https://github.com/tmux-plugins/vim-tmux-focus-events &
    package https://github.com/sjl/vitality.vim                   &
    package https://github.com/tmux-plugins/vim-tmux              &
    package https://github.com/vimwiki/vimwiki                    &
    package https://github.com/baruchel/vim-notebook              &
    package https://github.com/dhruvasagar/vim-table-mode.git     &
    package https://github.com/dhruvasagar/vim-dotoo              &
    package https://github.com/vim-voom/VOoM                      &
    package https://github.com/markonm/traces.vim                 &
    package https://github.com/AndrewRadev/splitjoin.vim          &
    package https://github.com/hauleth/sad.vim                    &
    package https://github.com/junegunn/vim-easy-align            &
    package https://github.com/drmikehenry/vim-extline            &
    package https://github.com/yuttie/comfortable-motion.vim      &
    package https://github.com/tpope/vim-commentary               &
    package https://github.com/urbainvaes/vim-tmux-pilot          &
    package https://github.com/mhinz/vim-startify                 &
    package https://github.com/metakirby5/codi.vim                &
    package https://github.com/dansomething/vim-hackernews        &
    package https://github.com/gcmt/wildfire.vim                  &
    package https://github.com/vim-voom/VOoM                      &
    package https://github.com/ryanoasis/vim-devicons             &
    package https://github.com/dhruvasagar/vim-table-mode.git     &
    package https://github.com/machakann/vim-sandwich             &
    package https://github.com/junegunn/vim-easy-align            &
    package https://github.com/junegunn/fzf.vim                   &
    package https://github.com/dylanaraps/fff.vim                 &
    package https://github.com/airblade/vim-gitgutter             &

    # consider:
    # visual-star-search
    # vim-lion vim-easy-align tabular
    # targets.vim
    # clever-f
    # vim-wordmotion
    # "nerdtree git"
    # VimCompletesMe and others
    # Ultisnips
    # vim-test
    # vim-closer vim-endwise
    # vim-abolish
    # Fugitive
    # vim-projectionist
    # vim-sleuth
    # vim-ragtag
    # vim-surround
    # vim-repeat
    # vim-unimpaired
    # nvvim   https://github.com/cwoac/nvvim
    # https://wynnnetherland.com/journal/reed-esau-s-growing-list-of-vim-plugins-for-writers/
    # wakatime https://wakatime.com/vim
    # https://github.com/dhruvasagar/vim-prosession  requires https://github.com/tpope/vim-obsession
    # learn enough emacs to use org-mode like http://doc.norang.ca/org-mode.html
    # https://github.com/dhruvasagar/vim-vinegar
    # enmasse
    # asyncomplete and vim-lsp
    # https://github.com/lifepillar/vim-mucomplete
    # package https://github.com/vimoutliner/vimoutliner.git        & # compare to voom
    # vim-indent-object

    wait
) &

if [[ 0 == 1 ]]; then  # disable all packages until I decide on must-haves
(
    set_group imported_from_vundle
    #  package scrooloose/syntastic &                            # consider using https://github.com/w0rp/ale since it takes advantage of vim 8's async
    package https://github.com/majutsushi/tagbar &
    # package https://github.com/davidhalter/jedi-vim &
    package https://github.com/ervandew/supertab &
    # package https://github.com/Lokaltog/vim-powerline.git &    # airline?
    package https://github.com/godlygeek/tabular.git &
    package https://github.com/vim-pandoc/vim-pandoc.git &
    package https://github.com/t9md/vim-choosewin.git &
    # package https://github.com/powerline/powerline &           # airline?
    # package https://github.com/tpope/vim-surround.git &
    package https://github.com/vim-airline/vim-airline &
    package https://github.com/vim-airline/vim-airline-themes &
    wait
) &
fi


wait

echo "Plugins that have not been updated by this script:"
find */*/*/.git -prune -mtime 0.01

set +x  # verbose debugging
set +e  # abort on first error
set +u  # aborts on unset variables
set +o pipefail
