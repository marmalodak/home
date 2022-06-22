"  consider implementing this: https://vimways.org/2018/from-vimrc-to-vim/
if !has('nvim')
    unlet! skip_defaults_vim
    source $VIMRUNTIME/defaults.vim
endif

" TODO: make it modular
" https://stackoverflow.com/questions/25827839/modular-vimrc-how-to-source-vundle-plugins-from-diffrent-files
" https://github.com/todd-dsm/vimSimple
" https://github.com/ArtBIT/vim-modularvimrc
" https://github.com/sunaku/.vim
" https://github.com/jefflasslett/mod-vim
" https://www.hiteshpaul.com/posts/1378/
"
" TODO: find a way to make `gx` work
" There seem to be bugs in either vim 8.2 and/or the netrw plugin
" https://github.com/vim/vim/issues/4738
" https://github.com/vim/vim/pull/7188
" https://vi.stackexchange.com/questions/2801/how-can-i-make-gx-recognise-full-urls-in-vim if this is going to work in an asciidoc then the opening square brace or space have to be the delimiter, see netrw_gx and <cWORD>
" https://vi.stackexchange.com/questions/22459/gx-doesnt-open-the-url-and-complains-netrw-no-line-in-buffer/22505#22505
" https://stackoverflow.com/questions/9458294/open-url-under-cursor-in-vim-with-browser
" https://vim.fandom.com/wiki/Open_file_under_cursor
" https://stackoverflow.com/questions/34428944/how-to-enable-gx-in-vim-mine-doesnt-work-anymore
" https://vi.stackexchange.com/questions/5032/gx-not-opening-url-in-gvim-but-works-in-terminal
" https://stackoverflow.com/questions/62378898/iterm2-open-link-under-cursor-in-vim
" https://github.com/ThePrimeagen/.dotfiles/blob/874636dad3cbcad6ca96982047025181684993f2/nvim/.config/nvim/init.vim#L146  interesting key bindings
" https://old.reddit.com/r/neovim/comments/rfrgq5/is_it_possible_to_do_something_like_his_on/ vim-schlepp vim-move

" TODO: colors
" https://jeffkreeftmeijer.com/vim-16-color/

" cmap w!! w !sudo tee %
" or better yet, never run vim with sudo, use sudoedit
"   from https://stackoverflow.com/a/726920/1698426

let mapleader=" "

" until the issue with gx being broken in netrw... this came from the @vim slack channel
nmap gx viW"ay:!open <C-R>a &<CR><cr>

" timeoutlen affects the bindings ;; jk kj oo OO
set timeoutlen=200

" NB the following mappings do not work in paste mode
imap ;; <Esc>
imap jk <Esc>
imap kj <Esc>

" https://stackoverflow.com/questions/16134457/insert-a-newline-without-entering-in-insert-mode-vim#comment72864813_16136133
nnoremap oo m`o<Esc>``
nnoremap OO m`O<ESC>``

" https://old.reddit.com/r/vim/comments/nlvrhd/vimmers_of_reddit_whats_an_unknown_tip_that_has/gzm30z3/
nnoremap <Leader>p :e #<Enter>
nnoremap <Leader>n :bnext<Enter>

" reselect pasted text #  https://vimtricks.com/p/reselect-pasted-text/
nnoremap gp `[v`]

set mouse=
if !has('nvim')
    set ttymouse=
endif

" I want no beeps of any kind, ever! see :he visualbell
set noerrorbells
set visualbell
set vb t_vb=

" Do the guioptions apply to things like vimR?
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
set undofile
set splitright

set path+=**  " https://github.com/mcantor/no_plugins/blob/master/no_plugins.vim
set wildmenu
set wildmode=list:longest,full

set laststatus=2  " Always display the statusline in all windows
set showtabline=1 " show the tabline only when two or more tabs are open
set showmode      " show the default mode text (e.g. -- INSERT -- below the statusline)
set title         "  show the name of the file being edited in the lower left

" gitgutter and punkte  https://github.com/airblade/vim-gitgutter/issues/754
let g:gitgutter_git_args='--git-dir=${HOME}/.punkte --work-tree=${HOME}'

" shut up snipmate
let g:snipMate = { 'snippet_version' : 1 }

" I want lightline to show the full path of the file I'm editing
let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified' ] ],
    \  'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat' ], [ 'fileencoding', 'filetype' ] ]
    \ },
    \ 'inactive': {
    \     'left': [ [ 'absolutepath' ] ],
    \    'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat' ], [ 'fileencoding', 'filetype' ] ]
    \ },
    \ }

set spelllang=en_ca
set spellfile=~/spell/en.utf-8.add

set backup
set backupdir=~/.vimbackup/
au BufWritePre * let bakupdir="~/.vimbackup" . expand("%:p:h") |
               \ let bak="!mkdir -p " . bakupdir               |
               \ silent exec(bak)                              |
               \ exec("set backupdir=" . bakupdir)             |
               \ exec("set backupext=" . strftime("-%y%m%d-%H%M%S"))

" see https://github.com/mhinz/vim-startify/issues/428#issuecomment-704326443
" for inspiration for startify_lists
function! s:git_diff()
    let files = systemlist('git diff --name-only --ignore-submodules=all')
    if v:shell_error == 0
        return map(files, "{'line': v:val, 'path': v:val}")
    endif
    let files = systemlist('git --git-dir=$HOME/.punkte/.git diff --name-only --ignore-submodules=all')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction
let g:startify_lists = [
        \ { 'type': 'files',                    'header': ['   Recent files']},
        \ { 'type': function('s:git_diff'),     'header': ['   git diffs']},
        \ { 'type': 'sessions',                 'header': ['   Sessions']},
        \ { 'type': 'bookmarks',                'header': ['   Bookmarks']},
        \ ]
let g:startify_files_number = 40
let g:startify_custom_header = [
        \ ' R replace mode                                                                                                      ',
        \ '                                                                                                                     ',
        \ ' ctrl-O    go to previous point in the jump list                                                                     ',
        \ ' ctrl-^    edit the alternate file                                                                                   ',
        \ ' :brewind  go to first buffer in buffer list                                                                         ',
        \ ' :bf[irst] same as :brewind                                                                                          ',
        \ ' e#                                                                                                                  ',
        \ '                                                                                                                     ',
        \ ' ''. Go to the spot where the last edit was made                                                                      ',
        \ ' ''". Go to the spot where the the cursor was when this buffer was last opened                                        ',
        \ ' ''^. Go to the spot where the cursor last exited insert mode                                                         ',
        \ '                                                                                                                     ',
        \ 'gv             reselect the last visual selection # https://vimtricks.com/p/vimtrick-reselect-last-visual-selection/ ',
        \ ']s             move to next misspelled word                                                                          ',
        \ 'zg             add word to spellfile                                                                                 ',
        \ 'zw             mark word as bad word                                                                                 ',
        \ 'zuw            undo zw                                                                                               ',
        \ 'zug            undo zg                                                                                               ',
        \ 'z=             suggest spelling                                                                                      ',
        \ ':spellr[epall] repeat z=                                                                                             ',
        \ '                                                                                                                     ',
        \ 'yiw viwp       to replace the word under cursor by paste  # kttps://stackoverflow.com/a/21318895/1698426             ',
        \ 'ciw ctrl+r 0   similar                                    # https://stackoverflow.com/a/7797201/1698426              ',
        \ '                                                                                                                     ',
        \ ' insert mode:                                                                                                        ',
	\ 'ctrl-h – Delete previous character (same as backspace)                                                               ',
	\ 'ctrl-w – Delete previous word                                                                                        ',
	\ 'ctrl-u – Delete entire line (except any indent)                                                                      ',
	\ 'ctrl-t – Indent the current line                                                                                     ',
	\ 'ctrl-d – Backdent the current line                                                                                   ',
        \ '                                                                                                                     ',
        \ ':help function()                                                                                                     ',
        \ ':help options                                                                                                        ',
        \ ':help i_ctrl-a                                                                                                       ',
        \ ':help get<C-d>                                                                                                       ',
        \ '                                                                                                                     ',
        \ ':Files browse files with fzf                                                                                         ',
        \ ':GFiles browse git files with fzf                                                                                    ',
        \ ':Rg search contents of files                                                                                         ',
        \ '                                                                                                                     ',
        \ 'use :set option? to check the value of an option,                                                                    ',
        \ 'use :verbose set option? to also see where it was last set.                                                          ',
        \ '                                                                                                                     ',
        \ 'export MANPAGER="nvim +Man!"; use gO; see https://www.reddit.com/r/neovim/comments/k5dykf/                           ',
        \ '                                                                                                                     ',
        \ 'Control+u in insert mode is UNDO                                                                                     ',
        \ 'R enters replace mode, over write like old school editors                                                            ',
        \ 'c is change, C is change for the whole line                                                                          ',
        \ '                                                                                                                     ',
        \ ':enew!|pu=execute(''verbose map'') show all mappings and where they are defined                                        ',
        \ ':verbose map <leader>            all mapping in all modes that use <leader>                                          ',
        \ ':verbose map <buffer>            all mappings defined for the current buffer                                         ',
        \ ':verbose nmap <leader>           all normal mode mappings that use <leader>                                          ',
        \ '                      source: https://stackoverflow.com/a/20083301/1698426                                           ',
        \ ]
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

" https://stackoverflow.com/a/14449484/1698426
" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" vviki
nnoremap <leader>ww :e ~/wiki/index.adoc<CR>

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
nnoremap <silent> <leader>z :ZoomToggle<CR>
" nnoremap <silent> <C-A> :ZoomToggle<CR>

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

" cursor shape for terminals
" https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h4-Functions-using-CSI-_-ordered-by-the-final-character-lparen-s-rparen:CSI-Ps-SP-q.1D81
" CSI Ps SP q
"           Set cursor style (DECSCUSR), VT520.
"             Ps = 0  ⇒  blinking block.
"             Ps = 1  ⇒  blinking block (default).
"             Ps = 2  ⇒  steady block.
"             Ps = 3  ⇒  blinking underline.
"             Ps = 4  ⇒  steady underline.
"             Ps = 5  ⇒  blinking bar, xterm.
"             Ps = 6  ⇒  steady bar, xterm.
" https://stackoverflow.com/a/44473667
" :help terminal-options
" :help termcap-cursor-shape
" t_SI go to insert mode
" t_SR go to replace mode
" t_EI leave insert or replace
set t_SI=[6\ q
set t_SR=[4\ q
set t_EI=[2\ q

" https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
" set termguicolors

"    let g:powerline_pycmd = "py3"
"    let g:powerline_pyeval = "py3eval"
"    let g:Powerline_symbols = 'fancy'
"
"    " Run these commands after all .vimrc commands and after all packages/plugins
"    augroup PostStartup
"        if exists('g:airline_section_a')
"            au VimEnter * set statusline+=%#warningmsg#
"            if exists(':SyntasticStatuslineFlag')
"                au VimEnter * set statusline+=%{SyntasticStatuslineFlag()}
"            else
"                " echo "Syntastic seems to be uninstalled"
"            endif
"            au VimEnter * set statusline+=%*
"
"            if exists(':SyntasticStatuslineFlag')
"                au VimEnter * let g:syntastic_always_populate_loc_list = 1
"                au VimEnter * let g:syntastic_auto_loc_list = 1
"                au VimEnter * let g:syntastic_check_on_open = 1
"                au VimEnter * let g:syntastic_check_on_wq = 0
"                au VimEnter * let g:airline_powerline_fonts = 1
"                au VimEnter * let g:airline_theme='raven'
"            endif
"        else
"            set statusline=
"            set statusline+=%#PmenuSel#
"            if exists(':StatuslineGit')
"                set statusline+=%{StatuslineGit()}
"            endif
"            set statusline+=%#LineNr#
"            set statusline+=\ %f
"            set statusline+=%m\
"            set statusline+=%=
"            set statusline+=%#CursorColumn#
"            set statusline+=\ %y
"            set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
"            set statusline+=\[%{&fileformat}\]
"            set statusline+=\ %p%%
"            set statusline+=\ %l:%c
"            set statusline+=\
"        endif
"
"
"        " https://github.com/andviro/flake8-vim
"
"        " Auto-check file for errors on write:
"        au VimEnter * let g:PyFlakeOnWrite = 1
"
"        " List of checkers used:
"        au VimEnter * let g:PyFlakeCheckers = 'pep8,mccabe,frosted'
"        " Default maximum complexity for mccabe:
"
"        au VimEnter * let g:PyFlakeDefaultComplexity=10
"        " List of disabled pep8 warnings and errors:
"
"        au VimEnter * let g:PyFlakeDisabledMessages = 'E501'
"
"        " Default aggressiveness for autopep8:
"        au VimEnter * let g:PyFlakeAggressive = 0
"
"        " Default height of quickfix window:
"        au VimEnter * let g:PyFlakeCWindow = 6
"
"        " Whether to place signs or not:
"        au VimEnter * let g:PyFlakeSigns = 1
"
"        " When usign signs, this is the first id that will be used to identify the
"        " signs. Tweak this if you are using other plugins that also use the sign
"        " gutter
"        au VimEnter * let g:PyFlakeSignStart = 1
"
"        " Maximum line length for PyFlakeAuto command
"        au VimEnter * let g:PyFlakeMaxLineLength = 100
"
"        " Visual-mode key command for PyFlakeAuto
"        au VimEnter * let g:PyFlakeRangeCommand = 'Q'
"
"        " au VimEnter * helptags ALL
"    augroup END

" I want to see the name of linter which is giving me an error message
let g:ale_echo_msg_format = '%linter% says %s'

colorscheme NedsLightTheme

" When updating packages, sometimes packages help tags are not regenerated
" Fix that with :1000verbose :helptags ALL
