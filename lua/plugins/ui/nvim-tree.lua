return {
	"nvim-tree/nvim-tree.lua",
	cmd = { "NvimTreeToggle", "NvimTreeFocus" },
	keys = {
		{ "<C-n>", ":NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
		{ "<leader>r", ":NvimTreeRefresh<CR>", desc = "Refresh NvimTree" },
		{ "<leader>n", ":NvimTreeFindFile<CR>", desc = "Find File in NvimTree" },
		{
			"<C-,>",
			function()
				local view = require("nvim-tree.view")
				if not view.is_visible() then
					vim.cmd("NvimTreeToggle")
					return
				end
				if vim.api.nvim_get_current_win() == view.get_winnr() then
					vim.cmd("wincmd p")
				else
					vim.cmd(view.get_winnr() .. "wincmd w")
				end
			end,
			desc = "Toggle NvimTree Focus",
		},
	},
	opts = {
		update_focused_file = {
			enable = true,
			update_cwd = false,
		},
		sync_root_with_cwd = true,
		git = {
			enable = true,
			ignore = false,
		},
		renderer = {
			icons = {
				glyphs = {
					default = "",
					symlink = "",
					git = {
						unstaged = "✗",
						staged = "✓",
						unmerged = "",
						renamed = "➜",
						untracked = "★",
						deleted = "",
						ignored = "◌",
					},
					folder = {
						arrow_open = "",
						arrow_closed = "",
						default = "",
						open = "",
						empty = "",
						empty_open = "",
						symlink = "",
						symlink_open = "",
					},
				},
			},
		},
	},
}
