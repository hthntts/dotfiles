if empty(vim_coc)
  "
else
  " Coc multi cursor highlight color -----------------------------------------
  hi CocCursorRange guibg=#b16286 guifg=#ebdbb2

  " Coc ----------------------------------------------------------------------
  let g:coc_snippet_next = '<Tab>'
  let g:coc_snippet_prev = '<S-Tab>'

  " List of the extensions to make sure are always installed -----------------
  let g:coc_global_extensions = [
              \'coc-yank',
              \'coc-pairs',
              \'coc-json',
              \'coc-css',
              \'coc-html',
              \'coc-tsserver',
              \'coc-yaml',
              \'coc-pydocstring',
              \'coc-lists',
              \'coc-snippets',
              \'coc-pyright',
              \'coc-clangd',
              \'coc-prettier',
              \'coc-xml',
              \'coc-syntax',
              \'coc-marketplace',
              \'coc-highlight',
              \'coc-git',
              \'coc-sh',
              \]

  au CursorHold * silent call CocActionAsync('highlight')

  " Coc completion popup -----------------------------------------------------
  autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

  " Format with available file format formatter ------------------------------
  command! -nargs=0 Format :call CocAction('format')

  " Organize imports ---------------------------------------------------------
  command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

  " Check if last inserted char is a backspace (used by coc pmenu) -----------
  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
    endif
  endfunction

  " Use tab to navigate snippet placeholders ---------------------------------
  inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

  " Use enter to accept snippet expansion ------------------------------------
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " Use <c-space> to trigger completion
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif

"| [COC] ---------------------------------------------------------------------
"| K => Show documentation.
  nnoremap <silent> K :call ShowDocumentation()<CR>
"| SPC-ck => Show documentation.
  nnoremap <silent> <leader>ck :call ShowDocumentation()<CR>
"| SPC-cd => Code definition.
  nmap <silent> <leader>cd <Plug>(coc-definition)
"| SPC-cD => Code references.
  nmap <silent> <leader>cD <Plug>(coc-references)
"| SPC-ci => Code implementation.
  nmap <silent> <leader>ci <Plug>(coc-implementation)
"| SPC-cr => Symbol renaming.
  nmap <silent> <leader>cr <Plug>(coc-rename)
"| SPC-ct => Code type definition.
  nmap <silent> <leader>ct <Plug>(coc-type-definition)
"| [g & ]g => Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
"| [COCLIST] -----------------------------------------------------------------
"| SPC-cx => Show all diagnostics.
  nnoremap <silent><nowait> <leader>cx :<C-u>CocList diagnostics<cr>
"| SPC-ce => Manage extensions.
  nnoremap <silent><nowait> <leader>ce :<C-u>CocList extensions<cr>
"| SPC-cc => Show commands.
  nnoremap <silent><nowait> <leader>cc :<C-u>CocList commands<cr>
"| SPC-co => Find symbol of current document.
  nnoremap <silent><nowait> <leader>co :<C-u>CocList outline<cr>
"| SPC-cs => Search workspace symbols.
  nnoremap <silent><nowait> <leader>cs :<C-u>CocList -I symbols<cr>
"| SPC-cl => Search lines current document.
  nnoremap <silent><nowait> <leader>cl :<C-u>CocList lines<cr>
"| SPC-cf => Search files workspace.
  nnoremap <silent><nowait> <leader>cf :<C-u>CocList files<cr>
"| SPC-cv => Edit Snippets.
  nnoremap <silent><nowait> <leader>cv :CocCommand snippets.editSnippets<cr>
"| [COCDOCS] -----------------------------------------------------------------
"| SPC-cdl => Docstring line.
nmap <silent> <leader>cdl <Plug>(coc-codeaction-line)
"| SPC-cds => Docstring select.
xmap <silent> <leader>cdl <Plug>(coc-codeaction-selected)
"| F5 => Docstring.
nnoremap <silent> <F5> :CocCommand pydocstring.runFile<cr>

endif
