" Wayland clipboard support through wl-clipboard.
"
" This file must be sourced as configuration. autoload/ is for functions loaded
" on demand and is not executed during normal startup.

if exists('v:clipproviders')
  function! s:WaylandClipboardAvailable() abort
    return executable('wl-copy') && executable('wl-paste')
  endfunction

  function! s:WaylandClipboardCopy(reg, type, lines) abort
    let l:cmd = 'wl-copy'
    if a:reg ==# '*'
      let l:cmd .= ' -p'
    endif
    call system(l:cmd, a:lines)
  endfunction

  function! s:WaylandClipboardPaste(reg) abort
    let l:cmd = 'wl-paste --type text/plain;charset=utf-8'
    if a:reg ==# '*'
      let l:cmd .= ' -p'
    endif
    return ['', systemlist(l:cmd)]
  endfunction

  let v:clipproviders['wl_clipboard'] = {
        \ 'available': function('s:WaylandClipboardAvailable'),
        \ 'copy': {
        \   '+': function('s:WaylandClipboardCopy'),
        \   '*': function('s:WaylandClipboardCopy'),
        \ },
        \ 'paste': {
        \   '+': function('s:WaylandClipboardPaste'),
        \   '*': function('s:WaylandClipboardPaste'),
        \ },
        \ }

  set clipmethod=wl_clipboard,wayland,x11
  set clipboard=unnamedplus
endif
