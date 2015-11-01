"
" @brief vim script test sample
"
function! GetHTML()
echon "Vim script sample !!"
python << EOF
import vim, BeautifulSoup, urllib
handle = urllib.urlopen(vim.current.line)
soup = BeautifulSoup.BeautifulSoup(handle.read())
vim.current.buffer[:] = soup.prettify().split('\n')
EOF
endfunction
let num=1.0/2.0
vnew a
r! ls
