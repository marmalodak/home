# https://apple.stackexchange.com/a/388623
# https://unix.stackexchange.com/a/71258
# inspired by https://gist.github.com/marmalodak/1ec21ea5e2953aca3204ceb9baef29e4
#
# TODO WARNING on macOS /usr/libexec/path_helper changes the order of the entries in $PATH
# Long discussion: https://gist.github.com/Linerre/f11ad4a6a934dcf01ee8415c9457e7b2
# and also https://www.zsh.org/mla/users/2003/msg00600.html
# tl;dr incorporate .zprofile
# TODO steal from https://zsh.sourceforge.io/Contrib/startup/ and https://adamspiers.org/computing/zsh/
# https://zsh.sourceforge.io/Contrib/startup/std/zshrc
# https://zsh.sourceforge.io/Contrib/startup/std/zshenv


# brew might be installed in /opt or /usr/local; on an m1 mac it might be in a different place still
# the paths to util-linux/bin are needed on the mac so that setsid (from util-linux) is in the path
# https://stackoverflow.com/a/1397020  # see here on how to tell whether a directory is in the $PATH already


[[ -d /opt/brew/bin ]]                   && PATH="${PATH}:/opt/brew/bin:/opt/brew/sbin"
[[ -d /usr/local/bin ]]                  && PATH="${PATH}:/usr/local/bin"
[[ -d /usr/local/sbin ]]                 && PATH="${PATH}:/usr/local/sbin"
[[ -d /opt/brew/opt/util-linux/bin ]]    && PATH="/opt/brew/opt/util-linux/bin:${PATH}"   # since I'm not using setsid from util-linux, these two might be unneded
[[ -d /opt/brew/opt/util-linux/sbin ]]   && PATH="/opt/brew/opt/util-linux/sbin:${PATH}"
[[ -d ${HOME}/bin ]]                     && PATH="${HOME}/bin:${PATH}"
[[ -d ${HOME}/Library/Python/3.10/bin ]] && PATH="${HOME}/Library/Python/3.10/bin:${PATH}"  # ugh this will have to change for each version??
[[ -d ${HOME}/Library/Python/3.8/bin ]]  && PATH="${HOME}/Library/Python/3.8/bin:${PATH}"   # do not recall how 3.8 got here, seems like a bad idea to have both in the PATH
[[ -d ${HOME}/.rvm/bin ]]                && PATH="${HOME}/.rvm/bin:${PATH}"

# BUG: $HOME/bin is still not first in the $PATH

export PATH


## # installing Perl put these in my .zshrc
## PATH="${HOME}/perl5/bin${PATH:+:${PATH}}"; export PATH;
## PERL5LIB="${HOME}/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
## PERL_LOCAL_LIB_ROOT="${HOME}/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
## PERL_MB_OPT="--install_base \"${HOME}/perl5\""; export PERL_MB_OPT;
## PERL_MM_OPT="INSTALL_BASE=${HOME}/perl5"; export PERL_MM_OPT;
