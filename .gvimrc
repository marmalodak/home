set nocompatible
source $VIMRUNTIME/vimrc_example.vim
if has("gui_win32")
    source $VIMRUNTIME/mswin.vim
    behave mswin
endif

set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,ve:ver35-Cursor-blinkon0,o:hor50-Cursor-blinkon0,i-ci:ver25-Cursor/lCursor-blinkon0,r-cr:hor20-Cursor/lCursor-blinkon0,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
set guifont=Bitstream\ Vera\ Sans\ Mono\ 9,MiscFixed\ 10,Lucida_Console:h7:cANSI,Lucida_Console:h8:cANSI
" set guifont=MiscFixed\ 8,Lucida_Console:h7:cANSI,Lucida_Console:h8:cANSI

"  from amix.dk/vim/vimrc.html
set noerrorbells
set novisualbell
"  set t_vb=
"  set tm=500

set mousemodel=popup
set visualbell
set guioptions-=T
set guioptions+=m
set backupdir+=./.gvimbackup

set expandtab
set softtabstop=4
set shiftwidth=4
set smarttab
set nowrap

set showmode

"  I'm trying to follow vim tip #989 http://www.vim.org/tips/tip.php?tip_id=989 and adding formatoptions=l
    " au BufRead,BufWrite,BufNewFile *.txt setl formatoptions=ltcroqan1
augroup text
    au!
    au BufRead,BufWrite,BufNewFile *.txt setl formatoptions=lb
    au BufRead,BufWrite,BufNewFile *.txt setl comments=fb:-,fb:*
    au BufRead,BufWrite,BufNewFile *.txt setl wrap
    au BufRead,BufWrite,BufNewFile *.txt setl linebreak 
    au BufRead,BufWrite,BufNewFile *.txt setl autoindent
    au BufRead,BufWrite,BufNewFile *.txt setl textwidth=0
    au BufRead,BufWrite,BufNewFile *.txt setl wrapmargin=0
    au BufRead,BufWrite,BufNewFile *.txt setl expandtab
    au BufRead,BufWrite,BufNewFile *.txt setl shiftwidth=4
    au BufRead,BufWrite,BufNewFile *.txt setl softtabstop=4
    au BufRead,BufWrite,BufNewFile *.txt setl smarttab
augroup END

augroup mail
    au!
    au BufRead,BufWrite,BufNewFile .letter,mutt*,/tmp/mutt* setl formatoptions=lb
    au BufRead,BufWrite,BufNewFile .letter,mutt*,/tmp/mutt* setl comments=fb:-,fb:*
    au BufRead,BufWrite,BufNewFile .letter,mutt*,/tmp/mutt* setl wrap
    au BufRead,BufWrite,BufNewFile .letter,mutt*,/tmp/mutt* setl linebreak 
    au BufRead,BufWrite,BufNewFile .letter,mutt*,/tmp/mutt* setl autoindent
    au BufRead,BufWrite,BufNewFile .letter,mutt*,/tmp/mutt* setl textwidth=0
    au BufRead,BufWrite,BufNewFile .letter,mutt*,/tmp/mutt* setl wrapmargin=0
    au BufRead,BufWrite,BufNewFile .letter,mutt*,/tmp/mutt* setl expandtab
    au BufRead,BufWrite,BufNewFile .letter,mutt*,/tmp/mutt* setl shiftwidth=4
    au BufRead,BufWrite,BufNewFile .letter,mutt*,/tmp/mutt* setl softtabstop=4
    au BufRead,BufWrite,BufNewFile .letter,mutt*,/tmp/mutt* setl smarttab
    au BufRead,BufWrite,BufNewFile .letter,mutt*,/tmp/mutt* setl nomodeline
augroup END

filetype plugin indent on

" autocmd WinLeave * setlocal nocursorline 
" autocmd WinEnter * setlocal cursorline
" autocmd BufLeave * setlocal nocursorline 
" autocmd BufEnter * setlocal cursorline

"  source ~/.gvim/plugin/VimNotes.vim
"  - highlighter.vim is really cool but it issues error messages for files it
"  can't write to
"  source ~/.gvim/plugin/highlighter.vim

"  The cursorcolumn thing makes vim too slow
" autocmd WinLeave * setlocal nocursorcolumn nocursorline 
" autocmd WinEnter * setlocal cursorline cursorcolumn
" autocmd BufLeave * setlocal nocursorcolumn nocursorline 
" autocmd BufEnter * setlocal cursorline cursorcolumn

" highlight Statement gui=NONE
" highlight Normal    guibg=grey
highlight Normal    guifg=green guibg=black 
highlight Search    guifg=green guibg=#444444
highlight Visual    guifg=green guibg=#444444
highlight VisualNOS guifg=green guibg=#444444
highlight IncSearch guifg=green guibg=#444444
highlight Search guifg=green guibg=darkgrey

