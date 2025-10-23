return {
	"akinsho/toggleterm.nvim",
	cmd = "ToggleTerm",
	keys = {
		{ "<C-t>", ":ToggleTerm<CR>", desc = "Toggle Terminal" },
	},
	opts = {
		size = 20,
		open_mapping = [[<C-t>]],
		hide_numbers = true,
		shade_terminals = true,
		shading_factor = 2,
		start_in_insert = true,
		insert_mappings = true,
		terminal_mappings = true,
		persist_size = true,
		direction = "float",
		close_on_exit = true,
		shell = vim.o.shell,
		float_opts = {
			border = "curved",
			winblend = 0,
		},
	},
}
