return {
	-- Mason Tool Installer
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				-- 42: shell + a bit of Lua for this config. C uses c_formatter_42
				-- (installed via pip, not Mason).
				"stylua",
				"shfmt",
				"shellcheck",
				"bash-language-server",
			},
			auto_update = true,
			run_on_start = true,
		},
	},

	-- NOTE: no none-ls. Shell linting is handled by bash-language-server, which
	-- runs ShellCheck automatically when the `shellcheck` binary is on $PATH.

	-- Formatter
	{
		"mhartington/formatter.nvim",
		event = "VeryLazy",
		opts = function()
			-- c_formatter_42: the norminette-style formatter. With no filename it
			-- reads the buffer from stdin and writes the formatted result to stdout,
			-- which is exactly what formatter.nvim wants.
			local function c_formatter_42()
				return { exe = "c_formatter_42", args = {}, stdin = true }
			end

			return {
				filetype = {
					-- Enough Lua to keep this config tidy
					--lua = { require("formatter.filetypes.lua").stylua },

					-- Shell
					--sh = { require("formatter.filetypes.sh").shfmt },
					--bash = { require("formatter.filetypes.sh").shfmt },

					-- C / C++ — norm-compliant formatting only
					--c = { c_formatter_42 },
					--cpp = { c_formatter_42 },
				},
			}
		end,
	},
}
