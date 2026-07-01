local opt = vim.opt
local g = vim.g

-- Appearance
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"

-- Behavior
opt.mouse = "a"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.updatetime = 300
opt.timeoutlen = 400

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Files
opt.swapfile = true
opt.backup = true
opt.writebackup = true
opt.undofile = true
opt.backupdir = vim.fn.expand("~/.logs/nvim/backup")
opt.directory = vim.fn.expand("~/.logs/nvim/swap")
opt.undodir = vim.fn.expand("~/.logs/nvim/undo")

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8

-- 42 identity (used by 42-header.nvim & the norminette workflow)
g.user42 = "nfavier"
g.mail42 = "nfavier@student.42.fr"
