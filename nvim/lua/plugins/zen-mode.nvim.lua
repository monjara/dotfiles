return {
  {
    "folke/zen-mode.nvim",
    opts = true,
    keys = {
      {
        "<leader>z",
        function()
          require("zen-mode").toggle()
        end,
        desc = "Zen Mode"
      },
    }
  }
}
