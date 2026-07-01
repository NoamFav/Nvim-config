return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter").setup()

			-- install parsers (main branch API) — 42 focus + config editing
			require("nvim-treesitter").install({
				"c",
				"cpp",
				"bash",
				"make",
				"lua",
				"vim",
				"vimdoc",
				"markdown",
				"comment",
			})

			-- enable highlight + indent per-filetype (main branch style)
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local ft = args.match
					local langs = {
						c = true,
						cpp = true,
						bash = true,
						sh = true,
						make = true,
						lua = true,
						vim = true,
						vimdoc = true,
						markdown = true,
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
