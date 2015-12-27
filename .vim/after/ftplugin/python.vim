" vim configuration for python
" Author: Atsushi Sakai

"Neobundle"
set nocompatible               " Be iMproved
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim                 
  call neobundle#rc(expand('~/.vim/bundle/'))
endif   

"plugins"
NeoBundle 'davidhalter/jedi-vim'

filetype plugin indent on

""call neobundle#end()


" <F5>で編集中のファイルを実行
" MATLABと同じショートカット
nmap <F5> :!python %
" windows"
"nmap <F5> :!python %<CR>


