if empty(vim_coc)
  lua require('treesitter')
  lua require('luasnip-config')
  lua require('luasnip-tux')
  lua require('nvim-lualine')
  lua require('nvim-tabline')
  lua require('lsp-cmp')
  lua require('lsp-config')
  lua require('lsp-kind')
  lua require('indent-blankline')
  lua require('git')
  lua require('lsp-virtual-improved').setup()
"| [CMP] ---------------------------------------------------------------------
"| K       => Show documentation.
  nnoremap <silent> K :lua vim.lsp.buf.hover()<cr>
"| SPC-ck  => Show documentation.
  nnoremap <silent> <leader>ck :lua vim.lsp.buf.hover()<cr>
"| SPC-cd  => Code definition.
  nnoremap <silent> <leader>cd :lua vim.lsp.buf.definition()<cr>
"| SPC-cD  => Code references.
  nnoremap <silent> <leader>cD :lua vim.lsp.buf.references()<cr>
"| SPC-ci  => Code implementation.
  nnoremap <silent> <leader>ci :lua vim.lsp.buf.implementation()<cr>
"| SPC-cr  => Symbol renaming.
  nnoremap <silent> <leader>cr :lua vim.lsp.buf.rename()<cr>
"| SPC-ct  => Code type definition.
  nnoremap <silent> <leader>ct :lua vim.lsp.buf.type_definition()<cr>
"| [g & ]g => Use `[g` and `]g` to navigate diagnostics
  nnoremap <silent> [g :lua vim.diagnostic.goto_prev()<cr>
  nnoremap <silent> ]g :lua vim.diagnostic.goto_next()<cr>
"| SPC-cx => Show all diagnostics.
  nnoremap <silent> <leader>cx :FzfLua diagnostics_workspace<cr>
endif
