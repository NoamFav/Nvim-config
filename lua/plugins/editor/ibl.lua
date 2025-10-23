return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		indent = {
			highlight = { "Whitespace" },
			char = "│",
		},
		whitespace = {
			highlight = { "Whitespace" },
			remove_blankline_trail = false,
		},
		scope = {
			enabled = false,
		},
		exclude = {
			filetypes = { "dashboard", "NvimTree", "alpha", "snacks_dashboard" },
		},
	},
}
