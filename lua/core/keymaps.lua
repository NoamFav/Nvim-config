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
keymap("n", "<leader>dn", vim.diagnostic.goto_next, opts)
keymap("n", "<leader>dp", vim.diagnostic.goto_prev, opts)
keymap("n", "<leader>df", vim.lsp.buf.format, opts)
keymap("n", "<leader>qf", vim.lsp.buf.code_action, opts)

-- File explorer (NvimTree)
keymap("n", "<C-n>", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>r", ":NvimTreeRefresh<CR>", opts)
keymap("n", "<leader>n", ":NvimTreeFindFile<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
keymap("n", "<leader>gf", ":Telescope git_files<CR>", opts)
keymap("n", "<leader>gs", ":Telescope grep_string<CR>", opts)
keymap("n", "<leader>fd", ":Telescope diagnostics<CR>", opts)

-- Terminal
keymap("n", "<C-t>", ":ToggleTerm<CR>", opts)

-- Tagbar
keymap("n", "<leader>t", ":TagbarToggle<CR>:wincmd l<CR>", opts)

-- Semantic Highlight
keymap("n", "<Leader>s", ":SemanticHighlightToggle<cr>", opts)

-- Maven shortcuts
keymap("n", "<leader>mi", ":!mvn clean install<CR>", opts)
keymap("n", "<leader>mk", ":!mvn clean package<CR>", opts)
keymap("n", "<leader>mc", ":!mvn clean<CR>", opts)
keymap("n", "<leader>mt", ":!mvn test<CR>", opts)
keymap("n", "<leader>me", ":!mvn exec:exec<CR>", opts)
keymap("n", "<leader>mf", ":!mvn javafx:run<CR>", opts)
keymap("n", "<leader>mj", ":!mvn javadoc:javadoc<CR>", opts)

-- CMake shortcuts
keymap("n", "<leader>cc", ":!cmake .<CR>", opts)
keymap("n", "<leader>cm", ":!cmake --build .<CR>", opts)
keymap("n", "<leader>cr", ":!cmake --build . --target run<CR>", opts)
keymap("n", "<leader>ct", ":!ctest<CR>", opts)
keymap("n", "<leader>cb", ":!cmr<CR>", opts)

-- MATLAB
keymap("n", "<leader>rm", ":w<CR>:!matlab -nojvm -nosplash -nodesktop -r \"run('%:p')\"<CR>", opts)

-- Copilot
vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
	expr = true,
	replace_keycodes = false,
	silent = true,
})
vim.keymap.set("i", "<C-K>", "copilot#Dismiss()", {
	expr = true,
	replace_keycodes = false,
	silent = true,
})
