return {
	-- Utilities
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- Simple plugins without config
	{ "tfnico/vim-gradle" },
	{ "NoamFav/Zarya.nvim" },
	{ "jaxbot/semantic-highlight.vim" },
	{ "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" },
	{ "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
	{ "OXY2DEV/markview.nvim" },
	{ "folke/todo-comments.nvim" },
	{ "preservim/tagbar" },
	{ import = "plugins.ui" },
	{ import = "plugins.editor" },
	{ import = "plugins.coding" },
	{ import = "plugins.lsp" },
	{ import = "plugins.tools" },
	{ import = "plugins.lang" },
}
