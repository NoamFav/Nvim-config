return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true, auto_disable_lsp = true, auto_disable_treesitter = true },
		dashboard = {
			enabled = true,
			sections = {
				{ section = "header" },
				{ pane = 2, section = "terminal", cmd = "colorscript -e fade", height = 5, padding = 1 },
				{ section = "keys", gap = 1, padding = 1 },
				{ pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{
					pane = 2,
					icon = " ",
					title = "Git Status",
					section = "terminal",
					enabled = vim.fn.isdirectory(".git") == 1,
					cmd = "git status --short --branch",
					height = 5,
					padding = 1,
					ttl = 5 * 60,
					indent = 3,
				},
				{ section = "startup" },
			},
		},
		terminal = {
			enabled = true,
			float_opts = { border = "rounded", width = 0.85, height = 0.85, winblend = 0 },
		},
		image = {
			enabled = true,
			relative = "cursor",
			border = "rounded",
			focusable = false,
			backdrop = false,
			row = 1,
			col = 1,
		},
	},
}
