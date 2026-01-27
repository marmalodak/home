" groovy-lint.vim - Groovy linting with groovyc
" Maintainer: John
" Version: 1.0
" written by claude

if exists('g:loaded_groovy_lint')
    finish
endif
let g:loaded_groovy_lint = 1

function! RunGroovyc()
    if &filetype != 'groovy'
        return
    endif

    " Save current file first if modified
    if &modified
        write
    endif

    " Get the current file path
    let l:file = expand('%:p')

    " Run groovyc and capture output
    let l:output = system('groovyc -e ' . shellescape(l:file) . ' 2>&1')

    " Clear previous errors
    call setqflist([])

    if v:shell_error == 0
        " No errors
        echo "groovyc: No errors found"
    else
        " Parse errors and populate quickfix list
        let l:errors = []
        for l:line in split(l:output, '\n')
            " Match error pattern: filename: linenumber: message
            " Example: withHttpProxy.groovy: 14: The current scope already contains...
            let l:match = matchlist(l:line, '^\(.\{-}\): \(\d\+\): \(.\+\)$')
            if !empty(l:match)
                call add(l:errors, {
                    \ 'filename': l:match[1],
                    \ 'lnum': str2nr(l:match[2]),
                    \ 'text': trim(l:match[3]),
                    \ 'type': 'E'
                    \ })
            endif

            " Also match the line pattern: " @ line X, column Y."
            let l:match2 = matchlist(l:line, '^ @ line \(\d\+\), column \(\d\+\)\.')
            if !empty(l:match2) && !empty(l:errors)
                let l:errors[-1].lnum = str2nr(l:match2[1])
                let l:errors[-1].col = str2nr(l:match2[2])
            endif
        endfor

        if !empty(l:errors)
            call setqflist(l:errors)
            echo "groovyc: " . len(l:errors) . " error(s) found. Use :copen to see them."
            " Uncomment next line to auto-open quickfix window
            " copen
        else
            echo "groovyc failed but no parseable errors found. Run :!groovyc -e % to see output"
        endif
    endif
endfunction

" Auto-run on file open and save for .groovy files
augroup GroovyLint
    autocmd!
    autocmd BufRead,BufWritePost *.groovy call RunGroovyc()
augroup END

" Manual command
command! GroovyLint call RunGroovyc()

" Optional: Keybinding to manually run linter
nnoremap <leader>gl :GroovyLint<CR>
