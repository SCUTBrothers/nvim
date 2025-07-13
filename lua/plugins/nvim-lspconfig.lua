return {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- disable a keymap
    keys[#keys + 1] = { "K", false }
    -- add a keymap
    keys[#keys + 1] = { "gh", vim.lsp.buf.hover }
  end,
  opts = {
    inlay_hints = { enabled = false },
    diagnostics = {
      virtual_text = false, -- 禁用行内诊断
    },
    document_highlight = {
      enabled = false,
    },
  },
}
