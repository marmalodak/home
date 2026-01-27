# https://apple.stackexchange.com/a/388623
# https://unix.stackexchange.com/a/71258
#
# inspired by https://gist.github.com/marmalodak/1ec21ea5e2953aca3204ceb9baef29e4 for info on why .zshenv was moved to .zprofile
# Long discussion: https://gist.github.com/Linerre/f11ad4a6a934dcf01ee8415c9457e7b2 and also https://www.zsh.org/mla/users/2003/msg00600.html
# TODO steal from https://zsh.sourceforge.io/Contrib/startup/ and https://adamspiers.org/computing/zsh/
# https://zsh.sourceforge.io/Contrib/startup/std/zshrc
# https://zsh.sourceforge.io/Contrib/startup/std/zshenv


# brew might be installed in /opt or /usr/local
# https://stackoverflow.com/a/1397020  # see here on how to tell whether a directory is in the $PATH already
# $brew/{bin,sbin} is maybe already handled

brewpath=''
if whence brew > /dev/null; then
  brewpath=$(brew --prefix)
fi
[[ -d ${HOME}/bin/go/bin ]]                                && PATH="${HOME}/bin/go/bin:${PATH}"
[[ -d ${HOME}/.rvm/bin ]]                                  && PATH="${HOME}/.rvm/bin:${PATH}"
[[ -s "$HOME/.rvm/scripts/rvm" ]]                          && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -n ${brewpath} && -d ${brewpath}/opt/util-linux/bin ]]  && PATH="${brewpath}/opt/util-linux/bin:${PATH}"
[[ -n ${brewpath} && -d ${brewpath}/opt/util-linux/sbin ]] && PATH="${brewpath}/opt/util-linux/sbin:${PATH}"
[[ -d /usr/local/sbin ]]                                   && PATH="/usr/local/sbin:${PATH}"
[[ -d /usr/local/opt/util-linux/bin ]]                     && PATH="/usr/local/opt/util-linux/bin:${PATH}"
[[ -d /usr/local/opt/util-linux/sbin ]]                    && PATH="/usr/local/opt/util-linux/sbin:${PATH}"
[[ -d ${brewpath}/sbin ]]                                  && PATH="${brewpath}/sbin:${PATH}"
[[ -d ${HOME}/bin ]]                                       && PATH="${HOME}/bin:${PATH}"
[[ -d ${HOME}/.local/bin ]]                                && PATH="${HOME}/.local/bin:${PATH}"  # fedora's pip --user path 


if whence nvm > /dev/null; then  # nvm = Node Version Manager
  if [[ ! -d ~/.nvm ]]; then
    mkdir ~/.nvm
  fi
  export NVM_DIR="${HOME}/.nvm"
  if [[ -n ${brewpath} ]]; then
    [[ -s "${brewpath}/opt/nvm/nvm.sh" ]]                    && \. "${brewpath}/opt/nvm/nvm.sh" # This loads nvm
    [[ -s "${brewpath}/opt/nvm/etc/bash_completion.d/nvm" ]] && \. "${brewpath}/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
  fi
fi


# not sure if this is the right thing to do
# ~/Library/Python/* are only packages when `pip install --user` is invoked, no python3 interpreter is installed here
# IOW this doesn't actually do what I want
# if [[ ${OSTYPE} == darwin* ]]; then
#   # python stuff below needs work
#   pythons_base="${HOME}/Library/Python"
#   if [[ -d "${pythons_base}" ]]; then
#     pythons=( ${pythons_base}/*/bin )
#     for p in ${pythons}; do
#       if [[ -d "${p}" ]]; then
#         PATH="${p}:${PATH}"
#         export PATH
#         break  # do end here because stop at first one
#       fi
#     done
#   fi
# fi
# - Download Python from python.org and running their installer asks for permission to install in / somewhere
# - I want to avoid homebrew's Python
# - use uv, I guess? Maybe ~/.uv-venv?

export RIPGREP_CONFIG_PATH=~/.config/ripgrep/ripgreprc

export GROOVY_HOME=/opt/homebrew/opt/groovy/libexec
export JAVA_HOME=/opt/homebrew/Cellar/openjdk@21/21.0.10 # for groovyc

# https://github.com/zsh-users/zsh-completions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src


# I've gone back and forth with this a bunch of times, should there be a default venv?
# if [[ -f ${HOME}/.local-venv/bin/activate ]]; then
#   source ${HOME}/.local-venv/bin/activate
#   export PATH=${HOME}/.local-venv/bin:${PATH}
# fi

if [[ -d ${HOME}/.local/bin ]]; then
  export PATH=${HOME}/.local/bin:${PATH}
fi

# https://zsh.sourceforge.io/Guide/zshguide02.html#l24
# https://www.zsh.org/mla/users/1998/msg00490.html
typeset -U PATH
export PATH

## # installing Perl put these in my .zshrc
## PATH="${HOME}/perl5/bin${PATH:+:${PATH}}"; export PATH;
## PERL5LIB="${HOME}/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
## PERL_LOCAL_LIB_ROOT="${HOME}/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
## PERL_MB_OPT="--install_base \"${HOME}/perl5\""; export PERL_MB_OPT;
## PERL_MM_OPT="INSTALL_BASE=${HOME}/perl5"; export PERL_MM_OPT;
