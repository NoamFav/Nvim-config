-- Debugger: nvim-dap + dap-ui, with dap-go for Go and codelldb for C.
-- Install codelldb via :MasonInstall codelldb.
return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"leoluz/nvim-dap-go",
	},
	keys = {
		{ "<leader>db", desc = "Toggle breakpoint" },
		{ "<leader>dc", desc = "Continue" },
		{ "<leader>di", desc = "Step into" },
		{ "<leader>do", desc = "Step over" },
		{ "<leader>du", desc = "Toggle dap-ui" },
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")
		dapui.setup()
		require("dap-go").setup()

		-- C via codelldb (installed through Mason)
		local codelldb_path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = codelldb_path,
				args = { "--port", "${port}" },
			},
		}
		dap.configurations.c = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
			},
		}

		dap.listeners.after.event_initialized["dapui"] = dapui.open
		dap.listeners.before.event_terminated["dapui"] = dapui.close

		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
		vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
		vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle dap-ui" })
	end,
}
