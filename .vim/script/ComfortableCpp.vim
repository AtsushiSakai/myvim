"
" @brief Translate
"
" @author Atsushi Sakai
"
" @copyright (c): 2016 Atsushi Sakai
"
" @license : MIT

function! s:get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

function! PrintStruct()
" echo g:myvimpath
let l:arg=s:get_visual_selection()
python << EOF
import vim
import sys
path = unicode(vim.eval("g:myvimpath"),'utf-8')
sys.path.append(path+'.vim/script')#フルパスである必要がある
#print(sys.path)
import PrintStruct
var = vim.eval("l:arg")
info=PrintStruct.GetStructInfo(var)
code=PrintStruct.GetPrintFuncCode(info)
vim.command(":let @*='"+code+"'")
EOF
endfunction

" Command enable
command! PrintStruct :call PrintStruct()


