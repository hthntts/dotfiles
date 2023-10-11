vim.g.indent_blankline_char = "▏"
vim.g.indent_blankline_show_first_indent_level = true
vim.g.indent_blankline_filetype_exclude = {
  "fugitive",  "gitcommit",  "markdown",  "json",
  "txt",  "help",  "git",  "undotree", "startify",
}
vim.g.indent_blankline_buftype_exclude = {"terminal", "nofile"}
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {
  "class", "function", "method", "block",
  "list_literal", "selector", "^if", "^table",
  "if_statement", "while", "for"
}
vim.g.indent_blankline_context_pattern_highlight= {
  "class", "function", "method", "block",
  "list_literal", "selector", "^if", "^table",
  "if_statement", "while", "for"
}
vim.cmd("autocmd CursorMoved * IndentBlanklineRefresh")
