" Statusline configuration
set statusline=
set statusline+=%1*\ %n\ %*
set statusline+=%5*%{&ff}%*
set statusline+=%3*%y%*
set statusline+=%4*\ %<%F%*
set statusline+=%2*%m%*
set statusline+=%1*%=%5l%*
set statusline+=%2*/%L%*
set statusline+=%1*%4v\ %*
set statusline+=%4*\ %{get(b:,'git_branch','')}%*
