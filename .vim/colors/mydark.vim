" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4

hi clear
set background=dark
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "mycolours"

" http://stackoverflow.com/a/2211738/1698426

let b:Green       =   2
let b:BrightGreen =  10
let b:DimGreen    =  22

let b:Grey        =   7
let b:BrightGrey  =  15
let b:DimGrey     = 235

let b:FGDim       = 238
let b:FG          = 250
let b:FGBright    =   7
let b:BGDim       = 235
let b:BG          =   0
let b:BGBright    = 117

let b:FGDim       = b:DimGreen
let b:FG          = b:Green
let b:FGBright    = b:BrightGreen
let b:BGDim       = 235
let b:BG          =   0
let b:BGBright    = 117

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
    \           "Delimiter",
    \           "SpecialComment",
    \           "Scrollbar",
    \           "Menu",
    \           "SpecialKey",
    \           "Directory",
    \           "ErrorMsg",
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
    \           "Comment",
    \       ]
    \   },
    \   'Cursor':
    \   {
    \       'fg': b:FG,
    \       'bg': 234,
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
    \           "Debug",
    \           "Question",
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
    \       'fg': 'black',
    \       'bg': b:FGBright,
    \       'keywords':
    \       [
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
    \       ]
    \   },
    \   'Emphasize':
    \   {
    \       'fg': b:BG,
    \       'bg': b:FGBright,
    \       'keywords':
    \       [
    \           "MatchParen",
    \       ]
    \   },
    \   'Widget':
    \   {
    \       'fg': b:FGDim,
    \       'bg': b:BGDim,
    \       'keywords':
    \       [
    \           "MoreMsg",
    \           "ModeMsg",
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
        let cmd = 'hi ' . kw . ' ctermfg=' . b:fg . ' ctermbg=' . b:bg
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
