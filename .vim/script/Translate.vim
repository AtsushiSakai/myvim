"
" @brief Translate
"
" @author Atsushi Sakai
"
" @copyright (c): 2016 Atsushi Sakai
"
" @license : MIT

function! Translate(arg)
let l:arg=a:arg
" echo g:myvimpath
python << EOF
import vim
import sys
path = unicode(vim.eval("g:myvimpath"),'utf-8')
sys.path.append(path+'.vim/script')#$B%U%k%Q%9$G$"$kI,MW$,$"$k(B
#print(sys.path)
import Translate
var = vim.eval("l:arg")
output=Translate.translate(var)
print(output)
EOF
endfunction

" Command enable
command! -nargs=* Translate :call Translate(<f-args>)

