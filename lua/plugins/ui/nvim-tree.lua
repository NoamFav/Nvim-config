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
		respect_buf_cwd = true,
		update_focused_file = { enable = true, update_cwd = false },
		filesystem_watchers = { enable = true },

		view = {
			side = "left",
			width = 34,
			adaptive_size = true,
			float = { enable = false, quit_on_focus_loss = true, open_win_config = { border = "rounded" } },
		},

		git = { enable = true, ignore = false, show_on_dirs = true, timeout = 400 },

		diagnostics = {
			enable = true,
			show_on_dirs = true,
			icons = { hint = "", info = "", warning = "", error = "" },
		},

		renderer = {
			root_folder_label = false,
			group_empty = true,
			highlight_git = true,
			highlight_opened_files = "name",
			indent_width = 1,
			indent_markers = { enable = true, inline_arrows = true },
			icons = {
				webdev_colors = true,
				show = { folder_arrow = true, file = true, folder = true, git = true, modified = true },
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
			special_files = {},
		},

		modified = {
			enable = true,
			show_on_dirs = true,
			show_on_open_dirs = true,
		},

		filters = { dotfiles = false, custom = { "^\\.DS_Store$" } },

		actions = {
			change_dir = { enable = true, global = true },
			open_file = {
				resize_window = true,
				quit_on_open = false,
				window_picker = { enable = false },
			},
		},

		on_attach = function(bufnr)
			local api = require("nvim-tree.api")

			local function safe_map(lhs, rhs, desc)
				if type(rhs) == "function" or type(rhs) == "string" then
					vim.keymap.set(
						"n",
						lhs,
						rhs,
						{ buffer = bufnr, noremap = true, silent = true, desc = "Tree: " .. desc }
					)
				end
			end

			-- Open / navigate
			safe_map("l", api.node.open.edit, "Open")
			safe_map("<CR>", api.node.open.edit, "Open")
			safe_map("o", api.node.open.edit, "Open")
			safe_map("h", api.node.navigate.parent_close, "Close Dir")
			safe_map("v", api.node.open.vertical, "Open: vsplit")
			safe_map("s", api.node.open.horizontal, "Open: split")
			safe_map("t", api.node.open.tab, "Open: tab")

			-- Toggle/filter
			safe_map(".", api.tree.toggle_hidden_filter, "Toggle Dotfiles")
			safe_map("f", api.live_filter.start, "Live Filter")
			safe_map("F", api.live_filter.clear, "Clear Filter")
			safe_map("R", api.tree.reload, "Refresh")
			safe_map("q", api.tree.close, "Close")

			-- FS ops
			safe_map("a", api.fs.create, "Create")
			safe_map("d", api.fs.trash, "Trash") -- falls back if not available
			safe_map("D", api.fs.remove, "Delete")
			safe_map("r", api.fs.rename, "Rename")
			safe_map("x", api.fs.cut, "Cut")
			safe_map("p", api.fs.paste, "Paste")

			-- Copy helpers (use only functions guaranteed to exist)
			safe_map("y", api.fs.copy.node, "Copy Node")
			safe_map("Y", api.fs.copy.absolute_path, "Copy Abs Path")
			safe_map("gy", api.fs.copy.filename, "Copy Filename")
		end,
	},

	config = function(_, opts)
		vim.cmd([[
      highlight NvimTreeNormal       guibg=NONE ctermbg=NONE
      highlight NvimTreeNormalNC     guibg=NONE ctermbg=NONE
      highlight NvimTreeEndOfBuffer  guibg=NONE ctermbg=NONE
      highlight NvimTreeIndentMarker gui=nocombine
    ]])
		require("nvim-tree").setup(opts)
	end,
}
