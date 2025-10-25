return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-media-files.nvim",
		},
		keys = {
			{ "<leader>ff", ":Telescope find_files<CR>", desc = "Find Files" },
			{ "<leader>fg", ":Telescope live_grep theme=ivy<CR>", desc = "Live Grep" },
			{ "<leader>fb", ":Telescope buffers theme=dropdown<CR>", desc = "Buffers" },
			{ "<leader>fh", ":Telescope help_tags theme=dropdown<CR>", desc = "Help Tags" },
			{ "<leader>gf", ":Telescope git_files<CR>", desc = "Git Files" },
			{ "<leader>gs", ":Telescope grep_string theme=ivy<CR>", desc = "Grep String" },
			{ "<leader>fd", ":Telescope diagnostics theme=ivy<CR>", desc = "Diagnostics" },
		},
		opts = {
			defaults = {
				prompt_prefix = "  ",
				selection_caret = " ",
				entry_prefix = "  ",
				color_devicons = true,
				path_display = { "truncate" },
				sorting_strategy = "ascending",
				layout_strategy = "flex",
				layout_config = {
					horizontal = { prompt_position = "top", preview_width = 0.55, width = 0.95, height = 0.85 },
					vertical = { prompt_position = "top", width = 0.9, height = 0.95, preview_height = 0.45 },
					flex = { flip_columns = 140 },
				},
				winblend = 0,
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },

				file_ignore_patterns = { "node_modules/.*" },
				mappings = {
					i = {
						["<CR>"] = function(prompt_bufnr)
							local actions = require("telescope.actions")
							local action_state = require("telescope.actions.state")
							local picker = action_state.get_current_picker(prompt_bufnr)
							local multi = picker:get_multi_selection()
							if vim.tbl_isempty(multi) then
								actions.select_default(prompt_bufnr)
							else
								actions.close(prompt_bufnr)
								for i, entry in ipairs(multi) do
									vim.cmd(string.format("badd %s", entry.value))
									if i == 1 then
										vim.cmd(string.format("buffer! %s", entry.value))
									end
								end
							end
						end,
						["<Tab>"] = require("telescope.actions").toggle_selection
							+ require("telescope.actions").move_selection_next,
						["<S-Tab>"] = require("telescope.actions").toggle_selection
							+ require("telescope.actions").move_selection_previous,
					},
				},
			},
			pickers = {
				find_files = { hidden = true, follow = true },
				buffers = { sort_lastused = true, ignore_current_buffer = true },
			},
			extensions = {
				media_files = { filetypes = { "png", "jpg", "jpeg", "gif", "mp4", "webm", "pdf" }, find_cmd = "rg" },
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("media_files")
		end,
	},
	{ "nvim-telescope/telescope-media-files.nvim", lazy = true },
}
