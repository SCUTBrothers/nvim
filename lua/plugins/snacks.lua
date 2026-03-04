return {
  {
    "folke/snacks.nvim",
    opts = {
      words = {
        enabled = false,
      },
      image = {
        enabled = true,
        doc = {
          enabled = false,
        },
      },
    },
    keys = {
      { "gm", function() Snacks.image.hover() end, desc = "Show image under cursor" },
    },
  },
}