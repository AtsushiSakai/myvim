" vim configuration for python
" Author: Atsushi Sakai

" <F5>で編集中のファイルを実行
" MATLABと同じショートカット
nmap <F5> :!python %
" windows"
"nmap <F5> :!python %<CR>
"

" flask8-vim"
let g:PyFlakeDisabledMessages = 'E402' " import order error

" autopep 
" original http://stackoverflow.com/questions/12374200/using-uncrustify-with-vim/15513829#15513829
function! Preserve(command)
    " Save the last search.
    let search = @/
    " Save the current cursor position.
    let cursor_position = getpos('.')
    " Save the current window position.
    normal! H
    let window_position = getpos('.')
    call setpos('.', cursor_position)
    " Execute the command.
    execute a:command
    " Restore the last search.
    let @/ = search
    " Restore the previous window position.
    call setpos('.', window_position)
    normal! zt
    " Restore the previous cursor position.
    call setpos('.', cursor_position)
endfunction

function! Autopep8()
    "--ignote=E501: 一行の長さの補正を無視"
    " call Preserve(':silent %!autopep8 --ignore errors=E501 -')
    call Preserve(':silent %!autopep8 --ignore errors=E501 --aggressive --aggressive -')
endfunction
    call Preserve(':silent %!autopep8 --ignore errors=E501 -')

" Shift + F でautopep自動修正
nnoremap <S-f> :call Autopep8()<CR>

autocmd BufWrite *.{py} :call Autopep8()

