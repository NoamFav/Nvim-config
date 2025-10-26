return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		plugins = {
			marks = true,
			registers = true,
			spelling = { enabled = true, suggestions = 20 },
			presets = {
				operators = true,
				motions = true,
				text_objects = true,
				windows = true,
				nav = true,
				z = true,
				g = true,
			},
		},
		-- window is deprecated -> use win
		win = {
			border = "rounded",
			padding = { 2, 2, 2, 2 },
			no_overlap = false,
		},
		layout = {
			height = { min = 4, max = 25 },
			width = { min = 20, max = 50 },
			spacing = 3,
			align = "left",
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)

		wk.add({
			{ "<leader>b", group = "buffer" },
			{ "<leader>c", group = "code" },
			{ "<leader>d", group = "diagnostics" },
			{ "<leader>f", group = "find" },
			{ "<leader>g", group = "git" },
			{ "<leader>l", group = "lsp" },
			{ "<leader>m", group = "maven" },
			{ "<leader>n", group = "notifications" },
			{ "<leader>t", group = "tabs/terminal" },
			{ "<leader>x", group = "trouble" },
		})
	end,
}
