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
			{ "<leader>fg", ":Telescope live_grep<CR>", desc = "Live Grep" },
			{ "<leader>fb", ":Telescope buffers<CR>", desc = "Buffers" },
			{ "<leader>fh", ":Telescope help_tags<CR>", desc = "Help Tags" },
			{ "<leader>gf", ":Telescope git_files<CR>", desc = "Git Files" },
			{ "<leader>gs", ":Telescope grep_string<CR>", desc = "Grep String" },
			{ "<leader>fd", ":Telescope diagnostics<CR>", desc = "Diagnostics" },
		},
		opts = {
			defaults = {
				prompt_prefix = "  ",
				selection_caret = " ",
				entry_prefix = "  ",
				color_devicons = true,
				file_ignore_patterns = { "node_modules/.*" },
				mappings = {
					i = {
						["<CR>"] = function(prompt_bufnr)
							local actions = require("telescope.actions")
							local action_state = require("telescope.actions.state")
							local picker = action_state.get_current_picker(prompt_bufnr)
							local multi_selections = picker:get_multi_selection()

							if vim.tbl_isempty(multi_selections) then
								actions.select_default(prompt_bufnr)
							else
								actions.close(prompt_bufnr)
								for idx, entry in ipairs(multi_selections) do
									vim.cmd(string.format("badd %s", entry.value))
									if idx == 1 then
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
			extensions = {
				media_files = {
					filetypes = { "png", "jpg", "jpeg", "gif", "mp4", "webm", "pdf" },
					find_cmd = "rg",
				},
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("media_files")
		end,
	},
	{
		"nvim-telescope/telescope-media-files.nvim",
		lazy = true,
	},
}
