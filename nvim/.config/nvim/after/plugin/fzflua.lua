local actions = require "fzf-lua.actions"
require'fzf-lua'.setup {
  winopts = {
    -- split         = "belowright new",-- open in a split instead?
    height           = 0.85,            -- window height
    width            = 0.80,            -- window width
    row              = 0.35,            -- window row position (0=top, 1=bottom)
    col              = 0.50,            -- window col position (0=left, 1=right)
    -- border           = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    border           = { '┌', '─', '┐', '│', '┘', '─', '└', '│'},
    fullscreen       = false,           -- start fullscreen?
    hl = {
      normal         = 'Normal',        -- window normal color (fg+bg)
      border         = 'Normal',        -- border color (try 'FloatBorder')
      cursor         = 'Cursor',        -- cursor highlight (grep/LSP matches)
      cursorline     = 'CursorLine',    -- cursor line
      title          = 'Normal',        -- preview border title (file/buffer)
    },
    preview = {
      -- default     = 'bat',           -- override the default previewer?
      border         = 'border',        -- border|noborder, applies only to
      wrap           = 'nowrap',        -- wrap|nowrap
      hidden         = 'nohidden',      -- hidden|nohidden
      vertical       = 'down:50%',      -- up|down:size
      horizontal     = 'right:60%',     -- right|left:size
      layout         = 'flex',          -- horizontal|vertical|flex
      flip_columns   = 120,             -- #cols to switch to horizontal on flex
      -- Only valid with the builtin previewer:
      title          = true,            -- preview border title (file/buf)?
      scrollbar      = 'float',         -- `false` or string:'float|border'
      scrolloff      = '-2',            -- float scrollbar offset from right
      scrollchars    = {'█', '' },      -- scrollbar chars ({ <full>, <empty> }
    },
  },
}
