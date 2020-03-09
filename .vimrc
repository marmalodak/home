"  consider implementing this: https://vimways.org/2018/from-vimrc-to-vim/
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

imap ;; <Esc>
imap jk <Esc>
imap kj <Esc>

set mousemodel=popup
set visualbell
" set noerrorbells
set guioptions-=T
set guioptions+=m

set expandtab
set softtabstop=4
set shiftwidth=4
set smarttab
set nowrap
set showmode
set showcmd
set backspace=indent,eol,start
set hlsearch
set incsearch
set lazyredraw

set path+=**  " https://github.com/mcantor/no_plugins/blob/master/no_plugins.vim
set wildmenu
set wildmode=list:longest,full

set laststatus=2 " Always display the statusline in all windows
set showtabline=1 " show the tabline only when two or more tabs are open
set showmode " show the default mode text (e.g. -- INSERT -- below the statusline)
set title "  show the name of the file being edited in the lower left

set spelllang=en_ca
set spellfile=~/spell/en.utf-8.add

set backup
set backupdir=~/.vimbackup/
au BufWritePre * let bakupdir="~/.vimbackup" . expand("%:p:h") |
               \ let bak="!mkdir -p " . bakupdir               |
               \ silent exec(bak)                              |
               \ exec("set backupdir=" . bakupdir)             |
               \ exec("set backupext=" . strftime("-%y%m%d-%H%M%S"))

set background=dark

" packadd matchit

"  I'm trying to follow vim tip #989 http://www.vim.org/tips/tip.php?tip_id=989 and adding formatoptions=l
    " au BufRead,BufWrite,BufNewFile *.txt setl formatoptions=ltcroqan1
augroup text
    au!
    au BufRead,BufWrite,BufNewFile *.txt,*.text setl formatoptions=lb
    au BufRead,BufWrite,BufNewFile *.txt,*.text setl comments=fb:-,fb:*
    au BufRead,BufWrite,BufNewFile *.txt,*.text setl wrap
    au BufRead,BufWrite,BufNewFile *.txt,*.text setl linebreak
    au BufRead,BufWrite,BufNewFile *.txt,*.text setl autoindent
    au BufRead,BufWrite,BufNewFile *.txt,*.text setl textwidth=0
    au BufRead,BufWrite,BufNewFile *.txt,*.text setl wrapmargin=0
    au BufRead,BufWrite,BufNewFile *.txt,*.text setl expandtab
    au BufRead,BufWrite,BufNewFile *.txt,*.text setl shiftwidth=4
    au BufRead,BufWrite,BufNewFile *.txt,*.text setl softtabstop=4
    au BufRead,BufWrite,BufNewFile *.txt,*.text setl smarttab
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

autocmd WinLeave * setlocal nocursorline
autocmd WinEnter * setlocal   cursorline
autocmd BufLeave * setlocal nocursorline
autocmd BufEnter * setlocal   cursorline

let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips/' , 'Ultisnips']

" http://stackoverflow.com/a/26551079/1698426
" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <C-A> :ZoomToggle<CR>

"  http://stackoverflow.com/a/11865489/1698426
func! Eatchar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc
" iabbr <silent> if if ()<Left><C-R>=Eatchar('\s')<CR>

" does not work for me, why?
" iabbr <silent> ≤≤ «<c-r>=eatchar('\m\s\<bar>/')<cr>
" iabbr <silent> ≥≥ »<c-r>=eatchar('\m\s\<bar>/')<cr>
" iabbr ≤≤ «
" iabbr ≥≥ »

" https://www.reddit.com/r/vim/comments/bozr66/finding_things_in_vim/ennq4i5?utm_source=share&utm_medium=web2x
command! -bang -nargs=* History call fzf#vim#history(fzf#vim#with_preview({'options': '--no-sort'}))

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" https://github.com/jhawthorn/fzy#use-with-vim
" function! FzyCommand(choice_command, vim_command)
"   try
"     let output = system(a:choice_command . " | fzy ")
"   catch /Vim:Interrupt/
"     " Swallow errors from ^C, allow redraw! below
"   endtry
"   redraw!
"   if v:shell_error == 0 && !empty(output)
"     exec a:vim_command . ' ' . output
"   endif
" endfunction

" nnoremap <leader>e :call FzyCommand("find . -type f", ":e")<cr>
" nnoremap <leader>v :call FzyCommand("find . -type f", ":vs")<cr>
" nnoremap <leader>s :call FzyCommand("find . -type f", ":sp")<cr>

" Any program can be used to filter files presented through fzy. ag (the silver searcher) can be used to ignore files specified by .gitignore.

" nnoremap <leader>e :call FzyCommand("ag . --silent -l -g ''", ":e")<cr>
" nnoremap <leader>v :call FzyCommand("ag . --silent -l -g ''", ":vs")<cr>
" nnoremap <leader>s :call FzyCommand("ag . --silent -l -g ''", ":sp")<cr>


" suggested bindings for vim-quickhl
" Minimum

" nmap <Space>m <Plug>(quickhl-manual-this)
" xmap <Space>m <Plug>(quickhl-manual-this)
" nmap <Space>M <Plug>(quickhl-manual-reset)
" xmap <Space>M <Plug>(quickhl-manual-reset)

" Full

" nmap <Space>m <Plug>(quickhl-manual-this)
" xmap <Space>m <Plug>(quickhl-manual-this)

" nmap <Space>w <Plug>(quickhl-manual-this-whole-word)
" xmap <Space>w <Plug>(quickhl-manual-this-whole-word)

" nmap <Space>c <Plug>(quickhl-manual-clear)
" vmap <Space>c <Plug>(quickhl-manual-clear)

" nmap <Space>M <Plug>(quickhl-manual-reset)
" xmap <Space>M <Plug>(quickhl-manual-reset)

" nmap <Space>j <Plug>(quickhl-cword-toggle)
" nmap <Space>] <Plug>(quickhl-tag-toggle)
" map H <Plug>(operator-quickhl-manual-this-motion)


" https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

let g:powerline_pycmd = "py3"
let g:powerline_pyeval = "py3eval"
let g:Powerline_symbols = 'fancy'

" Run these commands after all .vimrc commands and after all packages/plugins
augroup PostStartup
    if exists('g:airline_section_a')
        au VimEnter * set statusline+=%#warningmsg#
        if exists(':SyntasticStatuslineFlag')
            au VimEnter * set statusline+=%{SyntasticStatuslineFlag()}
        else
            " echo "Syntastic seems to be uninstalled"
        endif
        au VimEnter * set statusline+=%*

        if exists(':SyntasticStatuslineFlag')
            au VimEnter * let g:syntastic_always_populate_loc_list = 1
            au VimEnter * let g:syntastic_auto_loc_list = 1
            au VimEnter * let g:syntastic_check_on_open = 1
            au VimEnter * let g:syntastic_check_on_wq = 0
            au VimEnter * let g:airline_powerline_fonts = 1
            au VimEnter * let g:airline_theme='raven'
        endif
    else
        set statusline=
        set statusline+=%#PmenuSel#
        if exists(':StatuslineGit')
            set statusline+=%{StatuslineGit()}
        endif
        set statusline+=%#LineNr#
        set statusline+=\ %f
        set statusline+=%m\
        set statusline+=%=
        set statusline+=%#CursorColumn#
        set statusline+=\ %y
        set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
        set statusline+=\[%{&fileformat}\]
        set statusline+=\ %p%%
        set statusline+=\ %l:%c
        set statusline+=\ 
    endif


    " https://github.com/andviro/flake8-vim

    " Auto-check file for errors on write:
    au VimEnter * let g:PyFlakeOnWrite = 1

    " List of checkers used:
    au VimEnter * let g:PyFlakeCheckers = 'pep8,mccabe,frosted'
    " Default maximum complexity for mccabe:

    au VimEnter * let g:PyFlakeDefaultComplexity=10
    " List of disabled pep8 warnings and errors:

    au VimEnter * let g:PyFlakeDisabledMessages = 'E501'

    " Default aggressiveness for autopep8:
    au VimEnter * let g:PyFlakeAggressive = 0

    " Default height of quickfix window:
    au VimEnter * let g:PyFlakeCWindow = 6

    " Whether to place signs or not:
    au VimEnter * let g:PyFlakeSigns = 1

    " When usign signs, this is the first id that will be used to identify the
    " signs. Tweak this if you are using other plugins that also use the sign
    " gutter
    au VimEnter * let g:PyFlakeSignStart = 1

    " Maximum line length for PyFlakeAuto command
    au VimEnter * let g:PyFlakeMaxLineLength = 100

    " Visual-mode key command for PyFlakeAuto
    au VimEnter * let g:PyFlakeRangeCommand = 'Q'

    " au VimEnter * helptags ALL
augroup END

" I want to see the name of linter which is giving me an error message
let g:ale_echo_msg_format = '%linter% says %s'

colorscheme NedsDarkTheme

" When updating packages, sometimes packages help tags are not regenerated
" Fix that with :1000verbose :helptags ALL
