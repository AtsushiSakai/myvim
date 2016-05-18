"
" @brief vim script test sample
"
function! GetHTML()
python << EOF
import vim
#print "Hello python"


#===コマンド実行系===
#vimのコマンドを実行
#vim.command("echo 'vim script'")

#===データ取得系===

# vimスクリプトの変数のデータを取得する
# python用にエンコーディングする
#var = unicode(vim.eval("var"),'utr-8')

#スコープの付いた変数を読み込む
#print vim.eval("g:var_g")

#現在開いているファイルのパスを取得
#print vim.current.buffer.name

#今カーソルがある行の文章を取得
#print vim.current.line

#現在ファイルの行数を取得
#print len(vim.current.buffer)

# ヴィジュアルモードの選択範囲のテキストを出力
var=""
for i in vim.current.range:
    var+=i
print var

#===データ追加削除系===

#現在のバッファの末尾に文字を追加
#vim.current.buffer.append("aaa")

#現在のバッファの10行目の下に文字を追加
#vim.current.buffer.append("vvv",10)

#現在のバッファの1行目を置換
#vim.current.buffer[0]="bbb"

#現在のバッファの1行目削除
#del vim.current.buffer[0]

#vimスクリプトの変数を変更する
#vim.command(':let var = "updated value"')

EOF
endfunction
