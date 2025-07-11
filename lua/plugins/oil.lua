return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
    -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
    -- prevent oil take over neotree explorer
    default_file_explorer = false,
    float = {
      max_width = 0.5,
      max_height = 0.5,
    },
    view_options = {
      show_hidden = true, -- Show hidden files by default
    },
  },
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
