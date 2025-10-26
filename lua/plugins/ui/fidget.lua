return {
	"j-hui/fidget.nvim",
	event = "LspAttach",
	opts = {
		progress = {
			suppress_on_insert = true,
			ignore_done_already = true,
			ignore_empty_message = true,
			ignore = { "tailwindcss", "ltex", "eslint" }, -- silence noisy LSPs

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

		notification = {
			override_vim_notify = true,

			filter = vim.log.levels.INFO,
			history_size = 100,

			redirect = false,

			view = {
				stack_upwards = true,
				reflow = false,
				icon_separator = " ",
				group_separator = " ",
				group_separator_hl = "Comment",
				line_margin = 1,
				render_message = function(msg, cnt)
					return cnt == 1 and msg or ("(" .. cnt .. "x) " .. msg)
				end,
			},

			window = {
				border = "rounded",
				normal_hl = "Comment",
				winblend = 0, -- keep opaque so transparent UIs look clean
				zindex = 60,
				align = "bottom", -- bottom-right
				relative = "editor",
				x_padding = 1,
				y_padding = 0,
				max_width = 0,
				max_height = 0,
			},
		},

		integration = { ["nvim-tree"] = { enable = false } },
	},
}
