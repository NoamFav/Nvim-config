return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			theme = "auto", -- follow active colorscheme
			globalstatus = true,
			disabled_filetypes = { "snacks_dashboard" },
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
			always_divide_middle = true,
			icons_enabled = true,
		},
		sections = {
			lualine_a = { {
				"mode",
				fmt = function(str)
					return str:sub(1, 1)
				end,
			} },
			lualine_b = { { "branch", icon = "" }, "diff" },
			lualine_c = {
				{ "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } },
				{ "filename", path = 1, symbols = { modified = " ", readonly = " " } },
			},
			lualine_x = { { "filetype", icon_only = true }, "encoding", "fileformat" },
			lualine_y = { { "progress" } },
			lualine_z = { { "location" } },
		},
		tabline = {
			lualine_a = { { "buffers", use_mode_colors = true, symbols = { alternate_file = "" } } },
			lualine_z = { { "tabs", use_mode_colors = true } },
		},
		extensions = { "nvim-tree", "quickfix", "fugitive" },
	},
}
