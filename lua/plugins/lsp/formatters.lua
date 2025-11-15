return {
	-- Mason Tool Installer
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"prettierd",
				"black",
				"isort",
				"stylua",
				"clang-format",
				"csharpier",
				"google-java-format",
				"ktlint",
				"shfmt",
				"beautysh",
				"rustywind",
				"gofumpt",
				"sqlfmt",
				"xmlformatter",
				"latexindent",
			},
			auto_update = true,
			run_on_start = true,
		},
	},

	-- Formatter
	{
		"mhartington/formatter.nvim",
		event = "VeryLazy",
		opts = function()
			local util = require("formatter.util")
			return {
				filetype = {
					javascript = { require("formatter.filetypes.javascript").prettier },
					typescript = { require("formatter.filetypes.javascript").prettier },
					javascriptreact = { require("formatter.filetypes.javascript").prettier },
					typescriptreact = { require("formatter.filetypes.typescript").prettier },
					python = { require("formatter.filetypes.python").black },
					lua = { require("formatter.filetypes.lua").stylua },
					cpp = { require("formatter.filetypes.cpp").clangformat },
					c = { require("formatter.filetypes.c").clangformat },

					cs = {
						function()
							return { exe = "dotnet-csharpier", args = { "--write-stdout" }, stdin = true }
						end,
					},
					java = { require("formatter.filetypes.java").google_java_format },
					sh = { require("formatter.filetypes.sh").shfmt },
					rust = { require("formatter.filetypes.rust").rustfmt },
					go = { require("formatter.filetypes.go").gofmt },
					html = { require("formatter.filetypes.html").prettier },
					css = { require("formatter.filetypes.css").prettier },
					json = { require("formatter.filetypes.json").prettier },
					yaml = { require("formatter.filetypes.yaml").prettier },
					toml = { require("formatter.filetypes.toml").prettier },
					markdown = { require("formatter.filetypes.markdown").prettier },
					sql = {
						function()
							return { exe = "sqlfmt", args = { "-" }, stdin = true }
						end,
					},
					xml = {
						function()
							return { exe = "xmlformatter", args = { "-" }, stdin = true }
						end,
					},
					latex = {
						function()
							return { exe = "latexindent", args = { "-" }, stdin = true }
						end,
					},
					dockerfile = {
						function()
							return {
								exe = "dockerfilelint",
								args = { vim.api.nvim_buf_get_name(0) },
								stdin = true,
							}
						end,
					},
					arduino = {
						function()
							return {
								exe = "clang-format",
								args = { "--assume-filename=sketch.ino" },
								stdin = true,
							}
						end,
					},
				},
			}
		end,
	},
}
