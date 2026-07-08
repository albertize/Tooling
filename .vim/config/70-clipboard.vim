" Wayland clipboard support through wl-clipboard.
"
" This file must be sourced as configuration. autoload/ is for functions loaded
" on demand and is not executed during normal startup.

if exists('v:clipproviders')
  let s:clipboard_jobs = []

  function! s:WaylandClipboardAvailable() abort
    return executable('wl-copy') && executable('wl-paste')
  endfunction

  function! s:WaylandClipboardJobExit(job, status) abort
    let l:index = index(s:clipboard_jobs, a:job)
    if l:index >= 0
      call remove(s:clipboard_jobs, l:index)
    endif
  endfunction

  function! s:RegisterText(type, lines) abort
    let l:text = join(a:lines, "\n")
    if a:type ==# 'V'
      let l:text .= "\n"
    endif
    return l:text
  endfunction

  function! s:WaylandClipboardCopy(reg, type, lines) abort
    let l:cmd = ['wl-copy']
    if a:reg ==# '*'
      call add(l:cmd, '-p')
    endif
    let l:job = job_start(l:cmd, {
          \ 'in_io': 'pipe',
          \ 'in_mode': 'raw',
          \ 'out_io': 'null',
          \ 'err_io': 'null',
          \ 'exit_cb': function('s:WaylandClipboardJobExit'),
          \ 'stoponexit': '',
          \ })
    if job_status(l:job) ==# 'fail'
      return
    endif
    call add(s:clipboard_jobs, l:job)
    let l:channel = job_getchannel(l:job)
    call ch_sendraw(l:channel, s:RegisterText(a:type, a:lines))
    call ch_close_in(l:channel)
  endfunction

  function! s:WaylandClipboardPaste(reg) abort
    let l:cmd = ['wl-paste', '--type', 'text/plain;charset=utf-8']
    if a:reg ==# '*'
      call add(l:cmd, '-p')
    endif
    silent let l:lines = systemlist(l:cmd)
    return ['', l:lines]
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
