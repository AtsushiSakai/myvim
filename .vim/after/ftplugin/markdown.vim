" vim configuration for markdown
" Author: Atsushi Sakai

"Neobundle"
set nocompatible               " Be iMproved
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim                 
  call neobundle#rc(expand('~/.vim/bundle/'))
endif   

"plugins"
NeoBundle 'kannokanno/previm'
" markdownチートシート"
NeoBundle 'gist:hail2u/747628', {
       \ 'name': 'markdown-cheat-sheet.jax',
       \ 'script_type': 'doc'}

filetype plugin indent on

"ブラウザの設定"
let g:previm_open_cmd = 'open -a Firefox'

" <F5>で編集中のファイルをブラウザで表示
nmap <F5> :PrevimOpen<CR>

" <F6>でMarkdownチートシートを表示
nmap <F6> :h markdown-cheat-sheet-hr@ja<CR>




