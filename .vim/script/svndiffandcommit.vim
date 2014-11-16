"
" @brief vim script to insert svn diff output 
"        when svn commit
"
" @author Atsushi Sakai
"
" @copyright (c): 2014 Atsushi Sakai
"
" @license : GPL Software License Agreement

"svn-commit*.tmpという名前のファイルの時のみ実行
if expand("%")=~"svn-commit*.tmp"
  "svn diffの結果をコミットファイルに追加
  r! svn diff
  "diff用のシンタックスに変換
  set syntax=diff
  "カーソルを一番上に移動
  normal gg 
endif

