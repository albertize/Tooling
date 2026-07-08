" Indentation and tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set backspace=indent,eol,start

" Behavior
set hidden
let g:loaded_matchparen = 1

" Persistent undo
if has('persistent_undo')
  set undofile
  set undodir=~/.vim/undo
endif
