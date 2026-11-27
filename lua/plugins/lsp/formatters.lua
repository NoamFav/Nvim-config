return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			-- isort/beautysh/rustywind used to be here too, dropped them —
			-- nothing below ever actually calls them, formatter.nvim uses
			-- ruff/shfmt/rustfmt instead. codelldb/delve aren't formatters at
			-- all, but mason-tool-installer installs any mason package and
			-- this is the one list that already auto-updates on start
			ensure_installed = {
				"prettierd",
				"ruff",
				"stylua",
				"clang-format",
				"taplo",
				"csharpier",
				"google-java-format",
				"ktlint",
				"shfmt",
				"gofumpt",
				"sqlfmt",
				"xmlformatter",
				"latexindent",
				"codelldb",
				"delve",
			},
			auto_update = true,
			run_on_start = true,
		},
	},

	{
		"mhartington/formatter.nvim",
		event = "VeryLazy",
		opts = function()
			return {
				filetype = {
					javascript = { require("formatter.filetypes.javascript").prettier },
					typescript = { require("formatter.filetypes.javascript").prettier },
					javascriptreact = { require("formatter.filetypes.javascript").prettier },
					typescriptreact = { require("formatter.filetypes.typescript").prettier },
					-- ruff format, black-compatible minus the venv; --stdin-filename is
					-- how it finds ruff.toml/pyproject.toml when the code comes in on stdin
					python = {
						function()
							local util = require("formatter.util")
							return {
								exe = "ruff",
								args = {
									"format",
									"--stdin-filename",
									util.escape_path(util.get_current_buffer_file_path()),
									"-",
								},
								stdin = true,
							}
						end,
					},
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
					toml = { require("formatter.filetypes.toml").taplo },
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
					-- .ino is just C++ wearing a costume, clang-format needs a
					-- fake filename or it won't recognize the syntax
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
