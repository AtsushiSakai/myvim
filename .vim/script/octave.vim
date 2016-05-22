"
" @brief vim utility for octave
"
" @author Atsushi Sakai
"
" @copyright (c): 2014 Atsushi Sakai
"
" @license : GPL Software License Agreement

"
" @brief Execute Octave Script of the buffer
"
function! ExeOctave()
  cd %:h
  !octave '%'
  cd -
endfunction

" Command 
command! ExeOctave :call ExeOctave()
