" Get the branch name once per buffer.
function! SetGitBranch() abort
  silent let l:branch = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
  let b:git_branch = strlen(l:branch) > 0 ? 'git[' . l:branch . ']' : ''
endfunction
