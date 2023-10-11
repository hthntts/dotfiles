require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "ansiblels", "bashls", "cssls", "html", "marksman", "pyright", "terraformls", "vimls", "yamlls" },
}
