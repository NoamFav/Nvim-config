  -- Syntax Highlighting & Language Support (Treesitter)
return { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate',
ensure_installed = "all",
highlight = {
	enable = true,
}
}
