-- Dashboard
return {
	"nvimdev/dashboard-nvim",
	config = function()
		require("dashboard").setup({
			theme = "hyper", -- or 'doom'
			config = {
				week_header = { enable = true },
				shortcut = {
					{ desc = "Update", group = "@property", action = "Lazy update", key = "u" },
					{
						icon = " ",
						icon_hl = "@variable",
						desc = "Files",
						group = "Label",
						action = "Telescope find_files",
						key = "f",
					},
					{ desc = "Apps", group = "DiagnosticHint", action = "Telescope app", key = "a" },
					{ desc = "Dotfiles", group = "Number", action = "Telescope dotfiles", key = "d" },
				},
			},
		})
		vim.api.nvim_set_keymap("n", "<leader>db", ":Dashboard<CR>", { noremap = true, silent = true })
	end,
}
