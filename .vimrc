" =============================================================================
" GENERAL SETTINGS
" =============================================================================
set nocompatible                " Disable Vi compatibility (required for modern features)
set encoding=utf-8              " Force UTF-8 encoding
set history=1000                " Increase command line history

" =============================================================================
" SYNTAX & COLORS
" =============================================================================
if has("syntax")
    syntax on
    set background=dark

    " Force syntax sync from start (useful if highlighting breaks in large files)
    syntax sync fromstart

    " Spell checking highlight
    highlight SpellBad ctermfg=red ctermbg=black term=Underline

    " Statusline Highlight Groups
    hi User1 ctermfg=green ctermbg=black
    hi User2 ctermfg=yellow ctermbg=black
    hi User3 ctermfg=red ctermbg=black
    hi User4 ctermfg=blue ctermbg=black
    hi User5 ctermfg=white ctermbg=black
endif

" Enable filetype detection, plugins, and indentation rules
filetype plugin indent on

" =============================================================================
" INDENTATION & TABS
" =============================================================================
set tabstop=4                   " Width of a tab character
set softtabstop=4               " Fine-tunes the amount of whitespace to be added
set shiftwidth=4                " Amount of whitespace for indentation commands
set expandtab                   " Convert tabs to spaces
set autoindent                  " Copy indent from current line when starting a new one
set backspace=indent,eol,start  " Allow backspacing over everything in insert mode

" =============================================================================
" SEARCH & NAVIGATION
" =============================================================================
set incsearch                   " Search as characters are entered
set ignorecase                  " Ignore case when searching
set smartcase                   " Ignore case if search pattern is all lowercase
set path+=**                    " Recursive search in subdirectories (fixed syntax)
set wildmenu                    " Visual autocomplete for command menu

" =============================================================================
" UI & VISUALS
" =============================================================================
set ruler                       " Show cursor position
set showmode                    " Show current mode in command line
set laststatus=2                " Always show statusline
"set number                      " Show line numbers (optional, highly recommended)

" =============================================================================
" BEHAVIOR
" =============================================================================
set hidden                      " Allow switching buffers without saving
let loaded_matchparen = 1       " Disable the match paren plugin (per your preference)

" Persistent Undo (Saves undo history to file)
" Note: You must create the directory ~/.vim/undo for this to work
if has('persistent_undo')
    set undofile
    set undodir=~/.vim/undo
endif

" =============================================================================
" FUNCTIONS
" =============================================================================

" Function to get the branch name once
function! SetGitBranch()
  let l:branch = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
  let b:git_branch = (strlen(l:branch) > 0) ? 'git[' . l:branch . ']' : ''
endfunction


" =============================================================================
" AUTOCOMMANDS
" =============================================================================
if has("autocmd")
    " Restore cursor position
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    " Get Git branch only once per buffer
    augroup GetBranch
        autocmd!
        autocmd BufRead,BufNewFile * call SetGitBranch()
    augroup END
endif

" =============================================================================
" STATUSLINE CONFIGURATION
" =============================================================================
set statusline=
set statusline+=%1*\ %n\ %* " Buffer number
set statusline+=%5*%{&ff}%* " File format (dos/unix)
set statusline+=%3*%y%* " File type
set statusline+=%4*\ %<%F%* " Full file path
set statusline+=%2*%m%* " Modified flag [+]
set statusline+=%1*%=%5l%* " Current line number
set statusline+=%2*/%L%* " Total lines
set statusline+=%1*%4v\ %* " Virtual column number
set statusline+=%4*\ %{get(b:,'git_branch','')}%* " Git Branch
