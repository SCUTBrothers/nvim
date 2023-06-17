return {
  {
    "zbirenbaum/copilot.lua",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = true, auto_trigger = true },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
        lua = true,
      },
    },
  },
}
