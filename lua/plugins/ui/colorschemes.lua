return {
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
		lazy = false,
		priority = 1000,
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd.colorscheme("tokyonight-night")
		end,
	},
	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			variant = "default",
			transparent = true,
			saturation = 1,
			italic_comments = false,
			hide_fillchars = false,
			borderless_pickers = false,
			terminal_colors = true,
			cache = false,
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			flavour = "auto",
			background = {
				light = "latte",
				dark = "mocha",
			},
			transparent_background = true,
			show_end_of_buffer = false,
			term_colors = false,
			dim_inactive = {
				enabled = false,
				shade = "dark",
				percentage = 0.15,
			},
			no_italic = false,
			no_bold = false,
			no_underline = false,
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
			},
			integrations = {
				blink_cmp = true,
				nvimtree = true,
				treesitter = true,
				notify = true,
				harpoon = true,
				indent_blankline = true,
				mason = true,
				copilot_vim = true,
				snacks = {
					enabled = true,
					indent_scope_color = "",
				},
			},
		},
	},
}
