set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
set termguicolors

set backup
set backupdir=~/.nvimbackup/
au BufWritePre * let bakupdir="~/.nvimbackup" . expand("%:p:h") |
               \ let bak="!mkdir -p " . bakupdir                |
               \ silent exec(bak)                               |
               \ exec("set backupdir=" . bakupdir)              |
               \ exec("set backupext=" . strftime("-%y%m%d-%H%M%S"))
