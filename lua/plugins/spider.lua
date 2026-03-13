return {
  {
    "tris203/precognition.nvim",
    event = "VeryLazy",
    opts = {
      startVisible = true,
    },
    keys = {
      {
        "<leader>uP",
        function()
          if require("precognition").toggle() then
            LazyVim.info("Precognition is on")
          else
            LazyVim.warn("Precognition is off")
          end
        end,
        desc = "Toggle Precognition",
      },
    },
  },
  {
    "chrisgrieser/nvim-spider",
    dependencies = { "tris203/precognition.nvim" },
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" }, desc = "Spider w" },
      { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" }, desc = "Spider e" },
      { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" }, desc = "Spider b" },
      { "ge", "<cmd>lua require('spider').motion('ge')<CR>", mode = { "n", "o", "x" }, desc = "Spider ge" },
    },
    opts = {},
  },
}
