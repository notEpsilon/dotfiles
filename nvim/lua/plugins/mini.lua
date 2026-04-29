return {
  {
    "nvim-mini/mini.nvim",
    version = false,
    config = function()
      require("mini.pairs").setup()
      require("mini.cursorword").setup()
      require("mini.indentscope").setup()
      require("mini.notify").setup()
      require("mini.trailspace").setup()
      require("mini.comment").setup()
      require("mini.icons").setup()
    end,
  },
};
