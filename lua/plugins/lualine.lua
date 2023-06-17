return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  opts = {
    options = {
      theme = "auto",
      component_separators = { left = "|", right = "|" },
      -- https://github.com/ryanoasis/powerline-extra-symbols
      section_separators = { left = " ", right = "" },
    },
    extensions = { "nvim-tree", "toggleterm" },
    sections = {
      lualine_c = {
        "filename",
        {
          "lsp_progress",
          spinner_symbols = {
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
          },
        },
      },
      lualine_x = {
        "filesize",
        {
          "fileformat",
          -- symbols = {
          --   unix = '', -- e712
          --   dos = '', -- e70f
          --   mac = '', -- e711
          -- },
          symbols = { unix = "LF", dos = "CRLF", mac = "CR" },
        },
        "encoding",
        "filetype",
      },
    },
  },
}
