"
" @brief vim script test sample
"
function! GetHTML()
python << EOF
import vim
#print "Hello python"


#===$B%3%^%s%I<B9T7O(B===
#vim$B$N%3%^%s%I$r<B9T(B
#vim.command("echo 'vim script'")

#===$B%G!<%?<hF@7O(B===

# vim$B%9%/%j%W%H$NJQ?t$N%G!<%?$r<hF@$9$k(B
# python$BMQ$K%(%s%3!<%G%#%s%0$9$k(B
#var = unicode(vim.eval("var"),'utr-8')

#$B%9%3!<%W$NIU$$$?JQ?t$rFI$_9~$`(B
#print vim.eval("g:var_g")

#$B8=:_3+$$$F$$$k%U%!%$%k$N%Q%9$r<hF@(B
#print vim.current.buffer.name

#$B:#%+!<%=%k$,$"$k9T$NJ8>O$r<hF@(B
#print vim.current.line

#$B8=:_%U%!%$%k$N9T?t$r<hF@(B
#print len(vim.current.buffer)

# $B%t%#%8%e%"%k%b!<%I$NA*BrHO0O$N%F%-%9%H$r=PNO(B
var=""
for i in vim.current.range:
    var+=i
print var

#===$B%G!<%?DI2C:o=|7O(B===

#$B8=:_$N%P%C%U%!$NKvHx$KJ8;z$rDI2C(B
#vim.current.buffer.append("aaa")

#$B8=:_$N%P%C%U%!$N(B10$B9TL\$N2<$KJ8;z$rDI2C(B
#vim.current.buffer.append("vvv",10)

#$B8=:_$N%P%C%U%!$N(B1$B9TL\$rCV49(B
#vim.current.buffer[0]="bbb"

#$B8=:_$N%P%C%U%!$N(B1$B9TL\:o=|(B
#del vim.current.buffer[0]

#vim$B%9%/%j%W%H$NJQ?t$rJQ99$9$k(B
#vim.command(':let var = "updated value"')

EOF
endfunction
