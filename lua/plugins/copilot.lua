return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      filetypes = {
        markdown = true,
        help = true,
      },
      -- 使用 Node.js v24.12.0，默认支持 SQLite
      copilot_node_command = vim.fn.expand("$HOME") .. "/.nvm/versions/node/v24.12.0/bin/node",
      suggestion = {
        enabled = true,
        auto_trigger = true,
      },
      panel = {
        enabled = true,
      },
    },
  },
}
