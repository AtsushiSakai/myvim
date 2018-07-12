"
" vim config file
"
"Author: Atsushi Sakai
"

source $VIMRUNTIME/defaults.vim

"encoding
set encoding=utf-8
scriptencoding utf-8 
set fileencoding=utf-8 "書き込み時のFile Encoding
set fileencodings=utf-8

"myvim pathの設定
let g:myvimpath = $HOME . '/myvim/'
let g:win_myvimpath = "~\myvim"

"autocmd用 autocmdのすべてにautocmd vimrcとすること
augroup vimrc
  autocmd!
augroup END

"--------------------------------------------------------------------------
" Neobundle.vimによるplugin管理
"------------------------------------------------------------------
"Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
"====インストールするプラグイン=====
"追加したらNeoBundleInstallすること
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'ompugao/ros.vim'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'yegappan/mru'
NeoBundle 'AtsushiSakai/bookmarklet.vim'
NeoBundle 'AtsushiSakai/vim-ros'
NeoBundle 'tpope/vim-surround'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'vim-scripts/grep.vim'
NeoBundle "ctrlpvim/ctrlp.vim"
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neoinclude.vim'
NeoBundle 'ConradIrwin/vim-bracketed-paste'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-rhubarb'
NeoBundle 'simeji/winresizer'
NeoBundle 'Shougo/vimshell.vim'

"C++"
NeoBundleLazy 'vim-scripts/DoxygenToolkit.vim',{
  \"autoload" : {"filetypes" :[ "cpp", "c" ]}
\}
NeoBundleLazy 'AtsushiSakai/comfortablecpp.vim',{
  \"autoload" : {"filetypes" :[ "cpp", "c" ]}
\}
NeoBundleLazy 'justmao945/vim-clang',{
  \"autoload" : {"filetypes" :[ "cpp" ]}
\}


"html"
NeoBundleLazy 'mattn/emmet-vim',{
  \"autoload" : {"filetypes" :[ "html" ]}
\}


if has("python")
"Python"
NeoBundleLazy 'davidhalter/jedi-vim',{
  \"autoload" : {"filetypes" :[ "python" ]}
\}
 
NeoBundleLazy 'andviro/flake8-vim',{
  \"autoload" : {"filetypes" :[ "python" ]}
\}
endif 

"Markdown"
NeoBundleLazy 'kannokanno/previm',{
  \"autoload" : {"filetypes" :[ "markdown" ]}
\}

"Julia"
NeoBundle 'JuliaEditorSupport/julia-vim' "cannot work Neobundlelazy..

NeoBundleLazy 'AtsushiSakai/julia.vim',{
  \"autoload" : {"filetypes" :[ "julia" ]}
\}


call neobundle#end()

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

"=====vim-heirの設定=====
execute 'highlight ucurl_my gui=undercurl guisp=Red'
let g:hier_highlight_group_qf = 'ucurl_my'

"=====vim-easy-alignの設定=====
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)

"CtrlPの設定
let g:ctrlp_cmd = 'CtrlPMixed'

"w!!でsudoで保存"
cabbr w!! w !sudo tee > /dev/null %

"======neocomplcacheの設定
" 補完ウィンドウの設定
set completeopt=menuone
" 起動時に有効化
let g:neocomplcache_enable_at_startup = 1
" 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1
"tabで補完候補の選択を行う
inoremap <expr><tab> pumvisible() ? "\<Down>" : "\<TAB>"
inoremap <expr><s-tab> pumvisible() ? "\<Up>" : "\<S-TAB>"

"=====neosnippet=====
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

"<F5> でコード実行
function! Exe()
  echo "Exe"
  let filename = expand('%:t')
  if stridx(filename, ".py") != -1 
    !python %
  elseif stridx(filename, ".jl") != -1
    !julia %
  elseif stridx(filename, ".cpp") != -1 
    !./build_run.sh
  else
    echo "unknown filetype"+filename
  endif
endfunction
command! Exe :call Exe()

nmap <F5> :Exe



" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let g:neosnippet#snippets_directory='~/.vim/bundle/neosnippet-snippets/snippets/,~/.vim/snippets'


"nerdcommenter用 cc でコメントorコメントアウト
let NERDSpaceDelims = 1
nmap cc <Plug>NERDCommenterToggle
vmap cc <Plug>NERDCommenterToggle

"MRUスペースx2で過去に修正したファイルエクスプローラを起動する(MRU)
nnoremap <space><space> :<c-u>MRU<CR>

" 検索時に検索文字を真ん中に持ってくる
nnoremap n nzzzv
nnoremap N Nzzzv

set nofoldenable    " disable folding

syntax on

"========================

set binary

" 括弧などの自動補完
inoremap { {}<Left>
inoremap [ []<Left>
inoremap ( ()<Left>
inoremap " ""<Left>
inoremap ' ''<Left>

set hlsearch
set ignorecase
set smartcase
set wrapscan

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

"別ファイルで修正された場合に自動読み込み"
set autoread

set ttymouse=xterm2

set hidden              " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く

"検索時に大文字を含んでいたら大/小を区別
set ignorecase smartcase

"======Grep関連関連======"

if executable('jvgrep')
  set grepprg=jvgrep
endif

let Grep_Skip_Dirs = '.svn .git'  "無視するディレクトリ
let Grep_Default_Options = '-I'   "バイナルファイルがgrepしない
let Grep_Skip_Files = '*.bak *~'  "バックアップファイルを無視する

" grでカーソル下のキーワードを再帰grep
nnoremap <expr> gr ':Rgrep<CR>'

" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>

" 閉じ括弧を表示した時に，対応する括弧を表示する
set showmatch
set matchtime=3 "表示時間の設定

"バックアップファイル系
set backup
set backupdir=~/.vim/backup/
set undofile
set undodir=~/.vim/undo/
set noswapfile

"プログラムの行数を表示
set number

"自動インデント
set cindent

" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mm

set title
set tabstop=4
set shiftwidth=4
set expandtab

"クリップボード共有
if has('clipboard') 
  vmap ,y "+y 
  nmap ,p "+gp 
  " exclude:{pattern} must be last ^= prepend += append 
  if has('gui_running') || has('xterm_clipboard') 
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

":Vimrcsourceでvimrcを読み込む"
if !exists('*Vimrcsource')
  function! Vimrcsource()
    source ~/myvim/.vimrc
  endfunction
  command! Vimrcsource :call Vimrcsource()
endif

colorscheme darkblue

" launchファイルのカラースキームをxmlと一緒にする。
autocmd vimrc Bufnewfile,bufread *.launch set filetype=xml

" md as markdown, instead of modula2
autocmd vimrc Bufnewfile,bufread *.{mdwn,mkd,mkdn,mark*} set filetype=xml

autocmd vimrc bufread,BufNewFile *.jl set filetype=julia

" markdown認識用
au BufRead,BufNewFile *.md set filetype=markdown

"ctags関係
set tags=~/tags

"OS毎の設定
if stridx(system('uname'),'Dar')!=-1
    " Mac環境用のコード
    " echo 'This is mac'

    " Mac の辞書.appで開く {{{
    " 引数に渡したワードを検索
    command! -nargs=1 MacDict      call system('open '.shellescape('dict://'.<q-args>))
    " カーソル下のワードを検索
    command! -nargs=0 MacDictCWord call system('open '.shellescape('dict://'.shellescape(expand('<cword>'))))
    " 辞書.app を閉じる
    command! -nargs=0 MacDictClose call system("osascript -e 'tell application \"Dictionary\" to quit'")
    " 辞書にフォーカスを当てる
    command! -nargs=0 MacDictFocus call system("osascript -e 'tell application \"Dictionary\" to activate'")

    " Open finder
    command! Open !Open .


elseif stridx(system('uname'),'Linu')!=-1
    " Linux用のコード
    " echo 'This is unix'

    "日本語入力をノーマルモードでオフにする
    function! ImInActivate()
      call system('fcitx-remote -c')
    endfunction
    inoremap <silent> <C-[> <ESC>:call ImInActivate()<CR>

    " Open finder
    command! Open !Open .



elseif stridx(system('uname'),'MING')!=-1
    " Windows環境用のコード
    " echo 'This is win32'

    "grep.vim用にGitbashのgpreにパスを通す"
    "Program filesのディレクトリ名の間のスペースによって
    "おかしい挙動をしたため、エイリアスを使った"
    let Grep_Path = '/usr/bin/grep.exe' 
    let Grep_Xargs_Path = '/usr/bin/xargs.exe' 
    let Grep_Find_Path = '/usr/bin/find.exe'
    let Grep_Shell_Quote_Char = '"'

    "Unixのファイルの改行コードをそのままにしておく
    autocmd vimrc BufNewFile,BufRead * edit ++ff=dos

    " Open finder
    command! Open !start .


endif

"========ROS=======
"gf用
"gfでROSのヘッダファイルに移動できるようにした。
let $V_ROS_ROOT='/opt/ros/fuerte/include'
let $V_ROS_TOOLS='~/fuerte_workspace/Tools/'
set path+=$V_ROS_ROOT+$V_ROS_TOOLS

"ROSのトピックのリストを表示するコマンドを有効にする
source ~/.vim/script/RosTopicList.vim

"ROSのmsgの構成を表示するコマンドを有効にする
source ~/.vim/script/RosmsgShow.vim

"SVN Commit時にsvn diffの結果を追加する
source ~/.vim/script/svndiffandcommit.vim

"catkin_makeを実施するコマンドを有効化
source ~/.vim/script/RosCatkinMake.vim

"catkin_makeを実施するコマンドを有効化
source ~/.vim/script/DecimalChange.vim

"Translateコマンド
source ~/.vim/script/Translate.vim

"Cppコマンド
source ~/.vim/script/ComfortableCpp.vim

" launchファイルのカラースキームをxmlと一緒にする。
autocmd vimrc BufNewFile,BufRead *.launch set filetype=xml

" srvファイルに色をつける
autocmd vimrc FileType srv colorscheme molokai

"gvimのCdCurrentを設定 "
command! -nargs=0 CdCurrent cd %:p:h

" Statuslineの設定
set laststatus=2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ \[ENC=%{&fileencoding}]%P 

let g:julia_lint_ignores = ["E321"]

