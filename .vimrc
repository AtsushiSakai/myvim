"
"FileName: .vimrc
"
"Discription:vim設定ファイル 
"
"Author: Atsushi Sakai
"

"--------------------------------------------------------------------------
" Neobundle.vimによるplugin管理
"------------------------------------------------------------------
"おまじない
set nocompatible               " Be iMproved
filetype off                   " Required!

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

filetype plugin indent on     " Required!

" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
            \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif

"====インストールするプラグイン=====

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'https://github.com/vim-scripts/SingleCompile'
NeoBundle 'cohama/vim-hier'

"======neocomplcacheの設定
" 補完ウィンドウの設定
set completeopt=menuone
" 起動時に有効化
let g:neocomplcache_enable_at_startup = 1
" 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1
""tabで補完候補の選択を行う
inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"

"========================


"インクリメンタルサーチ
set incsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan

"ペースト時に階段上にしない。
set pastetoggle=

"シンタックスオン
syntax on

"検索時に大文字を含んでいたら大/小を区別
set ignorecase smartcase

".svn,.gitはgrepしない 内部greoのみ
set grepprg=grep\ -rnIH\ --exclude-dir=.svn\ --exclude-dir=.git

" vimgrep時に自動で別のタブでQuickFixを開く設定
au QuickfixCmdPost vimgrep | tabnew | cw

" grepとタイプするだけでvimgrepを使う設定
command! -complete=file -nargs=+ G call s:grep([<f-args>])
function! s:grep(args)
    let target = len(a:args) > 1 ? join(a:args[1:]) : '*'
    execute 'vimgrep' '/' . a:args[0] . '/j ' . target
    if len(getqflist()) != 0 | copen | endif
endfunction

" grでカーソル下のキーワードをvimgrep
nnoremap <expr> gr ':vimgrep /\<' . expand('<cword>') . '\>/j **/*.' . expand('%:e')


" 閉じ括弧を表示した時に，対応する括弧を表示する
set showmatch
set matchtime=2 "表示時間の設定

"バックアップファイル系
set backup
set backupdir=~/.vim/backup/
set directory=~/.vim/backup/
set noswapfile

"プログラムの行数を表示
set number

"自動インデント
set autoindent
set cindent

" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu

" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM

" タイトルを表示
set title
set tabstop=2
set shiftwidth=2
set expandtab

"gf用
"gfでROSのヘッダファイルに移動できるようにした。
let $V_ROS_ROOT="/opt/ros/fuerte/include"
let $V_ROS_TOOLS="~/fuerte_workspace/Tools/"
set path+=$V_ROS_ROOT+$V_ROS_TOOLS

"<F2> コメントヘッダを挿入
nmap <F2> <ESC>i<C-R>\/*<CR><CR>@file: <C-R>=expand("%")<CR><CR><CR>@brief: <CR><CR>@author: Atsushi Sakai <CR>*/<ESC>

"<F3> TODOを検索
noremap <F3> <ESC>:vimgrep /TODO/ **/*.cpp **/*.h **/*.py<CR>:cw<CR>

"<F4> 関数ヘッダを挿入
nmap <F4> <ESC>i<C-R>\/**<CR>* @brief: <CR>*/<ESC>

"<F6>  タイムスタンプを挿入
nmap <F6> <ESC>i<C-R>=strftime("%Y/%m/%d")<CR>

"クリップボード共有
if has("clipboard") 
  vmap ,y "+y 
  nmap ,p "+gP 
  " exclude:{pattern} must be last ^= prepend += append 
  if has("gui_running") || has("xterm_clipboard") 
    silent! set clipboard^=unnamedplus 
    set clipboard^=unnamed 
  endif 
endif 

" 挿入モード終了時に IME 状態を保存しない
inoremap <silent> <Esc> <Esc>
inoremap <silent> <C-[> <Esc>

"vimrcをスペースドットで開く
nnoremap <space>. :<C-u>tabedit $MYVIMRC<CR>

"ウインドウサイズ調整用
nnoremap <space>, <C-w>10<>><CR> 

"文字コードを自動判別
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8

"colorscheme darkblue
" launchファイルのカラースキームをxmlと一緒にする。
autocmd BufNewFile,BufRead *.launch set filetype=xml

" md as markdown, instead of modula2
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=xml


"==========タブ関係===========
"Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

  " Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap t [Tag]
" Tab jump
for n in range(1, 9)
    execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew ./<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ



"========複数行コメント用=======
" Comment or uncomment lines from mark a to mark b.
function! CommentMark(docomment, a, b)
if !exists('b:comment')
let b:comment = CommentStr() . ' '
endif
if a:docomment
exe "normal! '" . a:a . "_\<C-V>'" . a:b . 'I' . b:comment
else
exe "'".a:a.",'".a:b . 's/^\(\s*\)' . escape(b:comment,'/') . '/\1/e'
endif
endfunction

" Comment lines in marks set by g@ operator.
function! DoCommentOp(type)
call CommentMark(1, '[', ']')
endfunction

" Uncomment lines in marks set by g@ operator.
function! UnCommentOp(type)
call CommentMark(0, '[', ']')
endfunction

" Return string used to comment line for current filetype.
function! CommentStr()
if &ft == 'cpp' || &ft == 'java' || &ft == 'javascript' || &ft == 'c' || &ft == 'h'
return '//'
elseif &ft == 'vim'
return '"'
elseif &ft == 'python' || &ft == 'perl' || &ft == 'sh' || &ft == 'R' || &ft == 'ruby'
return '#'
elseif &ft == 'lisp'
return ';'
endif
return ''
endfunction

nnoremap <Leader>c <Esc>:set opfunc=DoCommentOp<CR>g@
nnoremap <Leader>C <Esc>:set opfunc=UnCommentOp<CR>g@
vnoremap <Leader>c <Esc>:call CommentMark(1,'<','>')<CR>
vnoremap <Leader>C <Esc>:call CommentMark(0,'<','>')<CR>
