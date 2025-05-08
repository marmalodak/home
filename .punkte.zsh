alias punkt='git -C ${HOME} --git-dir=${HOME}/.punkte/.git --work-tree=${HOME}'


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
  # return 0 if ~/.punkte is a real git repo
  if [[ -f ${home_tarball_file_timestamp} ]]; then
    return 1 # if there is a tarball timestamp we are here because punkt-einfüre/punkt-ausführe
  fi
  if [[ ! -d ~/.punkte ]]; then # this probably the only test that is actually needed
    return 1
  fi
  punkt show > /dev/null # returns 128 if ~/.punkte is not a git repo
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
  [[ -f ${home_tarball_file} ]]     && rm ${home_tarball_file}
  [[ -f ${home_tarball_file_zip} ]] && rm ${home_tarball_file_zip}
  punkt ls-files --full-name --recurse-submodules | tar Tcf - ${home_tarball_file}
  [[ -f .local.zsh ]] && tar --append --file=${home_tarball_file} .local.zsh
  date > ${home_tarball_file_timestamp}
  tar --append --file=${home_tarball_file} ${home_tarball_file_timestamp}
  rm -f ${home_tarball_file_timestamp} # this file must exist only on hosts where the home_tarball_file is used, not on hosts that have working ~/.punkt git repos
  infocmp alacritty > alacritty.terminfo # https://www.yaroslavps.com/weblog/fix-broken-terminal-ssh/
  tar --append --file=${home_tarball_file} alacritty.terminfo
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
    tic -x alacritty.terminfo # https://www.yaroslavps.com/weblog/fix-broken-terminal-ssh/
    punkt-build-utils
    mv "${home_tarball_file_zip}" "${home_tarball_file_zip}.done"
  else
    echo "No ${home_tarball_file_zip}, nothing to do"
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
  if punkt pull --stat --verbose --rebase --no-recurse-submodules; then
    echo "Updating submodules"
    punkt submodule update --init --remote --recursive --jobs=16 | column -t
    punkt pull --recurse-submodules --jobs=16 | column -t
    # - on a brand new install, the preceding line failed, which aborted the whole `submodule update`
    # - might have to do each individually?
    punkt-build-utils
  else
    echo
    echo "Do you have uncommitted changes?"
    echo
    punkt-status
  fi
}


function punkt-build-utils()
{
  # install nerd fonts? e.g. https://github.com/aorith/blueconfig/blob/master/post-install/manual/install-fonts.sh
  local return_status=0
  pushd ${HOME} > /dev/null 2>&1
  if whence make > /dev/null; then
    make -C .vim/pack/vim8/start/telescope-fzf-native.nvim clean all
  else
    echo "Install make"
    return_status=1
  fi
  if whence go > /dev/null; then
    if [[ ! $(go env GOVERSION) < 'go1.24.0' ]]; then # zsh has no <= >= for strings?
      { go build -C ~/.oh-my-posh/src -o ~/.oh-my-posh/oh-my-posh }
    else
      echo "Get a newer version of go"
      go_get
      return_status=$?
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


function go_get()
{
  if [[ ${OSTYPE} != "linux-gnu" ]]; then
    echo "Use brew on the Mac to get GO"
    return -1
  fi
  if [[ -f ${HOME}/bin/go ]]; then
    echo "Should the old ${HOME}/bin/go be deleted/saved first?"
    return -1
  fi
  local arch_host=$(arch)
  if [[ ${arch_host} == "x86_64" ]]; then
    wget https://go.dev/dl/go1.24.0.linux-amd64.tar.gz
    tar -C ${HOME}/bin -xzf go1.24.0.linux-amd64.tar.gz
  elif [[ ${arch_host} == "arm64" || ${arch_host} == "aarch64" ]]; then
    wget https://go.dev/dl/go1.24.0.linux-arm64.tar.gz
    tar -C ${HOME}/bin -xzf go1.24.0.linux-arm64.tar.gz
  else
    echo "Arch = ${arch_host} !?!?"
    return 1
  fi
}
