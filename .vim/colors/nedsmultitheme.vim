" vim: tw=0 ts=4 sw=4
"
" I got the idea to do this from http://stackoverflow.com/a/2211738/1698426
"
" See NedsDarkTheme.vim for TODO items
" i.e. rely on &background == 'light' rather than using a function

" highlight clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "nedsmultitheme"

let b:White       = "#ffffff"
let b:Grey        = "#b0b0b0"
let b:BrightGrey  = "#dddddd"
let b:DimGrey     = "#404040"
let b:DimmerGrey  = "#202020"

let b:Black       = "#000000"
let b:BrightBlack = "#404040"
let b:DimBlack    = "#202020"

let b:Green       = "#00b000"
let b:BrightGreen = "#00ff00"
let b:DimGreen    = "#004000"

let b:Blue        = "#000080"
let b:BrightBlue  = "#0000ff"
let b:DimBlue     = "#c0c0ff"
let b:FadedBlue   = "#4040ff"

let b:NedsVariants = 
    \{
    \   'NedsWhiteOnBlack':
    \   {
    \       "background": "dark",
    \       "FGDim"     : b:DimGrey,
    \       "FG"        : b:Grey,
    \       "FGBright"  : b:BrightGrey,
    \       "BGDim"     : b:DimBlack,
    \       "BG"        : b:Black,
    \       "BGBright"  : b:BrightBlack
    \   },
    \   'NedsBlackOnWhiteDebug':
    \   {
    \       "background": "light",
    \       "FGDim"     : b:Black,
    \       "FG"        : b:Black,
    \       "FGBright"  : b:Black,
    \       "BGDim"     : b:White,
    \       "BG"        : b:White,
    \       "BGBright"  : b:White
    \   },
    \   'NedsBlackOnWhite':
    \   {
    \       "background": "light",
    \       "FGDim"     : b:DimGrey,
    \       "FG"        : b:Grey,
    \       "FGBright"  : b:BrightGrey,
    \       "BGDim"     : b:DimmerGrey,
    \       "BG"        : b:White,
    \       "BGBright"  : b:DimGrey
    \   },
    \   'NedsGreenOnBlack':
    \   {
    \       "background": "dark",
    \       "FGDim"     : b:DimGreen,
    \       "FG"        : b:Green,
    \       "FGBright"  : b:BrightGreen,
    \       "BGDim"     : b:DimBlack,
    \       "BG"        : b:Black,
    \       "BGBright"  : b:BrightBlack
    \   },
    \   'NedsBlueOnWhite':
    \   {
    \       "background": "light",
    \       "FGDim"     : b:DimBlue,
    \       "FG"        : b:Blue,
    \       "FGBright"  : b:BrightBlue,
    \       "BGDim"     : b:DimBlue,
    \       "BG"        : b:White,
    \       "BGBright"  : b:DimBlue
    \   },
    \   'NedsWhiteOnBlue':
    \   {
    \       "background": "light",
    \       "FGDim"     : b:FadedBlue,
    \       "FG"        : b:Grey,
    \       "FGBright"  : b:White,
    \       "BGDim"     : b:FadedBlue,
    \       "BG"        : b:Blue,
    \       "BGBright"  : b:BrightBlue
    \   },
    \}

if !exists("g:NedsCurrentVariant")
    let g:NedsCurrentVariant = keys(b:NedsVariants)[0]
endif

function! NedsSchemeUpdate()
    let b:FG         = b:NedsVariants[g:NedsCurrentVariant]['FG']
    let b:BG         = b:NedsVariants[g:NedsCurrentVariant]['BG']
    let b:FGDim      = b:NedsVariants[g:NedsCurrentVariant]['FGDim']
    let b:BGDim      = b:NedsVariants[g:NedsCurrentVariant]['BGDim']
    let b:FGBright   = b:NedsVariants[g:NedsCurrentVariant]['FGBright']
    let b:BGBright   = b:NedsVariants[g:NedsCurrentVariant]['BGBright']
    let b:background = b:NedsVariants[g:NedsCurrentVariant]['background']
    let b:NedColourScheme =
        \{
        \   'Normal':
        \   {
        \       'fg': b:FG,
        \       'bg': b:BG,
        \       'keywords':
        \       [
        \           "Normal",
        \           "Constant",
        \           "String",
        \           "Character",
        Boolean",
        \           "Float",
        \           "Number",
        \           "Special",
        \           "Identifier",
        \           "Keyword",
        \           "Statement",
        \           "Conditional",
        \           "Label",
        \           "Include",
        \           "Define",
        \           "PreCondit",
        \           "Macro",
        \           "PreProc",
        \           "StorageClass",
        \           "Structure",
        \           "Typedef",
        \           "Type",
        \           "Function",
        \           "Repeat",
        \           "Operator",
        \           "Ignore",
        \           "Tag",
        \           "SpecialChar",
        \           "SpecialComment",
        \           "Scrollbar",
        \           "SpecialKey",
        \           "Directory",
        \           "Underlined",
        \           "Exception",
        \       ]
        \   },
        \   'NormalSlightEmphasis':
        \   {
        \       'fg': b:FGBright,
        \       'bg': b:BG,
        \       'keywords':
        \       [
        \           "Menu",
        \           "Comment",
        \           "Pmenu",
        \           "SpellCap",
        \           "SpellLocal",
        \           "SpellRare",
        \           "MatchParen",
        \           "Delimiter",
        \           "Question",
        \           "asciidocOneLineTitle",
        \       ]
        \   },
        \   'Cursor':
        \   {
        \       'fg': b:FG,
        \       'bg': b:BGDim,
        \       'keywords':
        \       [
        \           "Cursor",
        \           "CursorLine",
        \           "CursorColumn",
        \       ]
        \   },
        \   'Scary':
        \   {
        \       'fg': 'white',
        \       'bg': 'red',
        \       'keywords':
        \       [
        \           "Error",
        \           "ErrorMsg",
        \           "Debug",
        \           "SpellBad",
        \           "SpellCap",
        \           "SpellLocal",
        \           "SpellRare",
        \           "StatusLine",
        \           "myFixme",
        \       ]
        \   },
        \   'Highlight':
        \   {
        \       'fg': b:FG,
        \       'bg': b:BGBright,
        \       'keywords':
        \       [
        \           "ModeMsg",
        \           "WarningMsg",
        \           "Search",
        \           "Visual",
        \           "Todo",
        \       ]
        \   },
        \   'De-emphasize':
        \   {
        \       'fg': b:FGDim,
        \       'bg': b:BG,
        \       'keywords':
        \       [
        \           "LineNr",
        \           "CursorLineNr",
        \           "Folded",
        \           "FoldedColumn",
        \       ]
        \   },
        \   'Emphasize':
        \   {
        \       'fg': b:BG,
        \       'bg': b:FGBright,
        \       'keywords':
        \       [
        \           "PmenuSel",
        \       ]
        \   },
        \   'Widget':
        \   {
        \       'fg': b:FGDim,
        \       'bg': b:BGDim,
        \       'keywords':
        \       [
        \           "MoreMsg",
        \           "StatusLineNC",
        \           "Title",
        \           "TabLine",
        \           "TabLineFill",
        \       ]
        \   },
        \   'WidgetSel':
        \   {
        \       'fg': b:FGBright,
        \       'bg': b:BG,
        \       'keywords':
        \       [
        \           "TabLineSel",
        \       ]
        \   }
        \}

    for group in keys(b:NedColourScheme)
        for kw in b:NedColourScheme[group]['keywords']
            " exe 'highlight clear ' . kw
            let b:fg = b:NedColourScheme[group]['fg']
            let b:bg = b:NedColourScheme[group]['bg']
            " let cmd = 'hi ' . kw . ' ctermfg=' . b:fg . ' ctermbg=' . b:bg " this is commented out because I don't know how to ctermfg=#rrggbb
            " exe cmd
            let cmd = 'highlight ' . kw . ' guifg=' . b:fg . ' guibg=' . b:bg
            exe cmd
        endfor
    endfor
    " This is a bug, see the help for background
    " tl;dr setting background reloads the color scheme, it doesn't do what you think it does
    exe "set background=" . b:background
endfunction

" call NedsSchemeUpdate()  " is this what causes the E127 function is in use?

" Does this have to be on the bottom?
" http://stackoverflow.com/a/4097541/1698426
syn match   myTodo   contained   "\<\(TODO\|FIXME\):"
hi def link myTodo Todo
" for FIXME and FIXME:
syn match   myFixme   contained   "\<\(FIXME\):"
" hi def link myTodo Todo


" https://www.reddit.com/r/vim/comments/4nxeyq/where_to_find_a_list_of_all_the_syntax_groups_in/d47rqtg?utm_source=share&utm_medium=web2x
" Output the current syntax group
nnoremap <f10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>

function! NedColorSchemeCycler()
    let l:all_schemes = keys(b:NedsVariants)
    let l:current_scheme_index = index(keys(b:NedsVariants), g:NedsCurrentVariant)
    if l:current_scheme_index < 0
        let l:current_scheme_index = 0
    else
        let l:current_scheme_index = l:current_scheme_index + 1
        if l:current_scheme_index >= len(l:all_schemes)
            let l:current_scheme_index = 0
        endif
    endif
    let l:current_scheme = l:all_schemes[l:current_scheme_index]
    let g:NedsCurrentVariant = l:current_scheme
    " see earlier note about setting background
    let b:background = b:NedsVariants[g:NedsCurrentVariant]["background"]
    call NedsSchemeUpdate()
    echo string(l:current_scheme_index) . ": " . l:current_scheme . ', ' . string(l:all_schemes)
endfunction
command! NedColorSchemeCycler call NedColorSchemeCycler()
nnoremap <silent> <S-F11> :NedColorSchemeCycler<CR>

" https://vi.stackexchange.com/a/15399/532
function! ColorSchemeCycler()
    let l:all_schemes = getcompletion('', 'color')
    let l:current_scheme = get(g:, 'colors_name', 'default')
    let l:current_index = index(l:all_schemes, l:current_scheme)
    if l:current_index < 0
        let l:current_index = 0
    else
        let l:current_index = l:current_index +1
        if l:current_index >= len(l:all_schemes)
            let l:current_index = 0
        endif
    endif
    exe 'colorscheme ' . l:all_schemes[l:current_index]
    echo 'Colorscheme set to ' . l:all_schemes[l:current_index] . " " . string(l:all_schemes)
endfunction
command! ColorSchemeCycler call ColorSchemeCycler()
nnoremap <silent> <S-F10> :ColorSchemeCycler<CR>

" hitest.vim shows all the groups currently active
"    :so $VIMRUNTIME/syntax/hitest.vim
function! SyntaxItem()
      return synIDattr(synID(line("."),col("."),1),"name")
endfunction
