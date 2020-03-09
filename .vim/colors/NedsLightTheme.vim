" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4

hi clear
set background=light
if exists("syntax_on")
  syntax reset
endif
let g:colors_name    = "NedsLightTheme"

" http://stackoverflow.com/a/2211738/1698426

let b:FGDim       = "#555555"
let b:FG          = "#333333"
let b:FGBright    = "#000000"
let b:BGDim       = "#aaaaaa"
let b:BG          = "#f5f5f5"
let b:BGBright    = "#ffff00"

let b:MyDarkScheme =
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
    \           "Boolean",
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

for group in keys(b:MyDarkScheme)
    for kw in b:MyDarkScheme[group]['keywords']
        let b:fg = b:MyDarkScheme[group]['fg']
        let b:bg = b:MyDarkScheme[group]['bg']
        " let cmd = 'hi ' . kw . ' ctermfg=' . b:fg . ' ctermbg=' . b:bg
        let cmd = 'hi ' . kw . ' guifg=' . b:fg . ' guibg=' . b:bg
        " echo cmd
        exe 'hi clear ' . kw
        exe cmd
    endfor
endfor

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

" hitest.vim shows all the groups currently active
"    :so $VIMRUNTIME/syntax/hitest.vim
function! SyntaxItem()
      return synIDattr(synID(line("."),col("."),1),"name")
endfunction
