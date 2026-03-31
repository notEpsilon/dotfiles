require("util")

-- local function set_transparent() -- set UI component to transparent
--   local groups = {
--     "Normal",
--     "NormalNC",
--     "EndOfBuffer",
--     "NormalFloat",
--     "FloatBorder",
--     "SignColumn",
--     "StatusLine",
--     "StatusLineNC",
--     "TabLine",
--     "TabLineFill",
--     "TabLineSel",
--     -- "ColorColumn",
--   }
--   for _, g in ipairs(groups) do
--     vim.api.nvim_set_hl(0, g, { bg = "none" })
--   end
--   vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", fg = "#767676" })
-- end

vim.pack.add({
	{ src = "https://github.com/ellisonleao/gruvbox.nvim" },
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/saghen/blink.cmp", version = "v1.10.1" },
	{ src = "https://github.com/folke/flash.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
})

-------------------------------------------------------------------------- theme
vim.o.background = "dark"
require("gruvbox").setup({
	contrast = "hard",
})
vim.cmd([[colorscheme gruvbox]])
-------------------------------------------------------------------------- theme-end

-------------------------------------------------------------------------- mini
require("mini.pairs").setup()
require("mini.cursorword").setup()
require("mini.indentscope").setup()
require("mini.notify").setup()
require("mini.trailspace").setup()
require("mini.comment").setup()
require("mini.icons").setup()
-------------------------------------------------------------------------- mini-end

-------------------------------------------------------------------------- lualine
require("lualine").setup()
-------------------------------------------------------------------------- lualine-end

-------------------------------------------------------------------------- treesitter
local treesitter = require("nvim-treesitter")
treesitter.setup({})

local ensure_installed = {
	"vim",
	"vimdoc",
	"rust",
	"c",
	"cpp",
	"go",
	"html",
	"css",
	"javascript",
	"typescript",
	"tsx",
	"json",
	"lua",
	"markdown",
	"python",
	"vue",
	"svelte",
	"bash",
	"zig",
}

local config = require("nvim-treesitter.config")

local already_installed = config.get_installed()
local parsers_to_install = {}

for _, parser in ipairs(ensure_installed) do
	if not vim.tbl_contains(already_installed, parser) then
		table.insert(parsers_to_install, parser)
	end
end

if #parsers_to_install > 0 then
	treesitter.install(parsers_to_install)
end

local group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = group,
	callback = function(args)
		if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match)) then
			vim.treesitter.start(args.buf)
		end
	end,
})

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name = ev.data.spec.name
		local kind = ev.data.kind

		if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end

			vim.cmd("TSUpdate")
		end
	end,
})
-------------------------------------------------------------------------- treesitter-end

-------------------------------------------------------------------------- fzf
require("fzf-lua").setup()

Map("n", "<leader>ff", require("fzf-lua").files)
Map("n", "<leader>fg", require("fzf-lua").live_grep)
-------------------------------------------------------------------------- fzf-end

-------------------------------------------------------------------------- mason
require("mason").setup()
-- require("lspconfig").setup()
require("mason-lspconfig").setup()
-------------------------------------------------------------------------- mason-end

-------------------------------------------------------------------------- blink
require("blink-cmp").setup({
	-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
	-- 'super-tab' for mappings similar to vscode (tab to accept)
	-- 'enter' for enter to accept
	-- 'none' for no mappings
	--
	-- All presets have the following mappings:
	-- C-space: Open menu or open docs if already open
	-- C-n/C-p or Up/Down: Select next/previous item
	-- C-e: Hide menu
	-- C-k: Toggle signature help (if signature.enabled = true)
	--
	-- See :h blink-cmp-config-keymap for defining your own keymap
	keymap = { preset = "enter" },

	appearance = {
		-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- Adjusts spacing to ensure icons are aligned
		nerd_font_variant = "mono",
	},

	-- (Default) Only show the documentation popup when manually triggered
	completion = { documentation = { auto_show = true } },

	-- Default list of enabled providers defined so that you can extend it
	-- elsewhere in your config, without redefining it, due to `opts_extend`
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},

	-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
	-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
	-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
	--
	-- See the fuzzy documentation for more information
	fuzzy = { implementation = "prefer_rust" },
})
-------------------------------------------------------------------------- blink-end

-------------------------------------------------------------------------- flash
require("flash").setup()

Map({ "n", "x", "o" }, "s", require("flash").jump)
-------------------------------------------------------------------------- flash-end

-------------------------------------------------------------------------- conform
local conform = require("conform")

local function format_and_report()
	local bufnr = vim.api.nvim_get_current_buf()

	-- Get the formatters that WILL run
	local formatters = conform.list_formatters(bufnr)
	local names = {}
	for _, f in ipairs(formatters) do
		if f.available then
			table.insert(names, f.name)
		end
	end

	-- Run formatting
	conform.format({ bufnr = bufnr, lsp_fallback = true, async = false, timeout_ms = 1000 })

	-- Report
	if #names > 0 then
		print("Formatted with: " .. table.concat(names, ", "))
	else
		print("No formatter available")
	end
end

conform.setup({
	formatters_by_ft = {
		javascript = { "oxfmt" },
		typescript = { "oxfmt" },
		javascriptreact = { "oxfmt" },
		typescriptreact = { "oxfmt" },
		css = { "oxfmt", "prettier" },
		html = { "oxfmt", "prettier" },
		json = { "oxfmt", "prettier" },
		yaml = { "oxfmt", "prettier" },
		markdown = { "oxfmt", "prettier" },
		lua = { "stylua" },
		c = { "clang-format" },
		cpp = { "clang-format" },
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	},
})

Map({ "n", "v" }, "<leader>mp", format_and_report)
-------------------------------------------------------------------------- conform-end
