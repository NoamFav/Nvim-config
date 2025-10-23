return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			--theme = dofile(vim.fn.expand("~/2077.nvim/lua/lualine/themes/2077.lua")), -- IF you want to use 2077 theme (contact me for the file)
			theme = "tokyonight-night",
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = { "filename", "diagnostics" },
			lualine_x = { "encoding", "fileformat", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		tabline = {
			lualine_a = { { "buffers", use_mode_colors = true } },
			lualine_z = { { "tabs", use_mode_colors = true } },
		},
		extensions = {},
	},
}
