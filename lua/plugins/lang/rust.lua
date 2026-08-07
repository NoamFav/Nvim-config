return {
	"mrcjkb/rustaceanvim",
	ft = { "rust" },
	init = function()
		-- this owns rust_analyzer's startup itself (see lsp/servers.lua and
		-- plugins/lsp/mason.lua for why rust_analyzer is excluded from the
		-- generic mason-lspconfig auto-enable), so it needs its own config
		-- table instead of a vim.lsp.config() entry like everything else
		vim.g.rustaceanvim = {
			server = {
				default_settings = {
					["rust-analyzer"] = {
						-- clippy instead of plain cargo check, more lints while learning
						check = { command = "clippy" },
						cargo = { allFeatures = true },
					},
				},
				on_attach = function(_, bufnr)
					-- :RustLsp debuggables opens a picker of binaries/tests to debug,
					-- same codelldb adapter as core C debugging in tools/dap.lua
					vim.keymap.set("n", "<leader>rd", "<cmd>RustLsp debuggables<cr>", {
						buffer = bufnr,
						desc = "Rust debuggables",
					})
				end,
			},
			-- same codelldb binary tools/dap.lua uses for C, mason-tool-installer keeps it installed
			dap = {
				adapter = {
					type = "server",
					port = "${port}",
					executable = {
						command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
						args = { "--port", "${port}" },
					},
				},
			},
		}
	end,
}
