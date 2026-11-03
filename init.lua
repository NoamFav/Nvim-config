-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.termguicolors = true

-- Load core configuration
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.diagnostics")
require("core.norminette").setup()
require("core.semantic_tokens").setup()
require("core.rainbow_var").setup()

-- Setup lazy.nvim
require("lazy").setup("plugins", {
	defaults = { lazy = true },
	install = { colorscheme = { "tokyonight" } },
	checker = { enabled = true },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

-- after lazy.setup(): tokyonight.nvim is lazy=false, so it's loaded by now
vim.cmd.colorscheme("tokyonight-night")
