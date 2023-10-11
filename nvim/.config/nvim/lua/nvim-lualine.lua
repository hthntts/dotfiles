local opts = {
  options = {
    icons_enabled = true,
    theme = 'auto',
    -- section_separators = { left = '', right = ''},
    -- component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    component_separators = { left = '', right = ''},
    disabled_filetypes = {'startify'},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      'branch',
      {
        'diff',
        colored = true,      -- displays diff status in color if set to true
        diff_color = {
          added = nil,       -- changes diff's added color
          modified = nil,    -- changes diff's modified color
          removed = nil,     -- changes diff's removed color
        },
        source = nil,        -- A function that works as a data source for diff.
        symbols = {added = ' ', modified = ' ', removed = ' '}, -- changes diff symbols
      }
    },
    lualine_c = {
      {
        'filename',
        file_status = true,               -- displays file status (readonly status, modified status)
        path = 0,                         -- 0 = just filename, 1 = relative path, 2 = absolute path
        shorting_target = 40,             -- Shortens path to leave 40 space in the window
        -- symbols = {
        --   modified = '[modified]',      -- Text to show when the file is modified.
        --   readonly = '[readonly]',      -- Text to show when the file is non-modifiable or readonly.
        --   unnamed = '[No Name]',        -- Text to show for unnamed buffers.
          
        -- }
      }
    },
    lualine_x = {
      {
      'diagnostics',
      -- Table of diagnostic sources, available sources are:
      --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
      -- or a function that returns a table as such:
      --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
      sources = { 'nvim_diagnostic', 'coc' },

      -- Displays diagnostics for the defined severity types
      sections = { 'error', 'warn', 'info', 'hint' },

      diagnostics_color = {
        error = {fg='#E06C75', bg='#31353F'},
        hint = {fg='#56B6C2', bg='#31353F'},
        warn = {fg='#E5C07B', bg='#31353F'},
        info = {fg='#3B4252', bg='#31353F'},
      },
      symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
      colored = true,           -- Displays diagnostics status in color if set to true.
      update_in_insert = true,  -- Update diagnostics in insert mode.
      always_visible = false,   -- Show diagnostics even if there are none.
      },
      -- 'filesize',
      'encoding',
      'fileformat',
    },
    lualine_y = {'filetype'},
    lualine_z = {'progress', 'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { require'tabline'.tabline_buffers },
    lualine_x = { require'tabline'.tabline_tabs },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = {'quickfix', 'nvim-tree', 'fugitive', 'fern'}
}

require('lualine').setup(opts)
