return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter").setup()

			-- install parsers (main branch API)
			require("nvim-treesitter").install({
				"lua",
				"vim",
				"vimdoc",
				"python",
				"javascript",
				"typescript",
				"c",
				"cpp",
				"java",
				"turtle",
			})

			-- enable highlight + indent per-filetype (main branch style)
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local ft = args.match
					local langs = {
						lua = true,
						vim = true,
						vimdoc = true,
						python = true,
						javascript = true,
						typescript = true,
						c = true,
						cpp = true,
						java = true,
						turtle = true,
					}
					if langs[ft] then
						pcall(vim.treesitter.start)
						-- treesitter-based indentexpr (optional)
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})

			-- folding via treesitter
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.opt.foldlevel = 99
		end,
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = "BufReadPost",
		config = function()
			local rainbow_delimiters = require("rainbow-delimiters")
			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					vim = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			}
		end,
	},
}
