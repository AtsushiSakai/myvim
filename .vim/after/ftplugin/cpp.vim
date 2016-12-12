" vim configuration for cpp
" Author: Atsushi Sakai
" echo "cpp"

function! s:clang_format()
  let now_line = line(".")
  exec ":%! clang-format"
  exec ":" . now_line
endfunction

if executable('clang-format')
  augroup cpp_clang_format
    autocmd!
    autocmd BufWrite,FileWritePre,FileAppendPre *.h call s:clang_format()
    autocmd BufWrite,FileWritePre,FileAppendPre *.cpp call s:clang_format()
  augroup END
endif
