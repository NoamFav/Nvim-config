return {
	-- Utilities
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- Simple plugins without config
	{ "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" },
	{ "folke/todo-comments.nvim" },
	{ "preservim/tagbar" },
	{ "tfnico/vim-gradle" },
	{ "NoamFav/Zarya.nvim", lazy = false },
	{ "jaxbot/semantic-highlight.vim" },
	{ "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
	{ "OXY2DEV/markview.nvim" },
	{ import = "plugins.ui" },
	{ import = "plugins.editor" },
	{ import = "plugins.coding" },
	{ import = "plugins.lsp" },
	{ import = "plugins.tools" },
	{ import = "plugins.lang" },
}
