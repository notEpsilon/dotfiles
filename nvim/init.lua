vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.diagnostic.config({ virtual_text = true })
vim.lsp.inlay_hint.enable(true)

require("opts")
require("plugins")
