if &cp || (exists('g:loaded_ros_vim') && g:loaded_ros_vim)
    finish
endif
let g:loaded_ros_vim = 1

function! s:RosPackMatchedList(str)
    let packs = split(system('rospack list | cut -f 1 -d" "'),"\n")
    let matches = []
    for pack in packs
        if pack =~? '^' . strpart(a:str, 0)
            call add(matches, pack )
        endif
    endfor
    return matches
endfunction

function! s:Roscdcomplete(arg_lead,cmdline,cursor_pos)
    let args = split(a:arg_lead,'/')
    if (len(args) == 0) || (len(args) == 1 && a:arg_lead[strlen(a:arg_lead)-1] != '/')
        return s:RosPackMatchedList(a:arg_lead)
    endif

    let pkgname = args[0]
    let reldir = ''
    for i in args[1:]
      let reldir = reldir . '/' . i
    endfor
    let location = ros#RosDecodePath(pkgname)[1]
    if isdirectory(location . reldir)
      return map(filter(split(glob(location . reldir . '/*'),"\n"),"isdirectory(v:val)"),'pkgname.v:val[strlen(location):]')
    else
      return map(filter(split(glob(location . reldir . '*'),"\n"),"isdirectory(v:val)"),'pkgname.v:val[strlen(location):]')
    endif
endfunction

function! s:Rosedcomplete(arg_lead,cmdline,cursor_pos)
    let args = split(a:arg_lead,'/')
    if (len(args) == 0) || (len(args) == 1 && a:arg_lead[strlen(a:arg_lead)-1] != '/')
        return s:RosPackMatchedList(a:arg_lead)
    endif

    let pkgname = args[0]
    let reldir = ''
    for i in args[1:]
      let reldir = reldir . '/' . i
    endfor
    let location = ros#RosDecodePath(pkgname)[1]
    if isdirectory(location . reldir) 
      return map(split(glob(location . reldir . '/*'),"\n"),'pkgname.v:val[strlen(location):]')
    else
      return map(split(glob(location . reldir . '*'),"\n"),'pkgname.v:val[strlen(location):]')
    endif
endfunction

command! -nargs=* -complete=customlist,s:Roscdcomplete Roscd :call ros#RosChangeDir(<f-args>)
command! -nargs=* -complete=customlist,s:Rosedcomplete Rosed :call ros#RosEditDir(<f-args>)
command! -nargs=* -complete=customlist,s:Rosedcomplete Roscded :call ros#RosCDandEditDir(<f-args>)
command! -nargs=* -complete=customlist,s:Rosedcomplete Rostabed :call ros#RosTabEditDir(<f-args>)
command! -nargs=* -complete=customlist,s:Rosedcomplete Roscdtabed :call ros#RosCDandTabEditDir(<f-args>)
