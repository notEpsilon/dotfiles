vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.diagnostic.config({ virtual_text = true })
vim.lsp.inlay_hint.enable(true)

require("config.opts")
require("config.lazy")

