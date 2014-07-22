"
" @brief vim script to show ROS msg contents
"
" @author Atsushi Sakai
"
" @copyright (c): 2014 Atsushi Sakai
"
" @license : GPL Software License Agreement

"
" @brief Show ROS msg contents
"
function! RosmsgShow(msg)
  vnew +enew
  "r! rosmsg show a:msg
  let com="r! rosmsg show ".a:msg
  execute com
  echo a:msg
endfunction

" Command enable
command! -nargs=1 RosmsgShow :call RosmsgShow(<f-args>)
