# https://apple.stackexchange.com/a/388623
# https://unix.stackexchange.com/a/71258
#
# inspired by https://gist.github.com/marmalodak/1ec21ea5e2953aca3204ceb9baef29e4 for info on why .zshenv was moved to .zprofile
# Long discussion: https://gist.github.com/Linerre/f11ad4a6a934dcf01ee8415c9457e7b2 and also https://www.zsh.org/mla/users/2003/msg00600.html
# tl;dr incorporate .zprofile
# TODO steal from https://zsh.sourceforge.io/Contrib/startup/ and https://adamspiers.org/computing/zsh/
# https://zsh.sourceforge.io/Contrib/startup/std/zshrc
# https://zsh.sourceforge.io/Contrib/startup/std/zshenv
# TODO test whether brew is installed: hint: not on linux
# TODO test for nvm
# TODO test for rvm


# brew might be installed in /opt or /usr/local
# the paths to util-linux/bin are needed on the mac so that setsid (from util-linux) is in the PATH
# https://stackoverflow.com/a/1397020  # see here on how to tell whether a directory is in the $PATH already
# NB there is no python3 binary in ~/Library/Python/... but pip3 install (--user) installs into ~/Library/Python/3.9/bin
# NB brew/{bin,sbin} is already handled, do not add it here

brewpath=$(brew --prefix)
[[ -d ${HOME}/bin/go/bin ]]                && PATH="${HOME}/bin/go/bin:${PATH}"
[[ -d ${HOME}/.rvm/bin ]]                  && PATH="${HOME}/.rvm/bin:${PATH}"
[[ -s "$HOME/.rvm/scripts/rvm" ]]          && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -d ${brewpath}/opt/util-linux/bin ]]  && PATH="${brewpath}/opt/util-linux/bin:${PATH}"
[[ -d ${brewpath}/opt/util-linux/sbin ]] && PATH="${brewpath}/opt/util-linux/sbin:${PATH}"
[[ -d /usr/local/sbin ]]                   && PATH="/usr/local/sbin:${PATH}"
[[ -d /usr/local/opt/util-linux/bin ]]     && PATH="/usr/local/opt/util-linux/bin:${PATH}"
[[ -d /usr/local/opt/util-linux/sbin ]]    && PATH="/usr/local/opt/util-linux/sbin:${PATH}"
[[ -d ${HOME}/bin ]]                       && PATH="${HOME}/bin:${PATH}"
[[ -d ${HOME}/.local/bin ]]                && PATH="${HOME}/.local/bin:${PATH}"  # fedora's pip --user path 

export PATH


[[ ! -d ~/.nvm ]] && mkdir ~/.nvm  # nvm = Node Version Manager; why was this dir created?
export NVM_DIR="${HOME}/.nvm"
if whence brew > /dev/null; then
  [[ -s "${brewpath}/opt/nvm/nvm.sh" ]]                    && \. "${brewpath}/opt/nvm/nvm.sh" # This loads nvm
  [[ -s "${brewpath}/opt/nvm/etc/bash_completion.d/nvm" ]] && \. "${brewpath}/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
fi


if [[ "${OSTYPE}" == *"darwin"* ]]; then
  # python stuff below needs work
  pythons_base="${HOME}/Library/Python"
  pythons=( ${pythons_base}/*/bin )
  for p in ${pythons}; do
    if [[ -d "${p}" ]]; then
      PATH="${p}:${PATH}"
      export PATH
      break  # do end here because stop at first one
    fi
  done
fi

export RIPGREP_CONFIG_PATH=~/.config/ripgrep/ripgreprc

export GROOVY_HOME=/opt/homebrew/opt/groovy/libexec

# https://github.com/zsh-users/zsh-completions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src


## # installing Perl put these in my .zshrc
## PATH="${HOME}/perl5/bin${PATH:+:${PATH}}"; export PATH;
## PERL5LIB="${HOME}/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
## PERL_LOCAL_LIB_ROOT="${HOME}/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
## PERL_MB_OPT="--install_base \"${HOME}/perl5\""; export PERL_MB_OPT;
## PERL_MM_OPT="INSTALL_BASE=${HOME}/perl5"; export PERL_MM_OPT;
