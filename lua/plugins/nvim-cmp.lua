return {
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body) -- Requires `vim-vsnip` to be installed
					end,
				},
				mapping = {
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "vsnip" }, -- Needs `cmp-vsnip`
				}, {
					{ name = "buffer" },
				}),
			})

			-- Setup completion for command line
			cmp.setup.cmdline("/", {
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},

	{ "hrsh7th/cmp-nvim-lsp" }, -- LSP source for nvim-cmp
	{ "hrsh7th/cmp-buffer" }, -- Buffer source for nvim-cmp
	{ "hrsh7th/cmp-path" }, -- Path source for nvim-cmp
	{ "hrsh7th/cmp-cmdline" }, -- Cmdline source for nvim-cmp
	{ "hrsh7th/vim-vsnip" }, -- Snippet engine
	{ "hrsh7th/cmp-vsnip" }, -- Snippet source for nvim-cmp
}
