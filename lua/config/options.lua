-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.list = false
vim.opt.relativenumber = false

-- 根据环境变量设置背景色
local theme_mode = vim.env.THEME_MODE or "dark" -- 默认深色主题
vim.opt.background = theme_mode

-- 禁用光标下单词的高亮
vim.opt.hlsearch = false -- 禁用搜索高亮

-- 禁用 conceal 功能，防止 markdown 预览
vim.opt.conceallevel = 0
