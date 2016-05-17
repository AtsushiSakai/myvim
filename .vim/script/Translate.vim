"
" @brief Translate
"
" @author Atsushi Sakai
"
" @copyright (c): 2016 Atsushi Sakai
"
" @license : MIT

function! DecimalChange()
  echo "DecimalChange"
  let word = expand("<cword>")
python << EOF
import vim
num = unicode(vim.eval("word"),'utf-8')
two=format (int(num),'b')
hexnum=hex(int(num))
final="0b"+two+" "+hexnum+" "+num
print final
EOF
endfunction

function! HexChange()
  echo "HexChange"
  let word = expand("<cword>")
python << EOF
import vim
num = unicode(vim.eval("word"),'utf-8')
if "0x" in num:
  flagnum=0
else:
  flagnum=16
two=format (int(num,flagnum),'b')
hexnum=num
if flagnum is 16:
  hexnum="0x"+hexnum
decnum=str(int(num,flagnum))
final="0b"+two+" "+hexnum+" "+decnum
print final
EOF
endfunction

function! BinaryChange()
  echo "BinaryChange"
  let word = expand("<cword>")
python << EOF
import vim
num = unicode(vim.eval("word"),'utf-8')
if "0b" in num:
  flagnum=0
else:
  flagnum=2
two=num
if flagnum is 2:
  two="0b"+two
decnum=str(int(num,flagnum))
hexnum=hex(int(decnum))
final=two+" "+hexnum+" "+decnum
print final
EOF
endfunction

command! DecimalChange :call DecimalChange()
command! HexChange :call HexChange()
command! BinaryChange :call BinaryChange()

