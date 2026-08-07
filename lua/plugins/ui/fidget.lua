return {
	"j-hui/fidget.nvim",
	event = "LspAttach",
	opts = {
		progress = {
			suppress_on_insert = true,
			ignore_done_already = true,
			ignore_empty_message = true,
			ignore = { "tailwindcss", "ltex", "eslint" }, -- no noisy LSPs left to silence

			display = {
				render_limit = 10,
				progress_ttl = math.huge,
				done_ttl = 0.8,
				progress_icon = { "dots" },
				done_icon = "",
				group_style = "Title",
				icon_style = "DiagnosticHint",
				skip_history = true,
			},
		},

		integration = { ["nvim-tree"] = { enable = false } },
	},
}
