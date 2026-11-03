return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		dependencies = { "williamboman/mason.nvim" },
		opts = function()
			-- 42 branch: only the target languages, home quota is ~5GB.
			-- go/rust format via their own toolchains (gofmt/rustfmt).
			-- codelldb (~150MB) isn't auto-installed: `:MasonInstall codelldb`
			-- the day you actually need the debugger
			local tools = { "prettier", "black", "stylua", "taplo", "shfmt" }
			-- the cluster ships clang-format, mason's copy is just a duplicate
			if vim.fn.executable("clang-format") == 0 then
				table.insert(tools, "clang-format")
			end
			return {
				ensure_installed = tools,
				auto_update = true,
				run_on_start = true,
			}
		end,
	},

	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvimtools/none-ls-extras.nvim",
		},
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					-- downgraded to HINT, pyright's actual errors shouldn't have
					-- to compete with flake8 opinions for attention
					require("none-ls.diagnostics.flake8").with({
						diagnostics_postprocess = function(diagnostic)
							diagnostic.severity = vim.diagnostic.severity.HINT
						end,
					}),
				},
			})
		end,
	},

	{
		"mhartington/formatter.nvim",
		event = "VeryLazy",
		opts = function()
			return {
				filetype = {
					python = { require("formatter.filetypes.python").black },
					lua = { require("formatter.filetypes.lua").stylua },
					cpp = { require("formatter.filetypes.cpp").clangformat },
					c = { require("formatter.filetypes.c").clangformat },
					sh = { require("formatter.filetypes.sh").shfmt },
					rust = { require("formatter.filetypes.rust").rustfmt },
					go = { require("formatter.filetypes.go").gofmt },
					json = { require("formatter.filetypes.json").prettier },
					yaml = { require("formatter.filetypes.yaml").prettier },
					toml = { require("formatter.filetypes.toml").taplo },
				},
			}
		end,
	},
}
