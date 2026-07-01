local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Buffer navigation
keymap("n", "<leader>bn", ":bnext<CR>", opts)
keymap("n", "<leader>bp", ":bprev<CR>", opts)
keymap("n", "<leader>bd", ":bdelete<CR>", opts)

-- Tab navigation
keymap("n", "<leader>tn", ":tabnext<CR>", opts)
keymap("n", "<leader>tp", ":tabprev<CR>", opts)
keymap("n", "<leader>to", ":tabnew<CR>", opts)
keymap("n", "<leader>tc", ":tabclose<CR>", opts)

-- Page navigation
keymap("n", "<leader>pd", "<PageDown>", opts)
keymap("n", "<leader>pu", "<PageUp>", opts)

-- LSP keymaps
keymap("n", "K", ":Lspsaga hover_doc<CR>", opts)
keymap("n", "<leader>rn", ":Lspsaga rename<CR>", opts)
keymap("n", "<leader>ca", ":CodeActionMenu<CR>", opts)
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic" })

vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })
keymap("n", "<leader>df", vim.lsp.buf.format, opts)
keymap("n", "<leader>qf", vim.lsp.buf.code_action, opts)

-- Terminal
keymap("n", "<C-t>", ":ToggleTerm<CR>", opts)

-- yank/paste to system clipboard without enabling unnamedplus
keymap({ "n", "x" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
keymap("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
keymap("n", "<leader>p", [["+p]], { desc = "Paste from system clipboard" })
keymap("n", "<leader>P", [["+P]], { desc = "Paste before from system clipboard" })

keymap("n", "<leader>cf", ":!c_formatter_42 %<CR>:edit!<CR>", opts)
