return {
  "catppuccin/nvim",
  priority = 1000, -- Ensure it loads first
  config = function()
    vim.cmd("catppucin-mocha")
  end,
}
