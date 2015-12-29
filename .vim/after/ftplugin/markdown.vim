" vim configuration for markdown
" Author: Atsushi Sakai


" markdownチートシート"
" NeoBundle 'gist:hail2u/747628', {
       " \ 'name': 'markdown-cheat-sheet.jax',
       " \ 'script_type': 'doc'}

"ブラウザの設定"
let g:previm_open_cmd = 'open -a Firefox'

" <F5>で編集中のファイルをブラウザで表示
nmap <F5> :PrevimOpen<CR>

" <F6>でMarkdownチートシートを表示
nmap <F6> :h my-markdown-cheat-sheet.txt<CR>




