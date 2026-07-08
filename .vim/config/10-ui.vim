" Syntax and colors
if has('syntax')
  syntax on
  set background=dark

  " Force syntax sync from start, useful if highlighting breaks in large files.
  syntax sync fromstart

  highlight SpellBad ctermfg=red term=Underline

  " Statusline highlight groups
  highlight User1 ctermfg=green ctermbg=236
  highlight User2 ctermfg=yellow ctermbg=236
  highlight User3 ctermfg=red ctermbg=236
  highlight User4 ctermfg=blue ctermbg=236
  highlight User5 ctermfg=white ctermbg=236
endif

" UI and visuals
set ruler
set showmode
set laststatus=2
" set number
