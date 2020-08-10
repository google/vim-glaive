" This file is used from vroom scripts to bootstrap the codefmt plugin and
" configure it to work properly under vroom.

" Glaive does not support compatible mode.
set nocompatible

" Set cmdheight to avoid getting stuck at "Hit ENTER to continue" prompts,
" particularly in neovim mode.
set cmdheight=99

" Install the glaive plugin and dependencies.
let s:glaivedir = fnamemodify($VROOMFILE, ':p:h:h')
execute 'source' s:glaivedir . '/bootstrap.vim'
