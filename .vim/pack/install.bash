#!/usr/bin/env bash

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
    set_group vim8_reboot
    package https://github.com/w0rp/ale &
    wait
) &

if [[ 0 == 1 ]]; then  # disable all packages until I decide on must-haves
(
    set_group imported_from_vundle
    package https://github.com/dhruvasagar/vim-table-mode.git &
    #  package scrooloose/syntastic &                            # consider using https://github.com/w0rp/ale since it takes advantage of vim 8's async
    package https://github.com/majutsushi/tagbar &
    # package https://github.com/davidhalter/jedi-vim &
    package https://github.com/ervandew/supertab &
    package https://github.com/junegunn/vim-easy-align &
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
