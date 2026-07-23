return {
	{
		"maxmellon/vim-jsx-pretty",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	},
	{
		"luckasRanarison/tailwind-tools.nvim",
		ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			server = { override = false },
		},
	},
}
