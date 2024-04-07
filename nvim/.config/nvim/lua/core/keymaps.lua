local function map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
end
local opts = { noremap = true, silent = true }

-- Space as leader
map('n', '<Space>', '', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes
-- normal_mode = "n", insert_mode = "i", visual_mode = "v",
-- visual_block_mode = "x", term_mode = "t", command_mode = "c",

-- Clear search, diff update and redraw
map({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and clear hlsearch' })

-- Add undo breakpoints
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ';', ';<c-g>u')

-- Turn the word under cursor to upper case
map('i', '<C-u>', '<Esc>viwUea')

-- Turn the current word into title case
map('i', '<C-t>', '<Esc>b~lea')

-- Center Cursors
map('n', '<C-d>', '<C-d>zz', opts)
map('n', '<C-u>', '<C-u>zz', opts)

-- New line without insert
map('n', '<Enter>', 'o<ESC>', opts)

-- Better up/down
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Increment/decrement
map({ 'n', 'v', 'x' }, '-', '<C-x>', opts)
map({ 'n', 'v', 'x' }, '=', '<C-a>', opts)

-- Move to line beginning and end
map({ 'n', 'v', 'x' }, 'gl', '$', { desc = 'End of line' })
map({ 'n', 'v', 'x' }, 'gh', '^', { desc = 'Beginning of line' })

-- Visual emulate windows copy/cut behavior
map('v', '<LeftRelease>', '"+y<LeftRelease>', opts)
map('v', '<C-c>', '"+y<cr>', opts)
map('v', '<C-x>', '"+d<cr>', opts)

-- Visual overwrite paste
map({ 'v', 'x' }, 'p', '"_dP', opts)

-- Visual do not copy on x
map({ 'v', 'x' }, 'x', '"_x', opts)

-- Visual move text up and down
map({ 'v', 'x' }, 'J', ":move '>+1<CR>gv-gv", opts)
map({ 'v', 'x' }, 'K', ":move '<-2<CR>gv-gv", opts)

-- Visual better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Visual find and replace
map('x', '<C-h>', ':s/')

-- Consistent n/N search navigation
map('n', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('n', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
