-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--

vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_user_command("CopyRelPath", function()
  vim.api.nvim_call_function("setreg", { "+", vim.fn.fnamemodify(vim.fn.expand("%"), ":.") })
end, {})

-- 创建自动命令组
local im_select_group = vim.api.nvim_create_augroup("im_select", { clear = true })

-- 在退出插入模式时切换到英文输入法
vim.api.nvim_create_autocmd("InsertLeave", {
  group = im_select_group,
  callback = function()
    vim.fn.system("/opt/homebrew/bin/macism com.apple.keylayout.ABC")
  end,
})

-- -- 保存上一次的输入法状态
-- local last_im_select = ""

-- -- 在退出插入模式时保存当前输入法状态
-- vim.api.nvim_create_autocmd("InsertLeave", {
--   group = im_select_group,
--   callback = function()
--     last_im_select = vim.fn.system("/opt/homebrew/bin/macism")
--   end,
-- })
--
-- -- 在进入插入模式时恢复输入法状态
-- vim.api.nvim_create_autocmd("InsertEnter", {
--   group = im_select_group,
--   callback = function()
--     if last_im_select ~= "" then
--       vim.fn.system("/opt/homebrew/bin/macism " .. last_im_select)
--     end
--   end,
-- })
--

-- 移除注释行创建新行的时候自动添加注释前缀
-- 移除自动注释选项
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "o", "r" })
  end,
})
