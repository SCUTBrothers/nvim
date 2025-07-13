return {
  "mg979/vim-visual-multi",
  branch = "master",
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "<C-n>", mode = { "n", "x" }, desc = "Add cursor down" },
    { "<C-p>", mode = { "n", "x" }, desc = "Add cursor up" },
    { "<C-d>", mode = { "n", "x" }, desc = "Add cursor and move down" },
  },
  init = function()
    vim.g.VM_maps = {
      ["Find Under"] = "<C-n>",
      ["Find Subword Under"] = "<C-n>",
      ["Add Cursor Down"] = "<C-Down>",
      ["Add Cursor Up"] = "<C-Up>",
      ["Add Cursor At Pos"] = "<C-x>",
      ["Add Cursor At Word"] = "<C-w>",
      ["Remove Region"] = "q",
      ["Skip Region"] = "<C-s>",
      ["Select All"] = "<C-a>",
      ["Visual All"] = "<C-a>",
    }
    vim.g.VM_mouse_mappings = 1
    vim.g.VM_theme = "codedark"
  end,
}