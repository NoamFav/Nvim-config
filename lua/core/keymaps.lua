local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- window nav lives in smart-splits.nvim now (lua/plugins/tools/smart-splits.lua)

-- Maven shortcuts. <leader>m is overseer's make/42 territory, this is <leader>j
keymap("n", "<leader>ji", ":!mvn clean install<CR>", opts)
keymap("n", "<leader>jk", ":!mvn clean package<CR>", opts)
keymap("n", "<leader>jc", ":!mvn clean<CR>", opts)
keymap("n", "<leader>jt", ":!mvn test<CR>", opts)
keymap("n", "<leader>je", ":!mvn exec:exec<CR>", opts)
keymap("n", "<leader>jf", ":!mvn javafx:run<CR>", opts)
keymap("n", "<leader>jd", ":!mvn javadoc:javadoc<CR>", opts)

-- CMake shortcuts
keymap("n", "<leader>cc", ":!cmake .<CR>", opts)
keymap("n", "<leader>cm", ":!cmake --build .<CR>", opts)
keymap("n", "<leader>cr", ":!cmake --build . --target run<CR>", opts)
keymap("n", "<leader>ct", ":!ctest<CR>", opts)
keymap("n", "<leader>cb", ":!cmr<CR>", opts) -- cmr: my own build alias, not a typo

-- MATLAB, headless so it doesn't try to open a GUI over SSH
keymap("n", "<leader>rm", ":w<CR>:!matlab -nojvm -nosplash -nodesktop -r \"run('%:p')\"<CR>", opts)

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

-- LSP keymaps, K deliberately overridden — lspsaga's float beats the builtin one
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

-- yank/paste to system clipboard without enabling unnamedplus globally
-- (unnamedplus hijacks every delete too, didn't want that)
keymap({ "n", "x" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
keymap("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
keymap("n", "<leader>p", [["+p]], { desc = "Paste from system clipboard" })
keymap("n", "<leader>P", [["+P]], { desc = "Paste before from system clipboard" })

-- c_formatter_42 rewrites the file on disk, :edit! throws away the stale buffer
keymap("n", "<leader>cf", ":!c_formatter_42 %<CR>:edit!<CR>", opts)
