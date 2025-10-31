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
		"NoamFav/2077.nvim",
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
			style = "night",
			transparent = true,
			terminal_colors = true,
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				sidebars = "transparent",
				floats = "transparent",
			},
			lualine_bold = true,
			on_highlights = function(hl, c)
				-- make floats/globals super clean
				hl.NormalFloat = { bg = "NONE" }
				hl.FloatBorder = { fg = c.border_highlight or c.blue, bg = "NONE" }
				hl.FloatTitle = { fg = c.blue, bold = true, bg = "NONE" }
				hl.Pmenu = { bg = "NONE" }
				hl.PmenuSel = { bg = c.bg_highlight, bold = true }
				hl.CursorLine = { bg = c.bg_highlight }
				hl.WinSeparator = { fg = c.bg_highlight }

				-- subtle inlay hints & diagnostics
				hl.LspInlayHint = { fg = c.comment, bg = "NONE", italic = true }
				hl.DiagnosticUnderlineError = { sp = c.red, undercurl = true }
				hl.DiagnosticUnderlineWarn = { sp = c.yellow, undercurl = true }
				hl.DiagnosticUnderlineInfo = { sp = c.blue, undercurl = true }
				hl.DiagnosticUnderlineHint = { sp = c.teal, undercurl = true }
			end,
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
				snacks = {
					enabled = true,
					indent_scope_color = "",
				},
			},
		},
	},
}
