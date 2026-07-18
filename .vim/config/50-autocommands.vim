" Autocommands
if has('autocmd')
  augroup RestoreCursorPosition
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line('$') | execute "normal! g'\"" | endif
  augroup END

  augroup GetBranch
    autocmd!
    autocmd BufRead,BufNewFile * call SetGitBranch()
  augroup END

  augroup RestoreEditorRendering
    autocmd!
    autocmd BufEnter * if &buftype ==# '' && empty(&l:syntax) && !empty(&l:filetype) | execute 'setlocal syntax=' . &l:filetype | endif
  augroup END
endif
