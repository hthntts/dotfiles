let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
nnoremap <silent> <M-\> :TmuxNavigatePrevious<cr>

if empty(vim_coc)

else
  let g:diminactive_use_syntax = 0
  let g:diminactive_enable_focus = 1

  let g:tmuxline_powerline_separators = 0
  let g:tmuxline_preset = {
        \'a'    : '#S',
        \'b'    : '#{?client_prefix,#[fg=colour221]%a %d-%m,%a %d-%m}',
        \'c'    : '%R',
        \'win'  : '*[#I]*',
        \'cwin' : '=>[#I]<=',
        \'x'    : '#W',
        \'y'    : '#(uptime | cut -d"," -f1,2 | cut -d" " -f4,5,6,7)',
        \'z'    : 'Tux'}

  let g:airline#extensions#tmuxline#enabled = 1
  " let g:airline_section_c = "%<%t%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#%#__accent_bold#%{airline#util#wrap(airline#extensions#coc#get_status(),0)}%#__restore__#%#__accent_bold#%#__restore__#"
endif
