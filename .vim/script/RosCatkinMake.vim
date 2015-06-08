"
" @brief vim script to execute catkin_make
"
" @author Atsushi Sakai
"
" @copyright (c): 2014 Atsushi Sakai
"
" @license : GPL Software License Agreement

"
" @brief Execute Catkin Make
"
function! RosCatkinMake()
  echo "RosCatkinMake"
  ! cd ~/indigo_workspace/;catkin_make
endfunction

" Command enable
command! RosCatkinMake :call RosCatkinMake()
