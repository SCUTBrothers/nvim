-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- 基础移动映射
map("n", "H", "^", { desc = "move to line start" })
map("n", "L", "$", { desc = "move to line start" })

-- buffer操作
map("n", "<S-j>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<S-k>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

-- 文件浏览
map("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

-- explorer
map("n", "<leader>yy", "<cmd>CopyRelPath<cr>", { desc = "Copy relative file path" })
