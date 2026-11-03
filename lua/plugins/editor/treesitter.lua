return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- main is the rewrite: no more auto-highlighting on setup(), every
		-- filetype needs its own vim.treesitter.start() below or nothing renders
		branch = "main",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter").setup()

			require("nvim-treesitter").install({
				"lua",
				"bash",
				"vim",
				"vimdoc",
				"c",
				"cpp",
				"python",
				"rust",
				"go",
				"json",
				"toml",
				"yaml",
				"dockerfile",
				"make",
			})

			-- opt-in per filetype, see the branch comment above for why
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local ft = args.match
					local langs = {
						lua = true,
						vim = true,
						vimdoc = true,
						c = true,
						cpp = true,
						python = true,
						rust = true,
						go = true,
						json = true,
						toml = true,
						yaml = true,
						dockerfile = true,
						make = true,
						bash = true,
						sh = true, -- bash parser, filetype is "sh"
					}
					if langs[ft] then
						pcall(vim.treesitter.start)
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})

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
					-- lua leans on do/end more than brackets, blocks is the
					-- query that actually has something to color
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
