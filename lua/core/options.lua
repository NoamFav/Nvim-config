local opt = vim.opt
local g = vim.g

-- Appearance
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
-- tab needs two chars (arrow + filler), eol is the return arrow; with
-- expandtab on, a → in a .py file means a real tab snuck in. trail/nbsp
-- only show up when a space is actually a problem: trailing ones get
-- flagged by flake8 and norminette, and a U+00A0 pasted from a subject
-- PDF looks like a space right up until python refuses to parse it
opt.list = true
opt.listchars = { tab = "→ ", eol = "↵", trail = "·", nbsp = "␣" }

-- Behavior
opt.mouse = "a"
-- noselect: nothing pre-picked, so <CR> never inserts a completion I didn't ask for
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
-- out of the project tree, so no more .swp files showing up in git status
-- or random directories because I opened a file from somewhere weird
opt.backupdir = vim.fn.expand("~/.logs/nvim/backup")
opt.directory = vim.fn.expand("~/.logs/nvim/swap")
opt.undodir = vim.fn.expand("~/.logs/nvim/undo")

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8

-- read by lua/plugins/lsp/header42.lua for the 42-header stamp
g.user = "nfavier"
g.mail = "noam.favier@learner.42.tech"
