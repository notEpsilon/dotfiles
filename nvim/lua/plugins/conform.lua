return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
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
    },
  },
};
