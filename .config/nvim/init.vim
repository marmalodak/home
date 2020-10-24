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


" Use <control+w><control+w> to exit insert mode in a terminal
tnoremap <C-w><C-w> <C-\><C-n>
" Use <control+[> to exit insert mode in a terminal
tnoremap <C-[> <C-\><C-n>
