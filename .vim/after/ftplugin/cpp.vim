" vim configuration for cpp
" Author: Atsushi Sakai
" echo "cpp"

" setting auto clang formatting at file saving"
function! s:clang_format()
  let now_line = line(".")
  " exec ":%! clang-format"
  " exec ":" . now_line
endfunction

if executable('clang-format')
  augroup cpp_clang_format
    autocmd!
    autocmd BufWrite,FileWritePre,FileAppendPre *.h call s:clang_format()
    autocmd BufWrite,FileWritePre,FileAppendPre *.cpp call s:clang_format()
  augroup END
endif

" set clang options for vim-clang
" let g:neocomplete#enable_at_startup = 1
" if !exists('g:neocomplete#force_omni_input_patterns')
        " let g:neocomplete#force_omni_input_patterns = {}
" endif
" let g:neocomplete#force_overwrite_completefunc = 1
" let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
" let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" " disable auto completion for vim-clanG
" let g:clang_auto = 0
" let g:clang_complete_auto = 0
" let g:clang_auto_select = 0
" let g:clang_use_library = 1

" " default 'longest' can not work with neocomplete
" let g:clang_c_completeopt   = 'menuone'
" let g:clang_cpp_completeopt = 'menuone'

" if executable('clang-3.6')
    " let g:clang_exec = 'clang-3.6'
" elseif executable('clang-3.5')
    " let g:clang_exec = 'clang-3.5'
" elseif executable('clang-3.4')
    " let g:clang_exec = 'clang-3.4'
" else
    " let g:clang_exec = 'clang'
" endif

" if executable('clang-format-3.6')
    " let g:clang_format_exec = 'clang-format-3.6'
" elseif executable('clang-format-3.5')
    " let g:clang_format_exec = 'clang-format-3.5'
" elseif executable('clang-format-3.4')
    " let g:clang_format_exec = 'clang-format-3.4'
" else
    " let g:clang_exec = 'clang-format'
" endif

" let g:clang_c_options = '-std=c11'
" let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'
