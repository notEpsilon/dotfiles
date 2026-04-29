return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "nvim-mini/mini.icons" },
    config = function()
      require("fzf-lua").setup()

      function Map(mode, lhs, rhs, opts)
        local options = { noremap = true, silent = true }
        if opts then
          options = vim.tbl_extend("force", options, opts)
        end
        vim.keymap.set(mode, lhs, rhs, options)
      end

      Map("n", "<leader>ff", require("fzf-lua").files)
      Map("n", "<leader>fg", require("fzf-lua").live_grep)
    end,
  },
};
