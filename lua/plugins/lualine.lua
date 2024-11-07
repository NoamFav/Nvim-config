-- Status line
return {
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					--theme = dofile(vim.fn.expand("~/2077.nvim/lua/lualine/themes/2077.lua")),
					theme = "sonokai",
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
			})
		end,
	},
}
