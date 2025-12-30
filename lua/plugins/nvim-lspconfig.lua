return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    diagnostics = {
      virtual_text = false, -- 禁用行内诊断
    },
    document_highlight = {
      enabled = false,
    },
    servers = {
      ["*"] = {
        keys = {
          { "K", "", enabled = false },
          { "gh", vim.lsp.buf.hover },
        },
      },
      -- 禁用 TypeScript 的自动类型获取 (ATA)
      vtsls = {
        settings = {
          typescript = {
            disableAutomaticTypeAcquisition = true,
          },
          javascript = {
            disableAutomaticTypeAcquisition = true,
          },
        },
      },
    },
  },
}
