local opt = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>so", ":so %<CR>", opt)

vim.keymap.set("n", "<leader>w", ":w%<CR>", opt)
vim.keymap.set("n", "<leader>p", ":Lazy<CR>", opt)

vim.keymap.set("n", "q", ":w<CR>:BufDel<CR>", opt)
vim.keymap.set("n", '"', 'ci"')

vim.keymap.set("n", "<C-j>", "<C-w>j", opt)
vim.keymap.set("n", "<C-k>", "<C-w>k", opt)
vim.keymap.set("n", "<C-n>", "<C-w>h", opt)
vim.keymap.set("n", "<C-m>", "<C-w>l", opt)

vim.keymap.set("n", "H", "^", opt)
vim.keymap.set("n", "L", "$", opt)

-- file tree
vim.keymap.set("n", "<leader>ue", ":NvimTreeToggle<CR>", opt)
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFile<CR>", opt)

-- telescope
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>o", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>ss", builtin.lsp_document_symbols, { desc = "Find Symbols" })

vim.keymap.set("n", "<leader>gc", builtin.git_branches, { desc = "Git Branches" })

-- buffer line
vim.keymap.set("n", "K", ":BufferLineCycleNext<CR>", opt)
vim.keymap.set("n", "J", ":BufferLineCyclePrev<CR>", opt)

-- substitute
vim.keymap.set("n", "cx", require("substitute.exchange").operator, { noremap = true })
vim.keymap.set("n", "cxx", require("substitute.exchange").line, { noremap = true })
vim.keymap.set("x", "C", require("substitute.exchange").visual, { noremap = true })
vim.keymap.set("n", "cxc", require("substitute.exchange").cancel, { noremap = true })

-- format
--
--
-- copilot
vim.keymap.set("i", "<Tab>", function()
	if require("copilot.suggestion").is_visible() then
		require("copilot.suggestion").accept()
	else
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
	end
end, {
	silent = true,
})
