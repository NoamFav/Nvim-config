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
		hijack_cursor = true,
		sync_root_with_cwd = true,
		update_focused_file = { enable = true, update_cwd = false },
		view = { adaptive_size = true, side = "left", width = 34 },
		git = { enable = true, ignore = false, show_on_dirs = true, timeout = 400 },
		renderer = {
			root_folder_label = false,
			highlight_git = true,
			highlight_opened_files = "name",
			indent_markers = { enable = true, inline_arrows = true },
			icons = {
				webdev_colors = true,
				glyphs = {
					default = "",
					symlink = "",
					modified = "●",
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
		filters = { dotfiles = false, custom = { "^\\.DS_Store$" } },
		actions = {
			open_file = { resize_window = true, quit_on_open = false },
			change_dir = { enable = true, global = true },
		},
	},
}
