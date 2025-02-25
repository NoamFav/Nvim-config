return {
	-- Color scheme
	{
		"navarasu/onedark.nvim",
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},
	{
		"akai54/2077.nvim",
	},
	{
		"sainnhe/sonokai",
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},
	{
		"folke/tokyonight.nvim",
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},

	{ "maxmellon/vim-jsx-pretty" },

	-- Utilities
	{ "nvim-lua/plenary.nvim" },
	{ "lewis6991/impatient.nvim" },

	-- GitHub Copilot
	{ "github/copilot.vim" },

	-- QuickAction
	{ "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" },

	-- Markdown Preview
	{ "ellisonleao/glow.nvim", config = true, cmd = "Glow" },

	-- Snippets
	{ "L3MON4D3/LuaSnip" },

	{ "folke/trouble.nvim", dependencies = { "kyazdani42/nvim-web-devicons" } },

	-- Commenting
	{ "numToStr/Comment.nvim" },

	-- Gradle
	{ "tfnico/vim-gradle" },

	-- KeyBindings
	{ "folke/which-key.nvim" },

	{ "akinsho/toggleterm.nvim" },

	-- todo-comments
	{ "folke/todo-comments.nvim" },

	-- Harpoon
	{ "ThePrimeagen/harpoon" },

	-- OmniSharp Extended
	{
		"Hoffs/omnisharp-extended-lsp.nvim",
		lazy = true,
		event = { "BufReadPre *.cs", "BufNewFile *.cs" },
	},

	{ "daeyun/vim-matlab" },

	-- MarkView (Markdown Preview)
	{ "OXY2DEV/markview.nvim" },

	{ "NoamFav/apple_music.nvim" },
	{ "Matchiye/noisemachine.nvim", dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" } },
}
