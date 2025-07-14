return {
	"folke/trouble.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		position = "right", -- Position the diagnostic sidebar on the right
		height = 10, -- Only applies if position is 'bottom' (ignored when on the side)
		width = 40, -- Width when positioned on the right or left
		icons = { -- Custom icons for each diagnostic level
			error = "",
			warning = "",
			hint = "",
			information = "",
		},
		auto_close = true, -- Automatically close Trouble when there are no diagnostics
		auto_open = false, -- Prevent auto-opening Trouble
		use_diagnostic_signs = false, -- Use custom signs instead of LSP-provided signs
		padding = false, -- Remove padding for a more compact look
		action_keys = { -- Customize action keys for a more intuitive UX
			close = "q", -- Close Trouble window with 'q'
			cancel = "<esc>", -- Cancel an action with Escape
			refresh = "r", -- Refresh diagnostics
			jump = { "<cr>", "<tab>" }, -- Jump to diagnostic
		},
		fold_open = "", -- Icon for opening folded items
		fold_closed = "", -- Icon for closed folds
		indent_lines = false, -- Remove indent lines for a cleaner look
		auto_preview = false, -- Disable automatic preview to make it less intrusive
		signs = {
			error = "",
			warning = "",
			hint = "",
			information = "",
		},
		use_diagnostic_signs = true, -- Use the custom signs defined above
	},
	config = function(_, opts)
		require("trouble").setup(opts)
	end,
	keys = {
		-- Toggle diagnostics view on the right side
		{ "<leader>xx", ":Trouble diagnostics toggle focus=false <CR>", desc = "Toggle Diagnostics" },

		-- Toggle diagnostics for the current buffer only
		{ "<leader>xX", ":Trouble diagnostics toggle filter.buf=0<CR>", desc = "Toggle Diagnostics (Current Buffer)" },

		-- Toggle symbols view
		{ "<leader>cs", ":Trouble symbols toggle<CR>", desc = "Toggle Symbols" },

		-- Close Trouble
		{ "<leader>cc", ":Trouble close<CR>", desc = "Close Trouble" },

		-- Toggle LSP diagnostics view on the right side
		{
			"<leader>cl",
			":Trouble lsp toggle focus=false win.position=right<CR>",
			desc = "Toggle LSP (Right Position)",
		},

		-- Toggle location list
		{ "<leader>xL", ":Trouble loclist toggle<CR>", desc = "Toggle Location List" },

		-- Toggle quickfix list
		{ "<leader>xQ", ":Trouble qflist toggle<CR>", desc = "Toggle Quickfix List" },
	},
}
