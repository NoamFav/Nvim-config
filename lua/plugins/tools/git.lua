return {
	-- Git Blame
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

	-- DiffView
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			hooks = {
				diff_buf_read = function()
					vim.opt_local.wrap = false
					vim.opt_local.list = false
				end,
			},
		},
	},

	-- GitSigns
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = {
				add = { text = "" }, -- Plus sign for added lines
				change = { text = "" }, -- Dot icon for changed lines
				delete = { text = "✘" }, -- Cross icon for deleted lines
				topdelete = { text = "" }, -- Arrow up for topdelete
				changedelete = { text = "" }, -- Circular arrow for changed + deleted
			},
		},
	},

	-- Git Conflict
	{
		"akinsho/git-conflict.nvim",
		event = "VeryLazy",
		opts = {
			default_mappings = true,
			highlights = {
				incoming = "DiffText",
				current = "DiffAdd",
			},
			disable_diagnostics = true,
		},
	},
}
