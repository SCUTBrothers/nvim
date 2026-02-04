return {
  "mikavilpas/yazi.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  keys = {
    {
      "-",
      "<cmd>Yazi<cr>",
      desc = "Open yazi at the current file",
    },
    {
      "<leader>-",
      "<cmd>Yazi cwd<cr>",
      desc = "Open yazi in nvim's working directory",
    },
  },
  ---@type YaziConfig | {}
  opts = {
    open_for_directories = false,
    floating_window_scaling_factor = 0.8,
    yazi_floating_window_border = "rounded",
    keymaps = {
      show_help = "<f1>",
    },
  },
}
