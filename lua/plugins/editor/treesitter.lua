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

			-- turtle here is for the *.ttl override in core/autocmds.lua
			require("nvim-treesitter").install({
				"lua",
				"bash",
				"vim",
				"swift",
				"go",
				"rust",
				"c_sharp",
				"vimdoc",
				"python",
				"javascript",
				"typescript",
				"c",
				"cpp",
				"java",
				"turtle",
			})

			-- opt-in per filetype, see the branch comment above for why
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local ft = args.match
					local langs = {
						lua = true,
						bash = true,
						swift = true,
						go = true,
						rust = true,
						c_sharp = true,
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
