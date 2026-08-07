return {
	{
		"f-person/git-blame.nvim",
		event = "VeryLazy",
		opts = {
			enabled = true,
			message_template = "<author> • <date> • <summary>",
		},
		config = function(_, opts)
			vim.g.gitblame_enabled = opts.enabled
			vim.g.gitblame_message_template = opts.message_template
		end,
	},

	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		keys = {
			{ "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diff View" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
		},
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- wrapped diff lines are unreadable, and whitespace symbols just add noise here
			hooks = {
				diff_buf_read = function()
					vim.opt_local.wrap = false
					vim.opt_local.list = false
				end,
			},
		},
	},

	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = {
				add = { text = "" },
				change = { text = "" },
				delete = { text = "✘" },
				topdelete = { text = "" },
				changedelete = { text = "" },
			},
		},
	},

	{
		"akinsho/git-conflict.nvim",
		event = "VeryLazy",
		opts = {
			default_mappings = true,
			highlights = {
				incoming = "DiffText",
				current = "DiffAdd",
			},
			-- otherwise every conflict marker gets diagnosed as broken syntax on top of everything else
			disable_diagnostics = true,
		},
	},
}
