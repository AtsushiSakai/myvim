" vim configuration for cpp
" Author: Atsushi Sakai
" echo "cpp"

" setting auto clang formatting at file saving"
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

" set clang options for vim-clang
let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'
