ros.vim -- vim plugin for ros

I sort [rosvim.vim](http://www.ros.org/wiki/IDEs?action=AttachFile&do=view&target=rosvim.vim) by Michael Styer and add tab completion feature.

# Install
Bundle/NeoBundle will be convenient plugins to install this plugin.

    $ cd .vim
    $ git clone https://github.com/Shougo/neobundle.vim.git
    $ cat > .vimrc
    "neobundle(https://github.com/Shougo/neobundle.vim.git)
    set nocompatible              " Be Improved
    filetype off                  " Required!
    if has('vim_starting')
      set rtp+=~/.vim/neobundle.vim/
    endif
    call neobundle#rc(expand('~/.vim/bundle/'))

    NeoBundle "ompugao/ros.vim"

    filetype plugin indent on
    (type Ctrl-D)

# Usage
- change dir:

    :Roscd 
    
- edit some file:

    :Rosed

# Edit your .vimrc
you can add a keymap to call :Roscd/:Rosed like this:

    noremap <Leader>rc :<C-u>Roscd<space>
    noremap <Leader>re :<C-u>Rosed<space>
