-- Syntax Highlighting & Language Support (Treesitter)
return {
	-- Treesitter with rainbow coloring
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		ensure_installed = "all",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				rainbow = {
					enable = true,
					extended_mode = true,
					max_file_lines = nil,
				},
				fold = {
					enable = true,
					config = function()
						vim.cmd("set foldmethod=expr")
						vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
						vim.o.foldlevel = 99 -- Automatically unfold everything on startup
					end,
				},
			})
		end,
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		config = function()
			local rainbow_delimiters = require("rainbow-delimiters")

			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					vim = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			}
		end,
	},

	{ "jaxbot/semantic-highlight.vim" },
}
