return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = true,
	opts = {
		flavour = "mocha",
		styles = {
			comments = { "italic" },
			functions = { "italic" },
			keywords = { "italic" },
			variables = { "NONE" },
		},
		integrations = {
			treesitter = true,
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = "italic",
					hints = "italic",
					warnings = "italic",
					information = "italic",
				},
				underlines = {
					errors = "underline",
					hints = "underline",
					warnings = "underline",
					information = "underline",
				},
			},
			lsp_trouble = true,
			cmp = true,
			telescope = true,
			gitsigns = true,
			nvimtree = true,
			which_key = true,
		},
	},
}
