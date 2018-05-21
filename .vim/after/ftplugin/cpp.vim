" vim configuration for cpp
" Author: Atsushi Sakai
" echo "cpp"

function! CPPCodeCleanup()
  " echo "Cleanup cpp code"
  let l:lines="all"
  let g:clang_format_fallback_style = 'Google'
  " :pyf /usr/local/share/clang/clang-format.py
  " Mac
  :pyf /usr/local/Cellar/clang-format/2018-01-11/share/clang/clang-format.py
endfunction
command! CPPCodeCleanup call CPPCodeCleanup()

" autocmd BufWrite *.{cpp} :CPPCodeCleanup
" autocmd BufWrite *.{hpp} :CPPCodeCleanup
" autocmd BufWrite *.{c} :CPPCodeCleanup
" autocmd BufWrite *.{h} :CPPCodeCleanup

"" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END



