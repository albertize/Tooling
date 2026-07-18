" Syntax and colors
if has('syntax')
  syntax on
  filetype plugin indent on
  set background=dark

  " Force syntax sync from start, useful if highlighting breaks in large files.
  syntax sync fromstart

  highlight SpellBad ctermfg=red term=Underline

  " Statusline highlight groups
  highlight User1 ctermfg=green ctermbg=black
  highlight User2 ctermfg=yellow ctermbg=black
  highlight User3 ctermfg=red ctermbg=black
  highlight User4 ctermfg=blue ctermbg=black
  highlight User5 ctermfg=white ctermbg=black
endif

" UI and visuals
set ruler
set showmode
set laststatus=2
" set number
