"
"FileName: .vimrc
"
"Discription: vim configulation
"
"Author: Atsushi Sakai
"
"

"encoding
set encoding=utf-8
scriptencoding utf-8 
"set fileencoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8

"autocmd用 autocmdのすべてにautocmd vimrcとすること
augroup vimrc
  autocmd!
augroup END

"--------------------------------------------------------------------------
" Neobundle.vimによるplugin管理
"------------------------------------------------------------------
"おまじない
set nocompatible               " Be iMproved
filetype off                   " Required!

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

"call neobundle#rc(expand('~/.vim/bundle/'))
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#end()

filetype plugin indent on     " Required!

" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
            \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif

"====インストールするプラグイン=====
"追加したらNeoBundleInstallすること
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'https://github.com/vim-scripts/SingleCompile'
NeoBundle 'cohama/vim-hier'
NeoBundle 'ompugao/ros.vim'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'yegappan/mru'
"NeoBundle 'Townk/vim-autoclose'

"=====vim-heirの設定=====
execute "highlight ucurl_my gui=undercurl guisp=Red"
let g:hier_highlight_group_qf = "ucurl_my"

"=====vim-easy-alignの設定=====
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)

"======neocomplcacheの設定
" 補完ウィンドウの設定
set completeopt=menuone
" 起動時に有効化
let g:neocomplcache_enable_at_startup = 1
" 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1
""tabで補完候補の選択を行う
inoremap <expr><tab> pumvisible() ? "\<Down>" : "\<TAB>"
inoremap <expr><s-tab> pumvisible() ? "\<Up>" : "\<S-TAB>"

"nerdcommenter用 cc でコメントorコメントアウト
let NERDSpaceDelims = 1
nmap cc <Plug>NERDCommenterToggle
vmap cc <Plug>NERDCommenterToggle

"MRU
"スペースx2で過去に修正したファイルエクスプローラを起動する(MRU)
nnoremap <space><space> :<c-u>MRU<CR>



"========================
"インクリメンタルサーチ
set incsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan

"コマンドを右下に表示する
set showcmd

"ペースト時に階段上にしない。
set pastetoggle=

"シンタックスオン
syntax on

" 数字のインクリメントとデクリメントを分かりやすく
nnoremap + <C-a>
nnoremap - <C-x>

"検索時に大文字を含んでいたら大/小を区別
set ignorecase smartcase

".svn,.gitはgrepしない 内部grepのみ
set grepprg=grep\ -rnih\ --exclude-dir=.svn\ --exclude-dir=.git

" vimgrep時に自動で別のタブでquickFixを開く設定
au Quickfixcmdpost vimgrep | tabnew | cw

" grepとタイプするだけでvimgrepを使う設定
command! -complete=file -nargs=+ G call s:grep([<f-args>])
function! s:grep(args)
    let target = len(a:args) > 1 ? join(a:args[1:]) : '*'
    execute 'vimgrep' '/' . a:args[0] . '/j ' . target
    if len(getqflist()) != 0 | copen | endif
endfunction

" grでカーソル下のキーワードをvimgrep
nnoremap <expr> gr ':vimgrep /\<' . expand('<cword>') . '\>/j /home/komatsu/fuerte_workspace/**/*.' . expand('%:e')


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

"ルーラを表示する
set ruler

" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mm

"Macでバックスペースを使えるようにする
set backspace=indent,eol,start

" タイトルを表示
set title
set tabstop=2
set shiftwidth=2
set expandtab

"<F2> コメントヘッダを挿入
nmap <F2> <esc>i<c-r>\/*<cr><cr>@file: <C-R>=expand("%")<CR><CR><CR>@brief: <CR><CR>@author: Atsushi Sakai <CR>*/<ESC>

"<F3> TODOを検索
noremap <F3> <esc>:vimgrep /todo/ **/*.cpp **/*.h **/*.py<CR>:cw<CR>

"<F4> 関数ヘッダを挿入
nmap <F4> <esc>i<c-r>\/**<cr> @brief <CR>/<ESC>

"<F5> クラステンプレート
nmap <F5> <esc>i<c-r>\/**<cr> @brief <CR>*/<CR>class hoge{<CR>public:<CR>private:<CR>};<ESC>

"<F6>  タイムスタンプを挿入
nmap <F6> <esc>i<c-r>=strftime("%Y/%m/%d")<CR>

"クリップボード共有
if has("clipboard") 
  vmap ,y "+y 
  nmap ,p "+gp 
  " exclude:{pattern} must be last ^= prepend += append 
  if has("gui_running") || has("xterm_clipboard") 
    silent! set clipboard^=unnamedplus 
    set clipboard^=unnamed 
  endif 
endif 

set clipboard+=unnamed
set clipboard+=autoselect

" 挿入モード終了時に ime 状態を保存しない
inoremap <silent> <esc> <esc>
inoremap <silent> <c-[> <esc>

"vimrcをスペースドットで開く
nnoremap <space>. :<c-u>tabedit $MYVIMRC<CR>

"ウインドウサイズ調整用
nnoremap <space>, <c-w>10<>><cr> 

"colorscheme darkblue
" launchファイルのカラースキームをxmlと一緒にする。
autocmd vimrc Bufnewfile,bufread *.launch set filetype=xml

" md as markdown, instead of modula2
autocmd vimrc Bufnewfile,bufread *.{md,mdwn,mkd,mkdn,mark*} set filetype=xml

" ファイルを保存したらエンコードをutf-8に自動変換する
autocmd vimrc BufWrite *.{h,cpp,msg} set fenc=utf-8

"ctags関係
set tags=~/tags

"yankring用
helptags ~/myvim/.vim/doc

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

"========ROS=======
"gf用
"gfでROSのヘッダファイルに移動できるようにした。
let $V_ROS_ROOT="/opt/ros/fuerte/include"
let $V_ROS_TOOLS="~/fuerte_workspace/Tools/"
set path+=$V_ROS_ROOT+$V_ROS_TOOLS

"ROSのトピックのリストを表示するコマンドを有効にする
source ~/.vim/script/RosTopicList.vim

"ROSのmsgの構成を表示するコマンドを有効にする
source ~/.vim/script/RosmsgShow.vim

"SVN Commit時にsvn diffの結果を追加する
source ~/.vim/script/svndiffandcommit.vim

" launchファイルのカラースキームをxmlと一緒にする。
autocmd vimrc BufNewFile,BufRead *.launch set filetype=xml

" srvファイルに色をつける
autocmd vimrc FileType srv colorscheme molokai

