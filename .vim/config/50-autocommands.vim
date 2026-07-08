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
endif
