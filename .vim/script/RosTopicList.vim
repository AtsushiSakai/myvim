"
" @brief vim script to show ROS topic list
"
" @author Atsushi Sakai
"
" @copyright (c): 2014 Atsushi Sakai
"
" @license : GPL Software License Agreement

"
" @brief Show ROS topic list
"
function! RosTopicList()
  vnew +enew
  r! rostopic list
endfunction

" Command enable
command! RosTopicList :call RosTopicList()
