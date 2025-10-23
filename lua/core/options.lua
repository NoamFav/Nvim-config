local opt = vim.opt
local g = vim.g

-- Appearance
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"

-- Behavior
opt.mouse = "a"
opt.clipboard = "unnamedplus"
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
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.undodir = vim.fn.expand("~/.config/nvim/undo")

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Global variables
g.copilot_enabled = false
g.OmniSharp_server_use_mono = 0
