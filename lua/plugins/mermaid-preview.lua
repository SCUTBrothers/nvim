return {
  dir = "~/Documents/mermaid-preview-nvim",
  ft = { "markdown", "mermaid" },
  keys = {
    { "<leader>mm", "<cmd>MermaidPreview<cr>", desc = "Mermaid Preview", ft = { "markdown", "mermaid" } },
  },
  opts = {
    theme_dark = "catppuccin-mocha",
    theme_light = "catppuccin-latte",
    font = "FZQingKeBenYueSongS-R-GB, Hack Nerd Font Mono, PingFang SC, Times New Roman, sans-serif",
  },
}
