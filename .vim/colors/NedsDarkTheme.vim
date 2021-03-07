" I got the idea to do this from http://stackoverflow.com/a/2211738/1698426
"
" TODO
" This needs to be parameterized so that I can have blue and other variations
" Also, this needs to be parameterized so that the light and dark themes are
" just parameters
"
" Would it be a good idea to make this a top level project on its own?

hi clear
if exists("syntax_on")
    syntax reset
endif

" this might be a bug, it seems that vim sets the background variable itself depending on the terminal background
" bookmarks:
" http://peterodding.com/code/vim/colorscheme-switcher/#known_problems
" https://vimhelp.org/options.txt.html#%27background%27
" https://vi.stackexchange.com/questions/12104/what-does-set-background-dark-do
" NB Setting background causes the color scheme to be reloaded
let g:colors_name = "NedsDarkTheme"

" I found this helpful for finding colour names:
" https://vim.fandom.com/wiki/Xterm256_color_names_for_console_Vim
" Might also consider https://github.com/guns/xterm-color-table.vim

let b:FGDim    = {'gui': "#555555", 'cterm': "Grey"      }
let b:FG       = {'gui': "#aaaaaa", 'cterm': "250"       }
let b:FGBright = {'gui': "#ffffff", 'cterm': "White"     }
let b:BGDim    = {'gui': "#555555", 'cterm': "236"       }
let b:BG       = {'gui': "#111111", 'cterm': "234"       }
let b:BGBright = {'gui': "#ffff00", 'cterm': "226"       }
let b:FGScary  = {'gui': "#ffffff", 'cterm': "White"     }
let b:BGScary  = {'gui': "#ff0000", 'cterm': "196"       }

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
    \           "Terminal",
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
    \       'fg': b:FGScary,
    \       'bg': b:BGScary,
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
        let b:fg = b:NedColourScheme[group]['fg']
        let b:bg = b:NedColourScheme[group]['bg']
        let cmd = 'hi ' . kw . ' guifg=' . b:fg['gui'] . ' guibg=' . b:bg['gui']
        let cmd = cmd . ' ctermfg=' . b:fg['cterm'] . ' ctermbg=' .  b:bg['cterm']
        " $VIMRUNTIME/colors/tools/check_colors.vim seems to recommend not running hi clear
        " - but this leaves an underline on the cursorline
        exe 'hi clear ' . kw
        exe cmd
    endfor
endfor

" The rest of this file might be better in my .vimrc
" http://stackoverflow.com/a/4097541/1698426
syn match   myTodo   contained   "\<\(TODO\|FIXME\):"
hi def link myTodo Todo
" for FIXME and FIXME:
syn match   myFixme   contained   "\<\(FIXME\):"


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

" vim: tw=0 ts=4 sw=4
