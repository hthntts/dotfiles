" ----------------------------------------------------------------------------
"  _____                 _   _
" |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
" | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
" |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
" |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
" ----------------------------------------------------------------------------

" https://vi.stackexchange.com/a/456/15292
function! tux#functions#stripTrailingWhitespaces() abort
  let l:save = winsaveview()
  keeppatterns %s/\v\s+$//e
  call winrestview(l:save)
endfunction

" https://vi.stackexchange.com/a/9094/15292
function! tux#functions#vimFolds(lnum) abort
  " Get content of current line and the line below
  let l:cur_line = getline(a:lnum)
  let l:next_line = getline(a:lnum+1)

  if l:cur_line =~# '^"{'
    return '>' . (matchend(l:cur_line, '"{*') - 1)
  endif

  if l:cur_line ==# '' && (matchend(l:next_line, '"{*') - 1) == 1
    return 0
  endif

  return '='
endfunction

" https://vi.stackexchange.com/a/3818/15292
" https://vi.stackexchange.com/a/6608/15292
function! tux#functions#foldText() abort
  let l:line = getline(v:foldstart)
  let l:fold_line_num = v:foldend - v:foldstart
  let l:fold_text = substitute(l:line, '^"{\+', '', 'g')
  let l:fill_char_num = &textwidth - len(l:fold_text) - len(l:fold_line_num) - 10
  return printf('+%s%s %s (%s ℓ)', repeat('-', 4), l:fold_text, repeat('-', l:fill_char_num), l:fold_line_num)
endfunction

function! tux#functions#switchLine(src_line_idx, direction) abort
  if a:direction ==# 'up'
    if a:src_line_idx == 1
      return
    endif
    move-2
  elseif a:direction ==# 'down'
    if a:src_line_idx == line('$')
      return
    endif
    move+1
  endif
endfunction

" https://stackoverflow.com/a/61486601/6064933
function! tux#functions#moveSelection(direction) abort
  if visualmode() !=# 'V'
    return
  endif

  let l:start_line = line("'<")
  let l:end_line = line("'>")
  let l:num_line = l:end_line - l:start_line + 1

  if a:direction ==# 'up'
    if l:start_line == 1
      " https://stackoverflow.com/q/9724123/6064933
      normal! gv
      return
    endif
    silent execute printf('%s,%smove-2', l:start_line, l:end_line)
    normal! gv
  elseif a:direction ==# 'down'
    if l:end_line == line('$')
      normal! gv
      return
    endif
    silent execute printf('%s,%smove+%s', l:start_line, l:end_line, l:num_line)
    normal! gv
  endif
endfunction

function! tux#functions#closeOtherBuffer() abort
  let l:bufnr = bufnr()
  execute "only"
  for buffer in getbufinfo()
    if !buffer.listed
      continue
    endif
    if buffer.bufnr == l:bufnr
      continue
    else
      if buffer.changed
        echo buffer.name . " has changed, save first"
        continue
      endif
      let l:cmd = "bdelete " . buffer.bufnr
      execute l:cmd
    endif
  endfor
endfunction


function! tux#functions#getTitlestr() abort
  let l:title_str = ''
  if g:is_mac
    let l:title_str = '[' . hostname() . '] '
  endif
  let l:title_str = l:title_str . '  ' . expand('%:p:~') . '  '
  if &buflisted
    let l:title_str = l:title_str . strftime('- modified: %d-%m-%Y at %H:%M',getftime(expand('%')))
  endif

  return l:title_str
endfunction

" https://stackoverflow.com/a/3400528
function! tux#functions#fillLine(str)
  let tw = &textwidth
  if tw==0 | let tw = 80 | endif
  .s/[[:space:]]*$//
  let reps = (tw - col("$")) / len(a:str)
  if reps > 0
    .s/$/\=(' '.repeat(a:str, reps))/
  endif
endfunction

" Toggle relativenumber + number, number (only), and no numbering.
function! tux#functions#toggleNumber() abort
  if exists('+relativenumber')
    execute {
          \ '00': 'set relativenumber   | set number',
          \ '01': 'set norelativenumber | set number',
          \ '10': 'set norelativenumber | set nonumber',
          \ '11': 'set norelativenumber | set number' }[&number . &relativenumber]
  else
    " No relative numbering, just toggle numbers on and off.
    set number!
  endif
endfunction

" http://stackoverflow.com/a/39348498/2103996
function! tux#functions#clearregisters() abort
  let l:regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
  for l:reg in l:regs
    call setreg(l:reg, [])
  endfor
endfunction

" Turn on spell-checking.
function! tux#functions#spell() abort
  if has('syntax')
    setlocal spell
    setlocal spellfile=~/.vim/spell/en.utf-8.add
    setlocal spelllang=en,es
  endif
endfunction

" Switch to plaintext mode
function! tux#functions#plaintext() abort
  if has('conceal')
    setlocal concealcursor=nc
  endif
  setlocal nolist
  setlocal textwidth=0
  setlocal wrap
  setlocal wrapmargin=0

  call tux#functions#spell()

  " Break undo sequences into chunks (after punctuation); see: `:h i_CTRL-G_u`
  "
  " From:
  "
  "   https://twitter.com/vimgifs/status/913390282242232320
  "
  " Via:
  "
  "   https://github.com/ahmedelgabri/dotfiles/blob/f2b74f6cd4d/files/.vim/plugin/mappings.vim#L27-L33
  "
  inoremap <buffer> ! !<C-g>u
  inoremap <buffer> , ,<C-g>u
  inoremap <buffer> . .<C-g>u
  inoremap <buffer> : :<C-g>u
  inoremap <buffer> ; ;<C-g>u
  inoremap <buffer> ? ?<C-g>u
  nnoremap <buffer> j gj
  nnoremap <buffer> k gk
  " Ideally would keep 'list' set, and restrict 'listchars' to just show
  " whitespace errors, but 'listchars' is global and I don't want to go through
  " the hassle of saving and restoring.
  if has('autocmd')
    autocmd BufWinEnter <buffer> match Error /\s\+$/
    autocmd InsertEnter <buffer> match Error /\s\+\%#\@<!$/
    autocmd InsertLeave <buffer> match Error /\s\+$/
    autocmd BufWinLeave <buffer> call clearmatches()
  endif
endfunction
