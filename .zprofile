# https://apple.stackexchange.com/a/388623
# https://unix.stackexchange.com/a/71258
#
# inspired by https://gist.github.com/marmalodak/1ec21ea5e2953aca3204ceb9baef29e4 for info on why .zshenv was moved to .zprofile
# Long discussion: https://gist.github.com/Linerre/f11ad4a6a934dcf01ee8415c9457e7b2 and also https://www.zsh.org/mla/users/2003/msg00600.html
# tl;dr incorporate .zprofile
# TODO steal fromo https://zsh.sourceforge.io/Contrib/startup/ and https://adamspiers.org/computing/zsh/
# https://zsh.sourceforge.io/Contrib/startup/std/zshrc
# https://zsh.sourceforge.io/Contrib/startup/std/zshenv


# brew might be installed in /opt or /usr/local
# the paths to util-linux/bin are needed on the mac so that setsid (from util-linux) is in the PATH
# https://stackoverflow.com/a/1397020  # see here on how to tell whether a directory is in the $PATH already
# NB there is no python3 binary in ~/Library/Python/... but pip3 install (--user) installs into ~/Library/Python/3.9/bin
# NB brew is already handled, do not add it here

[[ ! -d ~/.nvm ]] && mkdir ~/.nvm
[[ -d ${HOME}/.rvm/bin ]]                && PATH="${HOME}/.rvm/bin:${PATH}"
[[ -s "$HOME/.rvm/scripts/rvm" ]]        && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -d /opt/homebrew/bin ]]               && PATH="/opt/homebrew/bin:${PATH}"
[[ -d /opt/homebrew/sbin ]]              && PATH="/opt/homebrew/sbin:${PATH}"
[[ -d /opt/brew/opt/util-linux/bin ]]    && PATH="/opt/brew/opt/util-linux/bin:${PATH}"
[[ -d /opt/brew/opt/util-linux/sbin ]]   && PATH="/opt/brew/opt/util-linux/sbin:${PATH}"
[[ -d ${HOME}/bin ]]                     && PATH="${HOME}/bin:${PATH}"
[[ -d ${HOME}/.local/bin ]]              && PATH="${HOME}/.local/bin:${PATH}"  # fedora's pip --user path 

export PATH


export NVM_DIR="${HOME}/.nvm"
[[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ]]                    && \. "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
[[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ]] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion


pythons_base="${HOME}/Library/Python"
pythons=( ${pythons_base}/3.11/bin ${pythons_base}/3.10/bin ${pythons_base}/3.9/bin )
for p in ${pythons}; do
  if [[ -d "${p}" ]]; then
    PATH="${p}:${PATH}"
    # break  do not end here because multiple versions can be installed
  fi
done


# https://github.com/zsh-users/zsh-completions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src


## # installing Perl put these in my .zshrc
## PATH="${HOME}/perl5/bin${PATH:+:${PATH}}"; export PATH;
## PERL5LIB="${HOME}/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
## PERL_LOCAL_LIB_ROOT="${HOME}/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
## PERL_MB_OPT="--install_base \"${HOME}/perl5\""; export PERL_MB_OPT;
## PERL_MM_OPT="INSTALL_BASE=${HOME}/perl5"; export PERL_MM_OPT;
