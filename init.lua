local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

vim.cmd("source ~/.config/nvim/keymaps.vim")

vim.g.copilot_enabled = false

vim.diagnostic.config({
	virtual_text = true,
	update_in_insert = true,
	severity_sort = true,
})
vim.filetype.add({ extension = { ino = "arduino" } })

vim.g.OmniSharp_server_use_mono = 0

local harpoon = require("harpoon")
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

-- Add a file to Harpoon's quick access list
vim.api.nvim_set_keymap(
	"n",
	"<leader>a",
	"<cmd>lua require('harpoon.mark').add_file()<CR>",
	{ noremap = true, silent = true }
)

-- Open Harpoon's quick access menu
vim.api.nvim_set_keymap(
	"n",
	"<leader>h",
	"<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>",
	{ noremap = true, silent = true }
)

-- Navigate to files by Harpoon index
vim.api.nvim_set_keymap(
	"n",
	"<leader>1",
	"<cmd>lua require('harpoon.ui').nav_file(1)<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>2",
	"<cmd>lua require('harpoon.ui').nav_file(2)<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>3",
	"<cmd>lua require('harpoon.ui').nav_file(3)<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>4",
	"<cmd>lua require('harpoon.ui').nav_file(4)<CR>",
	{ noremap = true, silent = true }
)
